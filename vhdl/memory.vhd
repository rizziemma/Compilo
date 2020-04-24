----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:27 04/24/2020 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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

entity memory is
    Port ( Addr : in  STD_LOGIC_VECTOR (7 downto 0);
           Val : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Val_Out : out  STD_LOGIC_VECTOR (7 downto 0));
end memory;

architecture Behavioral of memory is

type memory_array is array (0 to 255) of std_logic_vector (7 downto 0);
signal mem: memory_array := (others => (others => '0'));

begin

Work :process 
	begin
	
	wait until CLK'event and CLK = '1';
	if(RST = '0') then
		mem <= (others => (others => '0'));
		Val_Out <= (others => '0');
	else
		if (RW = '1') then --lecture
			Val_Out <= mem(to_integer(unsigned(Addr))) ;
		else 					 --ecriture
			mem(to_integer(unsigned(Addr))) <= Val;
		end if;
	end if;
	end process;

end Behavioral;

