----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:31 04/29/2020 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( Clk : in  STD_LOGIC;
			  Op : in  STD_LOGIC_VECTOR (7 downto 0);
           A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           C : in  STD_LOGIC_VECTOR (7 downto 0);
           Out_OP : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_A : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_B : out  STD_LOGIC_VECTOR (7 downto 0);
           Out_C : out  STD_LOGIC_VECTOR (7 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin

Work :process 
	begin
	
		wait until CLK'event and CLK = '1';
		Out_OP <= OP;
		Out_A <= A;
		Out_B <= B;
		Out_C <= C;		

	end process;


end Behavioral;

