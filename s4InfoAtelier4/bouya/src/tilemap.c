#include "tilemap.h"
#include <stdlib.h>
#include "api/ppu/ppu.h"
#include "sleep.h"

struct Tile* initialize_default_tiles(){
    struct Tile* tiles = calloc(32, sizeof(struct Tile));
    tiles[0].type = EMPTY;
    tiles[0].tileId = 0;
    tiles[1].type = WALL;
    tiles[1].tileId = 1;
    tiles[2].type = WALL2;
    tiles[2].tileId = 2;
    return tiles;
}

struct TileMap initialize_map(u16 width, u16 height) {
    struct TileMap map;
    map.width = width;
    map.height = height;

    //Default tiles
    struct Tile* defaultTiles = initialize_default_tiles();

    for (u16 i = 0; i < map.width; i++) {
        for (u16 j = 0; j < map.height; j++) {
			u8 tileId = 0;
			if((i % 2 == 0 && j % 2 == 0) || (i % 2 != 0 && j % 2 != 0)) {
				tileId = defaultTiles[1].tileId;
			}
			else{
				tileId = defaultTiles[2].tileId;
			}
			PPU_SetBackgroundTileID(tileId, i, j);
        }
    }

    return map;
}
