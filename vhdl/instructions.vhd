----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:00 04/24/2020 
-- Design Name: 
-- Module Name:    instructions - Behavioral 
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
use ieee.std_logic_textio.all; 
use STD.TEXTIO.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instructions is
    Port ( Addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end instructions;



architecture Behavioral of instructions is

type instr_mem_array is array (0 to 255) of std_logic_vector (31 downto 0);
signal instr_mem: instr_mem_array := (others => (others => '0'));

impure function from_file(FileName : STRING) return instr_mem_array is
  file FileHandle       : TEXT open READ_MODE is FileName;
  variable CurrentLine  : LINE;
  variable TempWord     : STD_LOGIC_VECTOR(31 downto 0);
  variable Result       : instr_mem_array := (others => (others => '0'));

begin
  for i in 0 to 255 loop
    exit when endfile(FileHandle);

    readline(FileHandle, CurrentLine);
    hread(CurrentLine, TempWord);
    Result(i)    := TempWord;
  end loop;

  return Result;
end function;

begin

	instr_mem <= from_file("input.hex");

	Work :process 
	begin
	
		wait until CLK'event and CLK = '1';
		Instr<=instr_mem(to_integer(unsigned(Addr)));
	end process;


end Behavioral;

