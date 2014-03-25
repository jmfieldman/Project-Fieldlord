//
//  PreloadedSFX.h
//  ExperimentF
//
//  Created by Jason Fieldman on 11/12/10.
//  Copyright 2010 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PreloadedSFXType {
	PLSFX_MENUTAP              = 0,
	PLSFX_ARMPOWERSHOT         = 1,
	PLSFX_DISARMPOWERSHOT      = 2,
	PLSFX_EMPTYPOWERSHOT       = 3,
	PLSFX_POWERSHOT1           = 4,
	PLSFX_POWERSHOT2           = 5,
	PLSFX_POWERSHOT3           = 6,
	PLSFX_TAPFIELD             = 7,
	
	PLSFX_COUNT,
} PreloadedSFXType_t;

#define NUM_POWERSHOT_VARIETY 3

@interface PreloadedSFX : NSObject {

}

+ (void) setMute:(BOOL)mute;
+ (BOOL) isMute;

+ (void) initializePreloadedSFX;

+ (void) playSFX:(PreloadedSFXType_t)type;

+ (void) setVolume:(float)volume;

@end
