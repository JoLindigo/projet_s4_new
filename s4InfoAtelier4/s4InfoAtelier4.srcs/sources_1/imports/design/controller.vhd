----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 02:14:49 PM
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
  Port (
    i_instruction                       : in std_logic_vector(31 downto 0); -- 4 bits opcode
    i_clk                               : in std_logic;
    
    o_bg_buffer_ch_tile_id              : out std_logic_vector(4 downto 0);
    o_bg_buffer_ch_tile_row             : out std_logic_vector(5 downto 0);
    o_bg_buffer_ch_tile_col             : out std_logic_vector(6 downto 0);
    o_bg_buffer_ch_en                   : out std_logic;
    
    o_bg_tile_buffer_ch_pixel_color     : out std_logic_vector(4 downto 0);
    o_bg_tile_buffer_ch_tile_x          : out std_logic_vector(2 downto 0);
    o_bg_tile_buffer_ch_tile_y          : out std_logic_vector(2 downto 0);
    o_bg_tile_buffer_ch_tile_id         : out std_logic_vector(4 downto 0); 
    o_bg_tile_buffer_ch_en              : out std_logic;  
    
    o_ch_viewport_offset_x              : out std_logic_vector(9 downto 0);
    o_ch_viewport_offset_y              : out std_logic_vector(8 downto 0); 
    o_ch_viewport_en                    : out std_logic;
    
    o_actor_manager_new_tile_id         : out std_logic_vector(3 downto 0);
    o_actor_manager_ch_actor_tile_id_en : out std_logic;
    
    o_actor_id                          : out std_logic_vector(2 downto 0);
    o_actor_ch_en                       : out std_logic;
    
    --o_actor_set_global_pos_actor_id     : out std_logic_vector(2 downto 0);
    o_actor_set_global_pos_x            : out std_logic_vector(9 downto 0);
    o_actor_set_global_pos_y            : out std_logic_vector(8 downto 0);
    o_actor_set_global_pos_en           : out std_logic;
    
    --o_actor_move_pos_actor_id           : out std_logic_vector(2 downto 0);
    o_actor_move_pos_delta_x            : out std_logic_vector(3 downto 0);
    o_actor_move_pos_delta_y            : out std_logic_vector(3 downto 0);
    o_actor_move_pos_en                 : out std_logic;    
    
    o_actor_tile_buffer_ch_pixel_color  : out std_logic_vector(4 downto 0);
    o_actor_tile_buffer_ch_tile_x       : out std_logic_vector(3 downto 0);
    o_actor_tile_buffer_ch_tile_y       : out std_logic_vector(3 downto 0);
    o_actor_tile_buffer_ch_tile_id      : out std_logic_vector(3 downto 0);
    o_actor_tile_buffer_ch_en           : out std_logic                    
  );
end controller;

architecture Behavioral of controller is

constant OPCODE_NOP                     : std_logic_vector(3 downto 0) := "0000";
constant OPCODE_SETACTORTILECOLOR       : std_logic_vector(3 downto 0) := "0001";
constant OPCODE_SETBACKGROUNDTILECOLOR  : std_logic_vector(3 downto 0) := "0010";
constant OPCODE_SETACTORTILEID          : std_logic_vector(3 downto 0) := "0011";
constant OPCODE_SETBACKGROUNDTILEID     : std_logic_vector(3 downto 0) := "0100";
constant OPCODE_MOVEACTORPOSITION       : std_logic_vector(3 downto 0) := "0101";
constant OPCODE_SETACTORPOSITION        : std_logic_vector(3 downto 0) := "0110";
constant OPCODE_SETVIEWPORTOFFSET       : std_logic_vector(3 downto 0) := "0111";

signal s_OPCODE : std_logic_vector(3 downto 0);

begin

s_OPCODE <= i_instruction(31 downto 28);

