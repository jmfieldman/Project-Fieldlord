//
//  GameState.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/25/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "GameState.h"

#define SCORE_MULT 20

@implementation GameState

SINGLETON_IMPL(GameState);

- (id) init {
	if ((self = [super init])) {
		_shotgunsLeft = 10;
	}
	return self;
}

- (int) score {
	if (_shotsAttempted == 0) return 0;
	return (SCORE_MULT * _hitsMade * _hitsMade) / _shotsAttempted;
}

@end
