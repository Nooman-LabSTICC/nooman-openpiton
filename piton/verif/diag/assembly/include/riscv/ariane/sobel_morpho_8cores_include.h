#ifndef PREESM_H
#define PREESM_H

#define IN
#define OUT

typedef unsigned char uchar;

#define PREESM_LOOP_SIZE	3
#define LOOP_SIZE		PREESM_LOOP_SIZE //Compatibility issue

//#define NB_CORES		7



 //********************** YUVREAD.C **********************

void initReadYUV(int width, int height) {
    int fsize;
    if((ptfile = fopen(PATH_VIDEO, "rb")) == NULL )
    {
        fprintf(stderr,"ERROR: Task read cannot open yuv_file '%s'\n", PATH_VIDEO);
#ifdef _WIN32
        system("PAUSE");
#endif
        exit(0);
    }

#ifdef PREESM_VERBOSE
    printf("Opened file '%s'\n", PATH_VIDEO);
#endif

    // Obtain file size:
    fseek (ptfile , 0 , SEEK_END);
    fsize = ftell (ptfile);
    rewind (ptfile);
    if(fsize < NB_FRAME*(width*height + width*height/2))
    {
        fprintf(stderr,"ERROR: Task read yuv_file incorrect size");
#ifdef _WIN32
        system("PAUSE");
#endif
        return;
    }

#ifdef PREESM_VERBOSE
    printf("Correct size for yuv_file '%s'\n", PATH_VIDEO);
#endif

    // Set initial clock
    startTiming(0);
}

/*========================================================================

   readYUV DEFINITION

   ======================================================================*/
void readYUV(int width, int height, unsigned char *y, unsigned char *u, unsigned char *v) {

  if (ftell(ptfile) / (width*height + width*height / 2) >= NB_FRAME){
    rewind(ptfile);
  }

  if (ftell(ptfile) / (width*height + width*height / 2) % FPS_INTERVAL == 0) {
    //unsigned int time = 0;
    //time = stopTiming(0);
    //fprintf(stderr, "\nMain: %d frames in %d us - %f fps\n", FPS_INTERVAL, time, (1000000*FPS_INTERVAL) / (float)time);
    fprintf(stderr, "\nMain: %d frames in %d us - %f fps\n", 0, 0, 0);
    //startTiming(0);
  }
  int res = fread(y, sizeof(char), width * height, ptfile);
  res += fread(u, sizeof(char), width * height / 4, ptfile);
  res += fread(v, sizeof(char), width * height / 4, ptfile);
  if (res == 0) {
    printf("Error while read file\n");
    exit(1);
  }
}

void endYUVRead(){
	fclose(ptfile);
}

 //********************** MORPH.C **********************

void dilation (int height , int width,
			   const int window,
			   unsigned char *input,
			   unsigned char *output)
{	
	int i,j;
	int k,l;
	// Process pixels one by one
	for(j=window; j< height-window; j++){
		for(i=0;i<width;i++){
			int res = -1;
			// output pixel is the median of a 3x3 window
			// Get the 9 pixels
			for(l=-window;l<=window;l++){
				int y = j+l;
				for(k=-window+abs(l);k<=window-abs(l);k++){
					int x = min(max(i+k,0),width-1);
					res = max(input[y*width+x],res);
				}
			}

			output[(j-window)*width+i] = res;
		}
	}
}

void erosion (int height , int width, 
			  const int window,
			  unsigned char *input,
			  unsigned char *output)
{	
	int i,j;
	int k,l;
	// Process pixels one by one
	for(j=window; j< height-window; j++){
		for(i=0;i<width;i++){
			int res = 256;
			// output pixel is the median of a 3x3 window
			// Get the 9 pixels
			for(l=-window;l<=window;l++){
				int y = j+l;
				for(k=-window+abs(l);k<=window-abs(l);k++){
					int x = min(max(i+k,0),width-1);
					res = min(input[y*width+x],res);
				}
			}

			output[(j-window)*width+i] = res;
		}
	}
}
 //********************** SPLITMERGE.C **********************