process(i_clk)
begin         
     if rising_edge(i_clk) then
        o_bg_buffer_ch_tile_id              <= (others => '0');
        o_bg_buffer_ch_tile_row             <= (others => '0');
        o_bg_buffer_ch_tile_col             <= (others => '0');
        o_bg_buffer_ch_en                   <= '0';
        
        o_bg_tile_buffer_ch_pixel_color     <= (others => '0');
        o_bg_tile_buffer_ch_tile_x          <= (others => '0');
        o_bg_tile_buffer_ch_tile_y          <= (others => '0');
        o_bg_tile_buffer_ch_tile_id         <= (others => '0');
        o_bg_tile_buffer_ch_en              <= '0';
        
        o_ch_viewport_offset_x              <= (others => '0');
        o_ch_viewport_offset_y              <= (others => '0');
        o_ch_viewport_en                    <= '0';
        
        o_actor_manager_new_tile_id         <= (others => '0');
        o_actor_manager_ch_actor_tile_id_en <= '0';
                 
        o_actor_id                          <= (others => '0');   
        o_actor_ch_en                       <= '0';                      
                                            
        --o_actor_set_global_pos_actor_id     <= (others => '0');
        o_actor_set_global_pos_x            <= (others => '0');
        o_actor_set_global_pos_y            <= (others => '0');
        o_actor_set_global_pos_en           <= '0';
                                            
        --o_actor_move_pos_actor_id           <= (others => '0');
        o_actor_move_pos_delta_x            <= (others => '0');
        o_actor_move_pos_delta_y            <= (others => '0');
        o_actor_move_pos_en                 <= '0';
                                            
        o_actor_tile_buffer_ch_pixel_color  <= (others => '0');
        o_actor_tile_buffer_ch_tile_x       <= (others => '0');
        o_actor_tile_buffer_ch_tile_y       <= (others => '0');
        o_actor_tile_buffer_ch_tile_id      <= (others => '0');
        o_actor_tile_buffer_ch_en           <= '0';  
        
        case s_OPCODE is
            when OPCODE_NOP =>   
                
            when OPCODE_SETACTORTILECOLOR =>                    -- SET_ACTOR_TILE_BUFFER_ID
                o_actor_tile_buffer_ch_tile_id     <= i_instruction(27 downto 24);
                o_actor_tile_buffer_ch_tile_x      <= i_instruction(23 downto 20);
                o_actor_tile_buffer_ch_tile_y      <= i_instruction(19 downto 16);
                o_actor_tile_buffer_ch_pixel_color <= i_instruction(15 downto 11);
                o_actor_tile_buffer_ch_en          <= '1';
                
            when OPCODE_SETBACKGROUNDTILECOLOR =>               -- SET_BG_TILE_BUFFER_ID
                o_bg_tile_buffer_ch_tile_id     <= i_instruction(27 downto 23);
                o_bg_tile_buffer_ch_tile_x      <= i_instruction(22 downto 20);
                o_bg_tile_buffer_ch_tile_y      <= i_instruction(19 downto 17);
                o_bg_tile_buffer_ch_pixel_color <= i_instruction(16 downto 12);
                o_bg_tile_buffer_ch_en          <= '1';
                
            when OPCODE_SETACTORTILEID =>                       -- SET_ACTOR_TILE_ID
                o_actor_id                          <= i_instruction(27 downto 25);
                o_actor_manager_new_tile_id         <= i_instruction(24 downto 21);
                o_actor_manager_ch_actor_tile_id_en <= '1';
                o_actor_ch_en                       <= '1';
                
            when OPCODE_SETBACKGROUNDTILEID =>                  -- SET_BG_TILE_ID
                o_bg_buffer_ch_tile_id          <= i_instruction(27 downto 23);
                o_bg_buffer_ch_tile_col         <= i_instruction(22 downto 16);
                o_bg_buffer_ch_tile_row         <= i_instruction(15 downto 10);
                o_bg_buffer_ch_en               <= '1';
                
            when OPCODE_MOVEACTORPOSITION =>                    -- MOVE_ACTOR_RELATIVE
                --o_actor_move_pos_actor_id <= i_instruction(27 downto 25);
                o_actor_id                <= i_instruction(27 downto 25);
                o_actor_move_pos_delta_x  <= i_instruction(24 downto 21);
                o_actor_move_pos_delta_y  <= i_instruction(20 downto 17);
                o_actor_move_pos_en       <= '1';
                o_actor_ch_en             <= '1';
                
