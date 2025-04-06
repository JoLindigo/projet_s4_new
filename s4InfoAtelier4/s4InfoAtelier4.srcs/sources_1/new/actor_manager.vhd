library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity actor_manager is
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
end actor_manager;

architecture Behavioral of actor_manager is

    component actor is
        port (
            i_clk             : in  std_logic;
            i_global_actor_x  : in  std_logic_vector(9 downto 0);
            i_global_actor_y  : in  std_logic_vector(8 downto 0);
            i_print_px_x      : in  std_logic_vector(9 downto 0);
            i_print_px_y      : in  std_logic_vector(8 downto 0);
            i_change_tile_id  : in  std_logic_vector(3 downto 0);
            i_move_actor_x    : in  std_logic_vector(3 downto 0);
            i_move_actor_y    : in  std_logic_vector(3 downto 0);
            i_ch_tile_id_en   : in  std_logic;
            i_global_actor_en : in  std_logic;
            i_move_actor_en   : in  std_logic;
            i_actor_en        : in  std_logic;
            o_tile_id         : out std_logic_vector(3 downto 0);
            o_tile_x          : out std_logic_vector(3 downto 0);
            o_tile_y          : out std_logic_vector(3 downto 0)
        );
    end component;
    
    -- Signals
    signal actor_en : std_logic_vector(7 downto 0) := (others => '0');
    
    type tile_id_array_t is array (0 to 7) of std_logic_vector(3 downto 0);
    type tile_coord_array_t is array (0 to 7) of std_logic_vector(3 downto 0);
    
    signal tile_id_array : tile_id_array_t := (others => (others => '0'));
    signal tile_x_array : tile_coord_array_t := (others => (others => '0'));
    signal tile_y_array : tile_coord_array_t := (others => (others => '0'));

begin

    -- Actor Enable Process
    --actor_enable_proc: process(i_clk)
    --begin
        --if rising_edge(i_clk) then
            --if i_actor_update_en = '1' then -- If the actor id is valid because we can't just pass '0' as an ID since it will modify actor 0
                -- Set the specific actor's enable bit
--                actor_en <= (others => '0');
--                actor_en(to_integer(unsigned(i_actor_id))) <= '1';
--            else
--                actor_en <= (others => '0');
--            end if;
--        end if;
--    end process;
    
    actor_en <= "00000001" when (i_actor_id = "000" and i_actor_update_en = '1') else
                "00000010" when (i_actor_id = "001" and i_actor_update_en = '1') else
                "00000100" when (i_actor_id = "010" and i_actor_update_en = '1') else
                "00001000" when (i_actor_id = "011" and i_actor_update_en = '1') else
                "00010000" when (i_actor_id = "100" and i_actor_update_en = '1') else
                "00100000" when (i_actor_id = "101" and i_actor_update_en = '1') else
                "01000000" when (i_actor_id = "110" and i_actor_update_en = '1') else
                "10000000" when (i_actor_id = "111" and i_actor_update_en = '1') else
                "00000000";

    -- Actor Instances
    actor_gen: for i in 0 to 7 generate
        actor_inst: actor
        port map (
            i_clk             => i_clk,
            i_global_actor_x  => i_global_actor_x,
            i_global_actor_y  => i_global_actor_y,
            i_print_px_x      => i_print_px_x,
            i_print_px_y      => i_print_px_y,
            i_change_tile_id  => i_change_tile_id,
            i_move_actor_x    => i_move_actor_x,
            i_move_actor_y    => i_move_actor_y,
            i_ch_tile_id_en   => i_ch_tile_id_en,
            i_global_actor_en => i_global_actor_en,
            i_move_actor_en   => i_move_actor_en,
            i_actor_en        => actor_en(i),
            o_tile_id         => tile_id_array(i),
            o_tile_x          => tile_x_array(i),
            o_tile_y          => tile_y_array(i)
        );
    end generate;

    -- Output Selection Process
    output_select_proc: process(i_clk)
    begin
        if rising_edge(i_clk) then
            -- Default
            o_tile_id <= (others => '0');
            o_tile_x <= (others => '0');
            o_tile_y <= (others => '0');
        
            -- Iterate from 0 to 7
            -- Les acteurs avec un index plus petit seront on top
            for i in 0 to 7 loop
                if unsigned(tile_id_array(i)) /= 0 then
                    o_tile_id <= tile_id_array(i);
                    o_tile_x  <= tile_x_array(i);
                    o_tile_y  <= tile_y_array(i);
                    exit;
                end if;           
            end loop;
        end if;
    end process;

end Behavioral;