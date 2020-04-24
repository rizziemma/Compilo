----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:04 04/24/2020 
-- Design Name: 
-- Module Name:    registers_bench - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity registers_bench is
    Port ( Addr_A : in  STD_LOGIC_VECTOR (3 downto 0);
           Addr_B : in  STD_LOGIC_VECTOR (3 downto 0);
           Addr_W : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end registers_bench;

architecture Behavioral of registers_bench is

type registers_array is array (0 to 15) of std_logic_vector (7 downto 0);
signal registers: registers_array := (others => (others => '0'));

begin

Work :process 
	begin
	
	wait until CLK'event and CLK = '1';
	if(RST = '0') then
		registers <= (others => (others => '0'));
	else
		if (W = '1') then --ecriture
				registers(to_integer(unsigned(addr_W)))<= Data ;
		end if;
	end if;
	end process;
 
	QA <= Data when (addr_W=addr_A and W='1')
		else registers(to_integer(unsigned(addr_A)));
	QB <= Data when (addr_W=addr_B and W='1')
		else registers(to_integer(unsigned(addr_B))) ;
	

end Behavioral;

