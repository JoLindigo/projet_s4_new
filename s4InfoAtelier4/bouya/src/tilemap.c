#include "tilemap.h"
#include <stdlib.h>
#include "api/ppu/ppu.h"
#include "sleep.h"


/* Tile based initializer */
struct TileMap initialize_map(u16 width, u16 height) {
    struct TileMap map;
    map.width = width;
    map.height = height;

    for (u16 i = 0; i < map.width; i++) {
        for (u16 j = 0; j < map.height; j++) {
			if((j % 2 == 0 && i % 2 == 0) || (j % 2 != 0 && i % 2 != 0)) {
				map.tiles[i][j].tileId = 1;
			}
			else{
				map.tiles[i][j].tileId = 2;
			}
        }
    }

    return map;
}

/* Viewport initializer
struct TileMap initialize_map(u16 width, u16 height) {
    struct TileMap map;
    map.width = width;
    map.height = height;

    for (u16 i = 0; i < map.width; i++) {
        for (u16 j = 0; j < map.height; j++) {
			u8 tileId = 0;
			if((i % 2 == 0 && j % 2 == 0) || (i % 2 != 0 && j % 2 != 0)) {
				tileId = 1;
			}
			else{
				tileId = 2;
			}
			PPU_SetBackgroundTileID(tileId, i, j);
        }
    }

    return map;
} */
