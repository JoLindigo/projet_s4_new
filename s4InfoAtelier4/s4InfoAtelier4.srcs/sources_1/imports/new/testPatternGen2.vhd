----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2021 06:55:22 PM
-- Design Name: 
-- Module Name: testPatternGenerator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testPatternGen2 is
Port ( 
    clk : in std_logic;
    rstn : in std_logic;
    i_x : in std_logic_vector(11 downto 0);
    i_y : in std_logic_vector(11 downto 0);
    o_dataValid : out std_logic;
    o_dataPixel : out std_logic_vector(23 downto 0);
    i_instruction : in std_logic_vector(31 downto 0)
);
end testPatternGen2;

architecture Behavioral of testPatternGen2 is


component controller is
  Port ( i_instruction                       : in std_logic_vector(31 downto 0); -- 4 bits opcode
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
         o_actor_tile_buffer_ch_en           : out std_logic);            
end component;

component viewport is
    Port ( i_clk            : in std_logic;
           i_print_px_y     : in STD_LOGIC_VECTOR (11 downto 0);
           i_print_px_x     : in STD_LOGIC_VECTOR (11 downto 0);
           i_offset_y       : in STD_LOGIC_VECTOR (8 downto 0);
           i_offset_x       : in STD_LOGIC_VECTOR (9 downto 0);
           i_ch_offset_en   : in std_logic;
           o_global_x       : out STD_LOGIC_VECTOR (11 downto 0);
           o_global_y       : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component background_buffer_2 is
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
end component;

component bg_tile_buffer_2 is
    Port ( i_tile_id                : in STD_LOGIC_VECTOR (4 downto 0);
           i_tile_x                 : in STD_LOGIC_VECTOR (2 downto 0);
           i_tile_y                 : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_pixel_color    : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_x              : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_y              : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_id             : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_en                  : in STD_LOGIC;
           i_clk                    : in STD_LOGIC;
           o_color_code             : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component color_mux is
    Port ( i_sel        : in STD_LOGIC_VECTOR (4 downto 0);
           o_color_rbg  : out STD_LOGIC_VECTOR (23 downto 0));
end component;

component actor_manager is
  Port (
    i_clk             : in  std_logic;
    i_print_px_x      : in  std_logic_vector(9 downto 0);
    i_print_px_y      : in  std_logic_vector(8 downto 0);
    i_actor_id        : in  std_logic_vector(2 downto 0);
    i_global_actor_x  : in  std_logic_vector(9 downto 0);
    i_global_actor_y  : in  std_logic_vector(8 downto 0);
    i_change_tile_id  : in  std_logic_vector(3 downto 0);
    i_move_actor_x    : in  std_logic_vector(3 downto 0);
    i_move_actor_y    : in  std_logic_vector(3 downto 0);
    i_ch_tile_id_en   : in  std_logic;
    i_global_actor_en : in  std_logic;
    i_move_actor_en   : in  std_logic;
    i_actor_update_en : in  std_logic;
    o_tile_id         : out std_logic_vector(3 downto 0);
    o_tile_x          : out std_logic_vector(3 downto 0);
    o_tile_y          : out std_logic_vector(3 downto 0)
    );
end component;

component actor_tile_buffer is
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
end component;

--Signals
signal s_bg_tile_id                        : STD_LOGIC_VECTOR (4 downto 0);
signal s_bg_tile_x                         : STD_LOGIC_VECTOR (2 downto 0);
signal s_bg_tile_y                         : STD_LOGIC_VECTOR (2 downto 0);
signal s_bg_color_code                     : STD_LOGIC_VECTOR (4 downto 0);

signal s_global_x                          : STD_LOGIC_VECTOR (11 downto 0);
signal s_global_y                          : STD_LOGIC_VECTOR (11 downto 0);

signal s_bg_buffer_ch_tile_id              : std_logic_vector(4 downto 0);
signal s_bg_buffer_ch_tile_row             : std_logic_vector(5 downto 0);
signal s_bg_buffer_ch_tile_col             : std_logic_vector(6 downto 0);
signal s_bg_buffer_ch_en                   : std_logic;

signal s_bg_tile_buffer_ch_pixel_color     : std_logic_vector(4 downto 0);
signal s_bg_tile_buffer_ch_tile_x          : std_logic_vector(2 downto 0);
signal s_bg_tile_buffer_ch_tile_y          : std_logic_vector(2 downto 0);
signal s_bg_tile_buffer_ch_tile_id         : std_logic_vector(4 downto 0); 
signal s_bg_tile_buffer_ch_en              : std_logic;  

signal s_ch_viewport_offset_x              : std_logic_vector(9 downto 0);
signal s_ch_viewport_offset_y              : std_logic_vector(8 downto 0); 
signal s_ch_viewport_en                    : std_logic;

signal s_actor_manager_selected_actor_id   : std_logic_vector(2 downto 0);
signal s_actor_manager_new_tile_id         : std_logic_vector(3 downto 0);
signal s_actor_manager_ch_actor_tile_id_en : std_logic;
  
signal s_actor_id                          : std_logic_vector(2 downto 0);
signal s_actor_ch_en                       : std_logic;
                                           
--signal s_actor_set_global_pos_actor_id     : std_logic_vector(2 downto 0);
signal s_actor_set_global_pos_x            : std_logic_vector(9 downto 0);
signal s_actor_set_global_pos_y            : std_logic_vector(8 downto 0);
signal s_actor_set_global_pos_en           : std_logic;
                                           
--signal s_actor_move_pos_actor_id           : std_logic_vector(2 downto 0);
signal s_actor_move_pos_delta_x            : std_logic_vector(3 downto 0);
signal s_actor_move_pos_delta_y            : std_logic_vector(3 downto 0);
signal s_actor_move_pos_en                 : std_logic;
                                           
signal s_actor_tile_buffer_ch_pixel_color  : std_logic_vector(4 downto 0);
signal s_actor_tile_buffer_ch_tile_x       : std_logic_vector(3 downto 0);
signal s_actor_tile_buffer_ch_tile_y       : std_logic_vector(3 downto 0);
signal s_actor_tile_buffer_ch_tile_id      : std_logic_vector(3 downto 0);
signal s_actor_tile_buffer_ch_en           : std_logic;

signal s_actor_manager_tile_id_out         : std_logic_vector(3 downto 0);
signal s_actor_manager_tile_x_out          : std_logic_vector(3 downto 0);
signal s_actor_manager_tile_y_out          : std_logic_vector(3 downto 0);

signal s_actor_tile_buffer_color_code_out  : std_logic_vector(4 downto 0);

signal s_selected_color_code               : std_logic_vector(4 downto 0);

--signal s_actor_tile_buffer_o_tile_id   : 

begin

inst_controller : controller 
  Port map
       ( i_instruction                      => i_instruction,
         i_clk                              => clk,

         o_bg_buffer_ch_tile_id             => s_bg_buffer_ch_tile_id, 
         o_bg_buffer_ch_tile_row            => s_bg_buffer_ch_tile_row, 
         o_bg_buffer_ch_tile_col            => s_bg_buffer_ch_tile_col, 
         o_bg_buffer_ch_en                  => s_bg_buffer_ch_en, 

         o_bg_tile_buffer_ch_pixel_color    => s_bg_tile_buffer_ch_pixel_color, 
         o_bg_tile_buffer_ch_tile_x         => s_bg_tile_buffer_ch_tile_x, 
         o_bg_tile_buffer_ch_tile_y         => s_bg_tile_buffer_ch_tile_y, 
         o_bg_tile_buffer_ch_tile_id        => s_bg_tile_buffer_ch_tile_id,  
         o_bg_tile_buffer_ch_en             => s_bg_tile_buffer_ch_en, 

         o_ch_viewport_offset_x             => s_ch_viewport_offset_x, 
         o_ch_viewport_offset_y             => s_ch_viewport_offset_y,  
         o_ch_viewport_en                   => s_ch_viewport_en,
         
         o_actor_manager_new_tile_id         => s_actor_manager_new_tile_id,
         o_actor_manager_ch_actor_tile_id_en => s_actor_manager_ch_actor_tile_id_en,
           
         o_actor_id                          => s_actor_id,
         o_actor_ch_en                       => s_actor_ch_en,
                                             
         --o_actor_set_global_pos_actor_id     => s_actor_set_global_pos_actor_id,
         o_actor_set_global_pos_x            => s_actor_set_global_pos_x,
         o_actor_set_global_pos_y            => s_actor_set_global_pos_y,
         o_actor_set_global_pos_en           => s_actor_set_global_pos_en,
                                             
         --o_actor_move_pos_actor_id           => s_actor_move_pos_actor_id,
         o_actor_move_pos_delta_x            => s_actor_move_pos_delta_x,
         o_actor_move_pos_delta_y            => s_actor_move_pos_delta_y,
         o_actor_move_pos_en                 => s_actor_move_pos_en,
                                             
         o_actor_tile_buffer_ch_pixel_color  => s_actor_tile_buffer_ch_pixel_color,
         o_actor_tile_buffer_ch_tile_x       => s_actor_tile_buffer_ch_tile_x,
         o_actor_tile_buffer_ch_tile_y       => s_actor_tile_buffer_ch_tile_y,
         o_actor_tile_buffer_ch_tile_id      => s_actor_tile_buffer_ch_tile_id,
         o_actor_tile_buffer_ch_en           => s_actor_tile_buffer_ch_en
     ); 

inst_viewport : viewport
    Port map
         ( i_clk            => clk, 
           i_print_px_y     => i_y, 
           i_print_px_x     => i_x, 
           i_offset_y       => s_ch_viewport_offset_y, 
           i_offset_x       => s_ch_viewport_offset_x, 
           i_ch_offset_en   => s_ch_viewport_en,
           o_global_x       => s_global_x,
           o_global_y       => s_global_y
           );

inst_background_buffer : background_buffer_2
    Port map
         ( clk              => clk,
           i_global_x       => s_global_x(9 downto 0),
           i_global_y       => s_global_y(8 downto 0),
           i_ch_tile_id     => s_bg_buffer_ch_tile_id,
           i_ch_tile_row    => s_bg_buffer_ch_tile_row,
           i_ch_tile_col    => s_bg_buffer_ch_tile_col,
           i_ch_en          => s_bg_buffer_ch_en,
           o_tile_id        => s_bg_tile_id,
           o_tile_x         => s_bg_tile_x,
           o_tile_y         => s_bg_tile_y );

inst_bg_tile_buffer : bg_tile_buffer_2
    Port map
         ( i_tile_id                => s_bg_tile_id,
           i_tile_x                 => s_bg_tile_x,
           i_tile_y                 => s_bg_tile_y,
           i_ch_tile_pixel_color    => s_bg_tile_buffer_ch_pixel_color,
           i_ch_tile_x              => s_bg_tile_buffer_ch_tile_x,
           i_ch_tile_y              => s_bg_tile_buffer_ch_tile_y,
           i_ch_tile_id             => s_bg_tile_buffer_ch_tile_id,
           i_ch_en                  => s_bg_tile_buffer_ch_en,
           i_clk                    => clk,
           o_color_code             => s_bg_color_code );
           
    s_selected_color_code <= s_bg_color_code when s_actor_tile_buffer_color_code_out = "00000" else s_actor_tile_buffer_color_code_out;
           
inst_color_mux : color_mux
    Port map
         ( i_sel        => s_selected_color_code,
           o_color_rbg  => o_dataPixel );
           
inst_actor_manager : actor_manager
    Port map(
        i_clk             => clk,
        i_print_px_x      => s_global_x(9 downto 0),
        i_print_px_y      => s_global_y(8 downto 0),
        i_actor_id        => s_actor_id,
        i_global_actor_x  => s_actor_set_global_pos_x,
        i_global_actor_y  => s_actor_set_global_pos_y,
        i_change_tile_id  => s_actor_manager_new_tile_id,
        i_move_actor_x    => s_actor_move_pos_delta_x,
        i_move_actor_y    => s_actor_move_pos_delta_y,
        i_ch_tile_id_en   => s_actor_manager_ch_actor_tile_id_en,
        i_global_actor_en => s_actor_set_global_pos_en,
        i_move_actor_en   => s_actor_move_pos_en,
        i_actor_update_en => s_actor_ch_en,
        o_tile_id         => s_actor_manager_tile_id_out,
        o_tile_x          => s_actor_manager_tile_x_out,
        o_tile_y          => s_actor_manager_tile_y_out
    );
      
inst_actor_tile_buffer : actor_tile_buffer
    Port map(
        i_tile_id             => s_actor_manager_tile_id_out,
        i_tile_x              => s_actor_manager_tile_x_out,
        i_tile_y              => s_actor_manager_tile_y_out,
        i_ch_tile_pixel_color => s_actor_tile_buffer_ch_pixel_color,
        i_ch_tile_x           => s_actor_tile_buffer_ch_tile_x,
        i_ch_tile_y           => s_actor_tile_buffer_ch_tile_y,
        i_ch_tile_id          => s_actor_tile_buffer_ch_tile_id,
        i_ch_en               => s_actor_tile_buffer_ch_en,
        i_clk                 => clk,
        o_color_code          => s_actor_tile_buffer_color_code_out
    );     
               
 o_dataValid <= '1';

end Behavioral;
