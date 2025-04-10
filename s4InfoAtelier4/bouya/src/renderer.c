#include "renderer.h"
#include "instructions.h"
#include <stdlib.h>

const uint8_t PLAYER_ANIMATION[] = {1, 2, 3};
const uint8_t RatActorId = 1;
const uint8_t BoxActorId = 2;

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

	for(int i = 0; i < sizeof(box_color_instructions)/sizeof(int); i++) {
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  box_color_instructions[i]);
		usleep(1);
	}

	PPU_SetActorTileID(RatActorId, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(2, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(3, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(4, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(5, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(6, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(7, PLAYER_ANIMATION[0]);
	PPU_SetActorTileID(0, PLAYER_ANIMATION[0]);
	usleep(1);
	PPU_SetActorPosition(180, 180, RatActorId);
	PPU_SetActorPosition(180, 180, 2);
	PPU_SetActorPosition(180, 180, 3);
	PPU_SetActorPosition(180, 180, 4);
	PPU_SetActorPosition(180, 180, 5);
	PPU_SetActorPosition(180, 180, 6);
	PPU_SetActorPosition(180, 180, 7);
	PPU_SetActorPosition(180, 180, 0);
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


void draw_background(struct TileMap* map, struct Renderer* r){
	if(r->isBackgroundDirty){
			PPU_SetViewportOffset(r->backgroundOffset, 0);
		r->isBackgroundDirty = 0;
	}
}


/* Si l'obstacle est un acteur
void draw_obstacle(struct Obstacle* o){

}
*/

void draw_player(struct Player p[], struct Renderer* r, u32* gameTime){
		if(p->CurrentAnimation == RUNNING && *gameTime >= r->lastAnimationTick && *gameTime <= 128000 ){
			r->lastAnimationTick = *gameTime + 500;
			r->animationCounter++;
			if(r->animationCounter >= 3){
				r->animationCounter = 0;
			}
			for(u8 d = 0; d < 8; d++){
				PPU_SetActorPosition(p[d].x, p[d].y, d);
				PPU_SetActorTileID(d, PLAYER_ANIMATION[r->animationCounter]);
			}
			if(*gameTime + 500 >= 128000){
				r->lastAnimationTick = 0;
			}else {
				r->lastAnimationTick = *gameTime + 500;
			}
		}
}

void draw(struct Renderer* renderer, struct Player* p, struct TileMap* tm, u32* gameTime){
	draw_background(tm, renderer);
	draw_player(p, renderer, gameTime);
	// draw_obstacle
}

