#include "renderer.h"
#include "instructions.h"
#include <stdlib.h>

const uint8_t PLAYER_ANIMATION[] = {1, 2, 3};
const uint8_t RatActorId = 1;

struct Renderer init_renderer(){
	for(int i = 0; i < sizeof(left_brick_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  left_brick_color_instructions[i]);
		usleep(1);
	}
	for(int i = 0; i < sizeof(right_brick_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  right_brick_color_instructions[i]);
		usleep(1);
	}
	for(int i = 0; i < sizeof(rat_idle_1_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  rat_idle_1_color_instructions[i]);
		usleep(1);
	}
	for(int i = 0; i < sizeof(rat_idle_1_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  rat_running_1_color_instructions[i]);
		usleep(1);
	}
	for(int i = 0; i < sizeof(rat_idle_1_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  rat_running_2_color_instructions[i]);
		usleep(1);
	}

	PPU_SetActorTileID(RatActorId, PLAYER_ANIMATION[0]);
	usleep(1);
	PPU_SetActorPosition(180, 180, RatActorId);
	usleep(1);

    struct Renderer renderer;
    renderer.animationCounter = 0;
    renderer.lastAnimationTick = 0;
    renderer.lastBackgroundShift = 0;
    renderer.isBackgroundDirty = 1;
    renderer.backgroundTick = 0;
    renderer.backgroundOffset = 0;

    return renderer;
}

void draw_background(struct TileMap map, struct Renderer* r){
	if(r->isBackgroundDirty){
		PPU_SetViewportOffset(r->backgroundOffset, 0);
		r->isBackgroundDirty = 0;
	}

}


	/*
void draw_background(struct TileMap map, struct Renderer* r){
	if(r->isBackgroundDirty){
	    for (u16 i = 0; i < map.width; i++) {
	        for (u16 j = 0; j < map.height; j++) {
				u8 tileId = 0;
				if(r->backgroundTick == 0){
					if((i % 2 == 0 && j % 2 == 0) || (i % 2 != 0 && j % 2 != 0)) {
						tileId = 2;
					}
					else{
						tileId = 1;
					}
				}else{
					if((i % 2 == 0 && j % 2 == 0) || (i % 2 != 0 && j % 2 != 0)) {
						tileId = 2;
					}
					else{
						tileId = 1;
					}
				}
				PPU_SetBackgroundTileID(tileId, i, j);
				PPU_SetViewportOffset(r->backgroundTick,);
	        }
	    }
	    if(r->backgroundTick == 0){
	    	r->backgroundTick = 1;
	    }else{
	    	r->backgroundTick = 0;
	    }
		r->isBackgroundDirty = 0;
	}
}

*/

void draw_player(struct Player* p, struct Renderer* r, u32* gameTime){
		PPU_SetActorPosition(p->x, p->y, RatActorId);
		if(p->CurrentAnimation == RUNNING && *gameTime >= r->lastAnimationTick && *gameTime <= 128000 ){
			p->x += 10;
			r->lastAnimationTick = *gameTime + 2000;
			r->animationCounter++;
			if(r->animationCounter >= 3){
				r->animationCounter = 0;
			}
			PPU_SetActorTileID(RatActorId, PLAYER_ANIMATION[r->animationCounter]);
			if(*gameTime + 2000 >= 128000){
				r->lastAnimationTick = 0;
			}else {
				r->lastAnimationTick = *gameTime + 2000;
			}
		}
}

void draw(struct Renderer* renderer, struct Player* p, struct TileMap tm, u32* gameTime){
	draw_background(tm, renderer);
	draw_player(p, renderer, gameTime);
}

