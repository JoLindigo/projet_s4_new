----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2025 12:57:43
-- Design Name: 
-- Module Name: bg_tile_buffer_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

entity datapath_tb is
end datapath_tb;

architecture Behavioral of datapath_tb is
component testPatternGen2 is
Port ( 
    clk : in std_logic;
    rstn : in std_logic;
    i_x : in std_logic_vector(11 downto 0);
    i_y : in std_logic_vector(11 downto 0);
    o_dataValid : out std_logic;
    o_dataPixel : out std_logic_vector(23 downto 0);
    i_instruction : in std_logic_vector(31 downto 0);
    o_instruction : out std_logic_vector(31 downto 0);
    o_opcode : out std_logic_vector(3 downto 0)
);
end component;


--Simulation Signals
signal i_clk : std_logic;
signal rstn : std_logic;
signal i_x : std_logic_vector(11 downto 0);
signal i_y : std_logic_vector(11 downto 0);
signal o_dataValid : std_logic;
signal o_dataPixel : std_logic_vector(23 downto 0);
signal i_instruction : std_logic_vector(31 downto 0);
signal o_instruction : std_logic_vector(31 downto 0);
signal o_opcode : std_logic_vector(3 downto 0);
    
constant PERIOD         : time :=  13.531531 ns;
constant COMMAND_PERIOD : time :=  50 ns;

begin
    UUT: testPatternGen2
        Port map( 
            clk             => i_clk,          
            rstn            => rstn,         
            i_x             => i_x,          
            i_y             => i_y,          
            o_dataValid     => o_dataValid,  
            o_dataPixel     => o_dataPixel,  
            i_instruction   => i_instruction,
            o_instruction   => o_instruction,
            o_opcode        => o_opcode
);         
            
   sim_clk_p: process
   begin
      i_clk <= '1';
      loop
         wait for PERIOD / 2;
         i_clk <= not i_clk;
      end loop;
   end process;
   
   tb: process
   begin
        rstn <= '0';
        i_x <= (others => '0');
        i_y <= (others => '0');
        wait for COMMAND_PERIOD;
        i_instruction <= "00100000010000000000100000000000";
        
        wait for COMMAND_PERIOD;
        i_instruction <= "00100000010011000000100000000000";
        
        wait for COMMAND_PERIOD;
        i_instruction <= "01000000010000000000000000000000";

        wait for COMMAND_PERIOD;
        i_instruction <= "01000000010110101000000000000000";
        WAIT;
   end process;

end Behavioral;
