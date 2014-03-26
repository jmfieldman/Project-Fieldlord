//
//  PreloadedSFX.h
//  ExperimentF
//
//  Created by Jason Fieldman on 11/12/10.
//  Copyright 2010 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PreloadedSFXType {
	PLSFX_MENUTAP = 0,
	PLSFX_ARMPOWERSHOT,
	PLSFX_DISARMPOWERSHOT,
	PLSFX_EMPTYPOWERSHOT,
	PLSFX_POWERSHOT1,
	PLSFX_POWERSHOT2,
	PLSFX_POWERSHOT3,
	PLSFX_TAPFIELD,
	
	PLSFX_TAPPEDWRONG1,
	PLSFX_TAPPEDWRONG2,
	PLSFX_TAPPEDWRONG3,
	PLSFX_TAPPEDWRONG4,
	PLSFX_TAPPEDWRONG5,
	PLSFX_TAPPEDWRONG6,
	
	PLSFX_TAPPEDMISS1,
	PLSFX_TAPPEDMISS2,
	PLSFX_TAPPEDMISS3,
	
	PLSFX_TAPPEDGOTIT1,
	PLSFX_TAPPEDGOTIT2,
	PLSFX_TAPPEDGOTIT3,
	PLSFX_TAPPEDGOTIT4,
	PLSFX_TAPPEDGOTIT5,
	PLSFX_TAPPEDGOTIT6,
	
	PLSFX_COUNT,
} PreloadedSFXType_t;

#define NUM_POWERSHOT_VARIETY 3

#define NUM_TAPPEDWRONG       6
#define NUM_TAPPEDMISS        3
#define NUM_TAPPEDGOTIT       6

@interface PreloadedSFX : NSObject {

}

+ (void) setMute:(BOOL)mute;
+ (BOOL) isMute;

+ (void) initializePreloadedSFX;

+ (void) playSFX:(PreloadedSFXType_t)type;

+ (void) setVolume:(float)volume;

@end
