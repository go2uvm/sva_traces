library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity counter is
  generic (
    SIZE : natural := 8);
  port (
    count_out : out std_logic_vector(SIZE -1 downto 0); --  counter output
    data_in   : in  std_logic_vector(SIZE - 1 downto 0); -- data to load
    ld_enb    : in  std_logic; -- parallel load enable, active hi
    count_enb : in  std_logic;-- count enable, active high       
    rst_n     : in  std_logic; -- reset, active hi               
    clk       : in  std_logic -- system clock
    );
end entity counter;

architecture rtl of counter is
  -- Local signal because it has to be read internally
  -- unsigned type used because of "+" operation needed 
  signal count : unsigned(SIZE - 1 downto 0);  -- counter reg
  signal tc    : std_logic;
begin  -- architecture rtl

  Counter_proc : process (clk, rst_n) is
  begin  -- process COunter_proc
    if (rst_n = '0') then
      count <= (others => '0');
    elsif (clk'event and Clk = '1') then
      if (ld_enb = '1') then
        count <= unsigned(data_in);
      elsif (count_enb = '1') then
        count <= count + 1;
      end if;
    end if;
  end process Counter_proc;

  -- Assignment to output 
  count_out <= std_logic_vector(count);
  tc <= '1' when count = ("11111111") else
                 '0' when count ="00000000";
  
end architecture rtl;