void split(int nbSlice, int width, int height, int overlap, unsigned char *input, unsigned char *output){
	if(output != NULL){
		int i;
		int sliceSize =  width*height/nbSlice;
		// Fill first and last line(s) with 0
		memset(output,0,width*overlap);
		// First Slice
		memcpy(output+width*overlap, input, sliceSize);
		// Copy next line(s) if several slice
		if (nbSlice > 1){
			memcpy(output +  width*overlap + sliceSize , input + sliceSize, width*overlap);
		}
		// Slice other than first and last
		for(i=1; i<nbSlice-1; i++){
			int destIndex = i*(sliceSize+2*width*overlap);
			memcpy(output + destIndex, input+i*sliceSize-width*overlap, sliceSize+2*width*overlap);
		}
		// Last Slice
		i = nbSlice-1;
		if(nbSlice > 1){
			// we have i = nbSlice -1;
			int destIndex = i*(sliceSize+2*width*overlap);
			memcpy(output + destIndex, input+i*sliceSize-width*overlap, sliceSize+width*overlap);
		}
		// Last line
		memset(output + (height+overlap*(nbSlice*2-1))*width,0,width*overlap);
	} else {
		// Output has been splitted and is null
		// Fill first and last line with 0
		memset(input - width*overlap, 0, width*overlap);
		// Last line
		memset(input + height*width, 0, width*overlap);
	}
}


void merge(int nbSlice, int width, int height, unsigned char *input, unsigned char *output){
	int i;
	int sliceSize =  width*height/nbSlice;
	// Copy the slice content except the first and last lines
	for(i = 0; i< nbSlice; i++){
		int idx = i*(sliceSize+2*width);
		memcpy(output+i*sliceSize, input+idx+width, sliceSize);
	}
}

 //********************** SOBEL.C **********************

void sobel(int width, int height, unsigned char *input, unsigned char *output){
    int i,j;

    // Apply the filter
    for(j=1; j<height-1; j++){
        for(i=1; i<width-1; i++){
            int gx = -input[(j-1)*width + i-1] -2*input[  j*width + i-1] -input[(j+1)*width + i-1]
                     +input[(j-1)*width + i+1] +2*input[  j*width + i+1] +input[(j+1)*width + i+1];
            int gy = -input[(j-1)*width + i-1] -2*input[(j-1)*width + i] -input[(j-1)*width + i+1]
                     +input[(j+1)*width + i-1] +2*input[(j+1)*width + i] +input[(j+1)*width + i+1];

            output[(j-1)*width + i] = (abs(gx) + abs(gy))/8;
        }
    }

    // Fill the left and right sides
    for(j=0; j<height-2 ; j++){
        output[j*width] = 0;
        output[(j+1)*width-1] = 0;
    }
}

 //********************** YUVDISPLAY.C **********************

int exitCallBack(void* userdata, SDL_Event* event){
	return 1;
	if (event->type == SDL_QUIT){
		printf("Exit request from GUI.\n");
		preesmStopThreads = 1;
		return 0;
	}

	return 1;
}

/**
* Initializes a display frame. Be careful, once a window size has been chosen,
* all videos must share the same window size
*
* @param id display unique identifier
* @param width width
* @param height heigth
*/
void yuvDisplayInit(int id, int width, int height)
{
	return;

	if (display.initialized == 0)
	{
		display.currentXMin = 0;
	}

	if (height > DISPLAY_H)
	{
		fprintf(stderr, "SDL screen is not high enough for display %d.\n", id);
#ifdef _WIN32
        system("PAUSE");
#endif
		exit(1);
	}
	else if (id >= NB_DISPLAY)
	{
		fprintf(stderr, "The number of displays is limited to %d.\n", NB_DISPLAY);
#ifdef _WIN32
        system("PAUSE");
#endif
		exit(1);
	}
	else if (display.currentXMin + width > DISPLAY_W)
	{
		fprintf(stderr, "The number is not wide enough for display %d.\n", NB_DISPLAY);
#ifdef _WIN32
		system("PAUSE");
#endif
		exit(1);
	}


#ifdef PREESM_VERBOSE
	printf("SDL screen height OK, width OK, number of displays OK.\n", id);
#endif

	if (display.initialized == 0)
	{
		// Generating window name
		char* name = "Display";
		display.initialized = 1;

		printf("SDL_Init_Start\n");

		if (SDL_Init(SDL_INIT_VIDEO))
		{
			fprintf(stderr, "Could not initialize SDL - %s\n", SDL_GetError());
			exit(1);
		}

		printf("SDL_Init_end\n");

		/* Initialize SDL TTF for text display */
		if (TTF_Init())
		{
			printf("TTF initialization failed: %s\n", TTF_GetError());
		}

		printf("TTF_Init\n");

		/* Initialize Font for text display */
		//display.text_font = TTF_OpenFont("./arial.ttf", 20);
		display.text_font = TTF_OpenFont(PATH_TTF, 20);
		if (!display.text_font)
		{
			printf("TTF_OpenFont: %s\n", TTF_GetError());
		}

		display.screen = SDL_CreateWindow(name, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
			DISPLAY_W, DISPLAY_H, SDL_WINDOW_SHOWN);
		if (!display.screen)
		{
			fprintf(stderr, "SDL: could not set video mode - exiting\n");
			exit(1);
		}

		display.renderer = SDL_CreateRenderer(display.screen, -1, SDL_RENDERER_ACCELERATED);
		if (!display.renderer)
		{
			fprintf(stderr, "SDL: could not create renderer - exiting\n");
			exit(1);
		}
	}

	if (display.textures[id] == NULL)
	{

		display.textures[id] = SDL_CreateTexture(display.renderer,
			SDL_PIXELFORMAT_IYUV,
			SDL_TEXTUREACCESS_STREAMING,
			width, height);

		if (!display.textures[id])
		{
			fprintf(stderr, "SDL: could not create texture - exiting\n");
			exit(1);
		}

		display.currentXMin += width;
	}

	display.stampId = 0;
	for (int i = 0; i<FPS_MEAN; i++){
		startTiming(i + 1);
	}

	printf("register\n");
	SDL_SetEventFilter(exitCallBack, NULL);
}

