--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:01:22 04/24/2020
-- Design Name:   
-- Module Name:   /home/peppie/Documents/psi/Compilo/vhdl/memory_test.vhd
-- Project Name:  vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory
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
 
ENTITY memory_test IS
END memory_test;
 
ARCHITECTURE behavior OF memory_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory
    PORT(
         Addr : IN  std_logic_vector(7 downto 0);
         Val : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Val_Out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Addr : std_logic_vector(7 downto 0) := (others => '0');
   signal Val : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Val_Out : std_logic_vector(7 downto 0) := (others => '0');

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memory PORT MAP (
          Addr => Addr,
          Val => Val,
          RW => RW,
          RST => RST,
          CLK => CLK,
          Val_Out => Val_Out
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

 Addr <= X"00", X"01" after 50 ns, X"00" after 200 ns;
 Val <= X"11", X"22" after 50 ns;
 RW <= '0', '1' after 100 ns;
 RST <= '1', '0' after 150 ns;

END;
