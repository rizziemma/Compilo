--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:51:16 04/24/2020
-- Design Name:   
-- Module Name:   /home/peppie/Documents/psi/Compilo/vhdl/registrers_test.vhd
-- Project Name:  vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registers_bench
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY registrers_test IS
END registrers_test;
 
ARCHITECTURE behavior OF registrers_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registers_bench
    PORT(
         Addr_A : IN  std_logic_vector(3 downto 0);
         Addr_B : IN  std_logic_vector(3 downto 0);
         Addr_W : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         Data : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Addr_A : std_logic_vector(3 downto 0) := (others => '0');
   signal Addr_B : std_logic_vector(3 downto 0) := (others => '0');
   signal Addr_W : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal Data : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registers_bench PORT MAP (
          Addr_A => Addr_A,
          Addr_B => Addr_B,
          Addr_W => Addr_W,
          W => W,
          Data => Data,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

	RST <= '0', '1' after 50 ns, '0' after 350 ns;
	Data <= X"03", X"04" after 150 ns, X"05" after 300 ns;
	addr_W <= X"1", X"2" after 150 ns, X"3" after 300 ns;
	W <= '0', '1' after 100 ns, '0' after 200 ns, '1' after 300 ns, '0' after 350 ns;
	addr_A <= X"1" after 200 ns, X"3" after 300 ns;
	addr_B <= X"2" after 250 ns;

END;
