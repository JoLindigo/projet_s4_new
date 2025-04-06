----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2025 11:59:20
-- Design Name: 
-- Module Name: actor_tile_buffer - Behavioral
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

entity actor_tile_buffer is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (3 downto 0);
           i_tile_x : in STD_LOGIC_VECTOR (3 downto 0);
           i_tile_y : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_pixel_color : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_x : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_y : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_id : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_en : in STD_LOGIC;
           i_clk: in STD_LOGIC;
           --i_bg_tile_en : in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (4 downto 0));
end actor_tile_buffer;

architecture Behavioral of actor_tile_buffer is
--type tile_buffer is array(0 to 15, 0 to 15, 0 to 15) of STD_LOGIC_VECTOR (4 downto 0);
type tile_buffer is array(0 to 4095) of STD_LOGIC_VECTOR (4 downto 0);

signal s_tiles: tile_buffer := (others => (others => '0'));

signal s_tiles_index : std_logic_vector(11 downto 0);
signal s_tiles_ch_index : std_logic_vector(11 downto 0);
 
begin

    s_tiles_index(11 downto 8) <= i_tile_id;
    s_tiles_index(7 downto 4)  <= i_tile_y;
    s_tiles_index(3 downto 0)  <= i_tile_x;
            
    s_tiles_ch_index(11 downto 8) <= i_ch_tile_id;
    s_tiles_ch_index(7 downto 4)  <= i_ch_tile_y;
    s_tiles_ch_index(3 downto 0)  <= i_ch_tile_x;

    base: process(i_clk)
    begin
        if rising_edge(i_clk) then           
            o_color_code <= s_tiles(to_integer(unsigned(s_tiles_index)));
                            
            if i_ch_en = '1' and i_ch_tile_id /= "0000" then                
                s_tiles(to_integer(unsigned(s_tiles_ch_index))) <= i_ch_tile_pixel_color;
            end if;
        end if;
    end process;
end Behavioral;
