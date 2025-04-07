#include "scaler.h"
#include "vdma.h"
#include "engine.h"

#define DEBUG

int main()
{
	configureScaler();
	configureVdma();

	ENGINE_Start();

	return 0;
}

