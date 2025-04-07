#include "renderer.h"
#include "instructions.h"

const uint8_t PLAYER_ANIMATION[] = {1, 2, 3};
const uint8_t RatActorId = 1;

struct Renderer* init_renderer(){
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

    struct Renderer* renderer = malloc(sizeof(struct Renderer));
    renderer->animationCounter = 0;
    renderer->lastAnimationTick = 0;
    renderer->lastBackgroundShift = 0;
    renderer->isBackgroundDirty = 1;

    return renderer;
}

void draw_background(struct TileMap* tm, struct Renderer* r){
	if(r->isBackgroundDirty){
		print("Background render \n");
		for(uint8_t i = 0; i < tm->width; i++) {
			for(uint8_t j = 0; j < tm->height; j++) {
				uint8_t currentTileId = tm->tiles[i][j].tileId;
				PPU_SetBackgroundTileID(currentTileId, i, j);
				usleep(1);
			}
		}
		r->isBackgroundDirty = 0;
	}
}



void draw_player(struct Player* p, struct Renderer* r, int* gameTime){
		PPU_SetActorPosition(p->x, p->y, RatActorId);
		if(p->CurrentAnimation == RUNNING && *gameTime >= r->lastAnimationTick + 15 ){
			r->lastAnimationTick = *gameTime;
			r->animationCounter++;
			if(r->animationCounter >= 3){
				r->animationCounter = 0;
			}
			PPU_SetActorTileID(RatActorId, PLAYER_ANIMATION[r->animationCounter]);
		}
}

void draw(struct Renderer* renderer, struct Player* p, struct TileMap* tm, uint8_t* gameTime){
	draw_background(tm, renderer);
	draw_player(p, renderer, gameTime);
}