--                o_ch_tile_id        <= i_instruction(27 downto 22);
--                o_ch_offset_x       <= i_instruction(21 downto 12);
--                o_ch_offset_y       <= i_instruction(11 downto 2);
--                o_pos_en            <= '1';
--                o_ch_tile_id_en     <= '1';
--                o_bg_tile_en        <= '1';
                
            when OPCODE_SETACTORPOSITION =>                     -- MOVE_ACTOR_ABSOLUTE
                --o_actor_set_global_pos_actor_id <= i_instruction(27 downto 25);
                o_actor_id                      <= i_instruction(27 downto 25);
                o_actor_set_global_pos_x        <= i_instruction(24 downto 15);
                o_actor_set_global_pos_y        <= i_instruction(14 downto 6);
                o_actor_set_global_pos_en       <= '1';
                o_actor_ch_en                   <= '1';
                             
--                o_ch_tile_id        <= i_instruction(27 downto 22);
--                o_ch_offset_x       <= i_instruction(21 downto 12);
--                o_ch_offset_y       <= i_instruction(11 downto 2);
--                o_global_actor_en   <= '1';
--                o_pos_en            <= '1';
--                o_ch_tile_id_en     <= '1';
                
           when OPCODE_SETVIEWPORTOFFSET =>                     -- SET_OFFSET
                o_ch_viewport_offset_x              <= i_instruction(27 downto 18);
                o_ch_viewport_offset_y              <= i_instruction(17 downto 9);
                o_ch_viewport_en                    <= '1';               
                
           when others =>
                o_bg_buffer_ch_tile_id              <= (others => '0');
                o_bg_buffer_ch_tile_row             <= (others => '0');
                o_bg_buffer_ch_tile_col             <= (others => '0');
                o_bg_buffer_ch_en                   <= '0';
        
                o_bg_tile_buffer_ch_pixel_color     <= (others => '0');
                o_bg_tile_buffer_ch_tile_x          <= (others => '0');
                o_bg_tile_buffer_ch_tile_y          <= (others => '0');
                o_bg_tile_buffer_ch_tile_id         <= (others => '0');
                o_bg_tile_buffer_ch_en              <= '0';
        
                o_ch_viewport_offset_x              <= (others => '0');
                o_ch_viewport_offset_y              <= (others => '0');
                o_ch_viewport_en                    <= '0';
                
                o_actor_manager_new_tile_id         <= (others => '0');
                o_actor_manager_ch_actor_tile_id_en <= '0';
                         
                o_actor_id                          <= (others => '0');   
                o_actor_ch_en                       <= '0';                      
                                                    
                --o_actor_set_global_pos_actor_id     <= (others => '0');
                o_actor_set_global_pos_x            <= (others => '0');
                o_actor_set_global_pos_y            <= (others => '0');
                o_actor_set_global_pos_en           <= '0';
                                                    
                --o_actor_move_pos_actor_id           <= (others => '0');
                o_actor_move_pos_delta_x            <= (others => '0');
                o_actor_move_pos_delta_y            <= (others => '0');
                o_actor_move_pos_en                 <= '0';
                                                    
                o_actor_tile_buffer_ch_pixel_color  <= (others => '0');
                o_actor_tile_buffer_ch_tile_x       <= (others => '0');
                o_actor_tile_buffer_ch_tile_y       <= (others => '0');
                o_actor_tile_buffer_ch_tile_id      <= (others => '0');
                o_actor_tile_buffer_ch_en           <= '0';               
        end case;
    end if;
end process;
end Behavioral;
