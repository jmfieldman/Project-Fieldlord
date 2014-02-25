//
//  GameState.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/25/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

SINGLETON_INTR(GameState);


@property (nonatomic, assign) int shotsAttempted;
@property (nonatomic, assign) int hitsMade;
@property (nonatomic, readonly) double score;


@end
