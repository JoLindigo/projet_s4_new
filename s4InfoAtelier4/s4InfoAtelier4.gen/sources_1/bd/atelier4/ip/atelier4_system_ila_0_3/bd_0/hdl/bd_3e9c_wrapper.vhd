--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Command: generate_target bd_3e9c_wrapper.bd
--Design : bd_3e9c_wrapper
--Purpose: IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_3e9c_wrapper is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe6 : in STD_LOGIC_VECTOR ( 23 downto 0 );
    probe7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end bd_3e9c_wrapper;

architecture STRUCTURE of bd_3e9c_wrapper is
  component bd_3e9c is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe6 : in STD_LOGIC_VECTOR ( 23 downto 0 );
    probe7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_3e9c;
begin
bd_3e9c_i: component bd_3e9c
     port map (
      clk => clk,
      probe0(31 downto 0) => probe0(31 downto 0),
      probe1(31 downto 0) => probe1(31 downto 0),
      probe2(3 downto 0) => probe2(3 downto 0),
      probe3(11 downto 0) => probe3(11 downto 0),
      probe4(11 downto 0) => probe4(11 downto 0),
      probe5(0) => probe5(0),
      probe6(23 downto 0) => probe6(23 downto 0),
      probe7(0) => probe7(0)
    );
end STRUCTURE;