void yuvDisplay(int id, unsigned char *y, unsigned char *u, unsigned char *v){
	return;
	yuvDisplayWithNbSlice(id, -1, y, u, v);
}

void yuvDisplayWithNbSlice(int id, int nbSlice, unsigned char *y, unsigned char *u, unsigned char *v)
{
	return;
	SDL_Texture* texture = display.textures[id];
	int w, h;

	// Retrieve texture attribute
	SDL_QueryTexture(texture, NULL, NULL, &w, &h);

	SDL_UpdateYUVTexture(
		texture, NULL,
		y, w,
		u, w / 2,
		v, w / 2
		);

	SDL_Rect screen_rect;

	screen_rect.w = w;
	screen_rect.h = h;
	screen_rect.x = w*id;
	screen_rect.y = 0;

	SDL_RenderCopy(display.renderer, texture, NULL, &screen_rect);

	/* Draw FPS text */
	char fps_text[20];
	SDL_Color colorWhite = { 255, 255, 255, 255 };

	int time = stopTiming(display.stampId + 1);
	sprintf(fps_text, "FPS: %.2f", 1. / (time / 1000000. / FPS_MEAN));
	startTiming(display.stampId + 1);
	display.stampId = (display.stampId + 1) % FPS_MEAN;

	SDL_Surface* fpsText = TTF_RenderText_Blended(display.text_font, fps_text, colorWhite);
	SDL_Texture* fpsTexture = SDL_CreateTextureFromSurface(display.renderer, fpsText);

	int fpsWidth, fpsHeight;
	SDL_QueryTexture(fpsTexture, NULL, NULL, &fpsWidth, &fpsHeight);
	SDL_Rect fpsTextRect;

	fpsTextRect.x = 0;
	fpsTextRect.y = 0;
	fpsTextRect.w = fpsWidth;
	fpsTextRect.h = fpsHeight;
	SDL_RenderCopy(display.renderer, fpsTexture, NULL, &fpsTextRect);

	/* Free resources */
	SDL_FreeSurface(fpsText);
	SDL_DestroyTexture(fpsTexture);

	/* Draw NbSlice Text */
	if (nbSlice > 0){
		char slice_text[20];

		sprintf(slice_text, "nbSlice: %d", nbSlice);

		SDL_Surface* sliceText = TTF_RenderText_Blended(display.text_font, slice_text, colorWhite);
		SDL_Texture* sliceTexture = SDL_CreateTextureFromSurface(display.renderer, sliceText);

		int sliceWidth, sliceHeight;
		SDL_QueryTexture(sliceTexture, NULL, NULL, &sliceWidth, &sliceHeight);
		SDL_Rect sliceTextRect;

		sliceTextRect.x = 0;
		sliceTextRect.y = fpsHeight;
		sliceTextRect.w = sliceWidth;
		sliceTextRect.h = sliceHeight;
		SDL_RenderCopy(display.renderer, sliceTexture, NULL, &sliceTextRect);

		/* Free resources */
		SDL_FreeSurface(sliceText);
		SDL_DestroyTexture(sliceTexture);
	}

	SDL_RenderPresent(display.renderer);

	SDL_Event event;
	// Grab all the events off the queue.
	while (SDL_PollEvent(&event))
	{
		switch (event.type)
		{
		default:
			break;
		}
	}
}


void yuvFinalize(int id)
{
	return;
	SDL_DestroyTexture(display.textures[id]);
	SDL_DestroyRenderer(display.renderer);
	SDL_DestroyWindow(display.screen);
}

#endif