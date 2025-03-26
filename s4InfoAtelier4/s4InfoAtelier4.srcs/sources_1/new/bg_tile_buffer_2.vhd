----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2025 11:59:20
-- Design Name: 
-- Module Name: bg_tile_buffer - Behavioral
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

entity bg_tile_buffer_2 is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_tile_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_tile_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_pixel_color : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_ch_en : in STD_LOGIC;
           i_reset : in STD_LOGIC;
           i_clk: in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (4 downto 0));
end bg_tile_buffer_2;

architecture Behavioral of bg_tile_buffer_2 is
type tile_buffer is array(0 to 127) of STD_LOGIC_VECTOR (4 downto 0);
signal s_tiles: tile_buffer := (others => (others => '0')); 
signal s_color_code_index : STD_LOGIC_VECTOR(11 downto 0);
signal s_ch_pixel_color_index : STD_LOGIC_VECTOR(11 downto 0);
begin
    base: process(i_reset, i_clk)
    begin
        if i_reset = '1' then
            s_tiles <= (others => (others => '0'));
        elsif rising_edge(i_clk) then
            o_color_code <= s_tiles(to_integer(unsigned(s_color_code_index)));      
            if i_ch_en = '1' then
            s_tiles(to_integer(unsigned(s_ch_pixel_color_index))) <= i_ch_tile_pixel_color;
            end if;
        end if;
    
        s_color_code_index(11 downto 6) <= i_tile_id;
        s_color_code_index(5 downto 3)  <= i_tile_y; 
        s_color_code_index(2 downto 0)  <= i_tile_x;
        
        s_ch_pixel_color_index(11 downto 6) <= i_ch_tile_id;
        s_ch_pixel_color_index(5 downto 3)  <= i_ch_tile_y; 
        s_ch_pixel_color_index(2 downto 0)  <= i_ch_tile_x;
    end process;
end Behavioral;
