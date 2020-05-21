----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:12:35 04/15/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0));
end alu;

architecture Behavioral of alu is

	signal S_add  : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
	signal S_sub  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal S_mul  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal S_inf  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal S_eq   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal S_sup  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

--	signal S_div  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	
begin
	S_add <= ('0' & A)+('0' & B);
	S_sub <= A-B;
	S_mul <= A*B;
--	S_div <= A/B;
	
	S_inf <= X"01" when Ctrl_Alu = "100" and A < B else X"00";
	S_eq 	<= X"01" when Ctrl_Alu = "101" and A = B else X"00";
	S_sup <= X"01" when Ctrl_Alu = "110" and A > B else X"00";
	
	
	S <=	S_add(7 downto 0)  when Ctrl_Alu = "001" else
			S_mul(7 downto 0)  when Ctrl_Alu = "010" else
			S_sub					 when Ctrl_Alu = "011" else
--			S_div					 when Ctrl_Alu = "100" else
			S_inf					 when Ctrl_Alu = "101" else
			S_eq					 when Ctrl_Alu = "110" else
			S_sup					 when Ctrl_Alu = "111" else
			X"00";

	-- C : carry
	-- N : negative
	-- Z : zero
	-- V : overflow
	
	C <=  S_add(8) when Ctrl_Alu = "001"  else						--carry sur l'addition : le bit de poid fort = 1
			'1' when Ctrl_Alu = "010" and S_mul(15 downto 8) > X"00" else --carry sur la multiplication, il y a au moins un bit à 1 après le 8eme
			'0';
			
	N <= S_add(7) when Ctrl_Alu = "001" else
			S_sub(7) when Ctrl_Alu = "011" else
			S_mul(15) when Ctrl_Alu = "010" else
--			S_div(7) when Ctrl_Alu = "100" else
			'0';
	
	Z <=  '1' when Ctrl_Alu = "001" and S_add(7 downto 0) = X"00" else
			'1' when Ctrl_Alu = "011" and S_sub(7 downto 0) = X"00" else
			'1' when Ctrl_Alu = "010" and S_mul(7 downto 0) = X"00" else
--			'1' when Ctrl_Alu = "100" and S_div(7 downto 0) = X"00" else
			'0';
	
	O <= 	'1' when Ctrl_Alu = "001" and ( ( S_add(7) = '0' and A(7) = '1' and B(7) = '1') or (S_add(7) = '1' and A(7) = '0' and B(7) = '0')) else
			'1' when Ctrl_Alu = "011" and ( ( S_sub(7) = '0' and A(7) = '1' and B(7) = '0') or (S_sub(7) = '1' and A(7) = '0' and B(7) = '1')) else
			'1' when Ctrl_Alu = "010" and ( S_mul(15 downto 8) > X"0") else
			'0';	


end Behavioral;
