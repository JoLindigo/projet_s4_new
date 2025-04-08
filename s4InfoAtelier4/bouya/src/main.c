/*#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "mycolorRegister.h"
#include "sleep.h"
#include "instructions.h"
#include "api/ppu/ppu.h"

#define DEBUG

int main()
{
	configureScaler();
	configureVdma();

	//int colorA = 0;
	//int colorB = 0xFF;
	//MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 4, colorB);
		//MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, colorA );
		//MYCONTROLLERPPU_mWriteReg(XPAR_MYCONTROLLLERPPU_0_S00_AXI_BASEADDR, 0, instruction);
		//colorA = colorA + 1024;
		//sleep(1);

		for(int i = 0; i < sizeof(tile_id_instructions)/sizeof(int); i++) {
			MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  tile_id_instructions[i]);
			usleep(1);
		}

		for(int i = 0; i < sizeof(tile_color_instructions)/sizeof(int); i++) {
			MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0,  tile_color_instructions[i]);
			usleep(1);
		}

		while(1) {
			for(int i = 0; i < 512; i++) {
				PPU_SetViewportOffset(i, i);
				usleep(50000);
			}
		}
	return 0;
}
*/


#include "plateforme.h"
#include "tilemap.h" 
#include <stdio.h>
#ifdef _WIN32
#include <windows.h>
#define usleep(x) Sleep((x)/1000)
#else
#include <unistd.h>
#endif

int main() {
    printf("Test de génération d'obstacles\r\n");

    // Initialiser les obstacles
    init_obstacles();

    // Créer une tilemap de test (si nécessaire)
    struct TileMap* map = initialize_map();

    int scroll_x = 0;

    while (1) {
        // Générer des obstacles à chaque mise à jour du scroll
        generate_obstacles(map, scroll_x);

        // Mettre à jour les obstacles avec la position du scroll
        update_obstacles(map, scroll_x);

        // Incrémenter le scroll pour simuler le mouvement
        scroll_x += 16;

        // Afficher la position des obstacles pour tester
        for (int i = 0; i < MAX_OBSTACLES; i++) {
            if (obstacles[i].active) {
                printf("Obstacle %d à x=%d, y=%d\r\n", i, obstacles[i].x, obstacles[i].y);
            }
        }

        usleep(100000);  // Attendre avant la prochaine mise à jour
    }

    return 0;
}
