----------------------------------------------------------------------------------
-- Company: Indigo ftw
-- Engineer: Samuel Simard
-- 
-- Create Date: 03/05/2025 11:59:04 AM
-- Design Name: 
-- Module Name: background_buffer - Behavioral
-- Project Name: PPU
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity background_buffer_2 is
    Port ( clk           : in STD_LOGIC;
           i_global_x    : in STD_LOGIC_VECTOR (9 downto 0);
           i_global_y    : in STD_LOGIC_VECTOR (8 downto 0);
           i_ch_tile_id  : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_row : in STD_LOGIC_VECTOR (5 downto 0);
           i_ch_tile_col : in STD_LOGIC_VECTOR (6 downto 0);
           i_ch_en       : in STD_LOGIC;
           o_tile_id     : out STD_LOGIC_VECTOR (4 downto 0);
           o_tile_x      : out STD_LOGIC_VECTOR (2 downto 0);
           o_tile_y      : out STD_LOGIC_VECTOR (2 downto 0));
end background_buffer_2;

architecture Behavioral of background_buffer_2 is

    type BackgroundBufferArray is array(0 to 8191) of STD_LOGIC_VECTOR (4 downto 0);
    
    signal s_buffer : BackgroundBufferArray := (others => (others => '0')); 
    
    signal s_new_tile_pos_index : std_logic_vector(12 downto 0) := (others => '0');
    signal s_tile_index_pos       : std_logic_vector(12 downto 0) := (others => '0');
    
begin

    pro_clk_reset: process(clk)
    begin
        if rising_edge(clk) then
            o_tile_id <= s_buffer(to_integer(unsigned(s_tile_index_pos)));
            o_tile_x  <= i_global_x(2 downto 0);
            o_tile_y  <= i_global_y(2 downto 0);
            if i_ch_en = '1' then
               s_buffer(TO_INTEGER(unsigned(s_new_tile_pos_index))) <= i_ch_tile_id;
            end if;
        end if;
    end process;
    
    s_tile_index_pos(12 downto 7) <= i_global_y(8 downto 3);
    s_tile_index_pos(6 downto 0) <= i_global_x(9 downto 3);
    
    s_new_tile_pos_index(12 downto 7) <= i_ch_tile_row;
    s_new_tile_pos_index(6 downto 0) <= i_ch_tile_col;

end Behavioral;