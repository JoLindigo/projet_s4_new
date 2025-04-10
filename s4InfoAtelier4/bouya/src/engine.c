#include "engine.h"
#include "api/ppu/ppu.h"
#include <stdlib.h>

/* Shift par tiles */
void ShiftBackground(struct Player p[], struct Renderer* r, struct TileMap* tm, u8* scroll_x, u32* gameTime){
	if(*gameTime >= r->lastBackgroundShift && *gameTime <= 128000){
		for(u8 d = 0; d < 8; d++){
			p[d].x = (p[d].x + d) % 800;
		}
		r->isBackgroundDirty = 1;
		scroll_x += 16;
		/*
		for(uint8_t i = 0; i < tm->width; i++) {
				for(uint8_t j = 0; j < tm->height; j++) {
					uint8_t newX = i+1;
					if(newX == tm->width){
						tm->tiles[i][j].tileId = tm->tiles[0][j].tileId;
					}else{
						tm->tiles[i][j].tileId = tm->tiles[newX][j].tileId;
					}
				}
			}
		*/
		r->backgroundOffset = r->backgroundOffset + 1;

		if(*gameTime + 500 >= 128000){
			r->lastBackgroundShift = 500;
		}else {
			r->lastBackgroundShift = *gameTime + 500;
		}
	}
}

/* Shift par background offset
void ShiftBackground(struct Renderer* r, struct TileMap* tm, u32* gameTime){
	if(*gameTime >= r->lastBackgroundShift && *gameTime <= 128000){
		r->isBackgroundDirty = 1;
		r->backgroundOffset = r->backgroundOffset + 1;
		print("background dirty");
		if(*gameTime + 2000 >= 128000){
			r->lastBackgroundShift = 2000;
		}else {
			r->lastBackgroundShift = *gameTime + 2000;
		}
	}
}
*/

void ENGINE_Start(){
    u32 gameTime = 0;
    XTime tStartTime, tElapsedTime;
    u16 width = 128;
    u16 height = 64;

    struct Player p[8];
    p[0] = initialize_player(194, 0);
    p[1] = initialize_player(230, 0);
    p[2] = initialize_player(30, 0);
    p[3] = initialize_player(67, 0);
    p[4] = initialize_player(100, 0);
    p[5] = initialize_player(115, 0);
    p[6] = initialize_player(130, 0);
    p[7] = initialize_player(160, 0);
    struct Renderer r = init_renderer();
    u8 scroll_x = 0;
    struct TileMap tm = initialize_map(width, height);
    XTime_GetTime(&tStartTime);

    while (1) {
    	XTime_GetTime(&tElapsedTime);
        gameTime = ((u32)tElapsedTime - (u32)tStartTime) / (u32)(COUNTS_PER_SECOND / 10000);
        ShiftBackground(&p, &r, &tm, &scroll_x, &gameTime);
        draw(&r, &p, &tm, &gameTime);
    }
}

