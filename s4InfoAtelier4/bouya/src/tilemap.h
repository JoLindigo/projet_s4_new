#ifndef _TILEMAP__H_
#define _TILEMAP__H_
#include "common.h"

enum TileType { EMPTY, WALL, WALL2, OBSTACLE };

struct Tile {
    enum TileType type;
    u8 tileId;
};

struct TileMap {
    u16 width;
    u16 height;
    struct Tile tiles[128][64];
};

struct Tile* initialize_default_tiles();
struct TileMap initialize_map(u16 width, u16 height);

#endif
