----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:04 04/29/2020 
-- Design Name: 
-- Module Name:    processor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end processor;

architecture Behavioral of processor is

--import des composants

	component registers_bench 
    Port ( Addr_A : in  STD_LOGIC_VECTOR (3 downto 0);
           Addr_B : in  STD_LOGIC_VECTOR (3 downto 0);
           Addr_W : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component pipeline
    Port ( Clk : in  STD_LOGIC;
			  Op : in  STD_LOGIC_VECTOR (7 downto 0);
           A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           C : in  STD_LOGIC_VECTOR (7 downto 0);
           Out_OP : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_A : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_B : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_C : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component memory
    Port ( Addr : in  STD_LOGIC_VECTOR (7 downto 0);
           Val : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Val_Out : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component instructions
    Port ( Addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component alu
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0));
	end component;
	
	--instruction to pipe1
	signal OP : STD_LOGIC_VECTOR (31 downto 0);
	
	--Args
	signal A1, A2, A3, A4 : STD_LOGIC_VECTOR (7 downto 0);
	signal OP1, OP2, OP3, OP4 : STD_LOGIC_VECTOR (7 downto 0);
	signal B1, B1_mux, B2, B2_mux, B3, B3_mux, B4 : STD_LOGIC_VECTOR (7 downto 0);
	signal C1, C2 : STD_LOGIC_VECTOR (7 downto 0); 
	
	signal W, RW : STD_LOGIC;
	signal Ctrl_Alu : STD_LOGIC_VECTOR(2 downto 0);
	--outs
	signal QA, QB, S, Val_Out, Addr_mux : STD_LOGIC_VECTOR (7 downto 0);
	
	--Instruction Pointer
	signal IP : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	
begin

c_instructions: instructions PORT MAP (
		Addr  => IP,
		CLK 	=> CLK,
		Instr => OP
	);

--LI/DI
pipe1 : pipeline PORT MAP (
		CLK 	 => CLK,
		OP 	 => OP(31 downto 24),
		A		 =>  OP(23 downto 16),
		B 		 =>  OP(15 downto 8),
		C 		 =>  OP(7 downto 0),
		Out_OP => OP1,
		Out_A  => A1,
		Out_B  => B1,
		Out_C  => C1
	);
	
	
	
--banc de registres
c_registers : registers_bench PORT MAP (
		Addr_A => B1(3 downto 0),
      Addr_B => C1(3 downto 0),
      Addr_W => A4(3 downto 0),
		Data	 => B4,
      RST 	 => RST,
      CLK    => CLK,
      QA		 => QA,
		QB 	 => QB,
		W		 => W
	);


--DI/EX
pipe2 : pipeline PORT MAP (
		CLK 	 => CLK,
		OP 	 => OP1,
		A 		 => A1,
		B 		 => B1_mux,
		C 		 =>  QB,
		Out_OP => OP2,
		Out_A  => A2,
		Out_B  => B2,
		Out_C  => C2
	);
	

--UAL
c_alu : alu PORT MAP (	
		A => B2,
		B => C2,
		S => S,
		N => open,
		O => open,
		Z => open,
		C => open,
		Ctrl_ALU => Ctrl_Alu	
	);
	
--EX/MEM
pipe3 : pipeline PORT MAP (
		CLK 	 => CLK,
		OP 	 => OP2,
		A 		 => A2,
		B 		 => B2_mux,
		C 		 =>  (others => '0'),
		Out_OP => OP3,
		Out_A  => A3,
		Out_B  => B3,
		Out_C  => open
	);
	
--Memoire de données
c_memory : memory PORT MAP (
		Addr 		=> Addr_mux,
		Val  		=> B3,
		Val_Out  => Val_Out,
		RST 		=> RST, 
		CLK 		=> CLK,
		RW 		=> RW
);
	
	

--MEM/RE
pipe4 : pipeline PORT MAP (
		CLK => CLK,
		OP => OP3,
		A => A3,
		B => B3_mux,
		C =>  (others => '0'),
		Out_OP => OP4,
		Out_A => A4,
		Out_B => B4,
		Out_C => open
	);
	
	
	--banc de registres
	W <= '1' when (OP4>=X"01" and OP4<=X"07" ) else --AFC + COP + ALU + LOAD
		  '0';
	
	--mux1 B1_mux <= OP1, B1
	B1_mux <= B1 when (OP1=X"06" or OP1=X"07") else --AFC + LOAD 6> modif pas B
				 QA;  --COP, ALU, STORE -> lecture d'un registre
	
	--UAL
	Ctrl_Alu <= OP2(2 downto 0) when (OP2<X"04") else --ALU
					"000"; --do nothing
	
	--mux2 B2_mux <= S, B2, OP2
	B2_mux <= S when (OP2<X"04") else --ALU
				 B2; --do nothing
	
	
	--mux3 Addr_Mux <= A3, B3, OP3
	Addr_mux <= B3 when (OP3=X"07") else --LOAD
					A3; --STORE
	
	--mem
	RW <= '0' when (OP3=X"08") else --STORE
			'1';
	
	--mux4 B3_mux <= Val_Out, B3
	B3_mux <= Val_Out when (OP3=X"07") else --LOAD
				 B3; 
	
	
	
Work :process 
	begin
		wait until CLK'event and CLK = '1';
		IP <= IP+1; --incremente le pointeur d'instruction
	end process;
	
end Behavioral;

