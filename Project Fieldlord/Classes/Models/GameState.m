//
//  GameState.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/25/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "GameState.h"
#import "MainGameController.h"

#define SCORE_MULT 20
#define CURRENT_DIC_VERSION 1

@implementation GameState

SINGLETON_IMPL(GameState);

- (id) init {
	if ((self = [super init])) {
		_shotgunsLeft = DEFAULT_SHOTGUNS;
	}
	return self;
}

- (int64_t) score {
	if (_shotsAttempted == 0) return 0;
	return (SCORE_MULT * _hitsMade * _hitsMade) / _shotsAttempted;
}

- (void) saveState {
	PersistentDictionary *dic  = [PersistentDictionary dictionaryWithName:@"gamestate"];
	dic.dictionary[@"version"] = @(CURRENT_DIC_VERSION);
	dic.dictionary[@"shots"]   = @(_shotsAttempted);
	dic.dictionary[@"hits"]    = @(_hitsMade);
	dic.dictionary[@"shotgun"] = @(_shotgunsLeft);
	dic.dictionary[@"it"]      = @([[MainGameController sharedInstance] it]);

	NSMutableArray *monsters = [NSMutableArray array];
	for (int i = 0; i < [MonsterInfo maxMonsterCount]; i++) {
		MonsterInfo *mi = [MonsterInfo monsterAtIndex:i];
		MonsterView *mv = mi.view;
		
		NSMutableDictionary *center = [NSMutableDictionary dictionary];
		center[@"x"] = @(mv.center.x);
		center[@"y"] = @(mv.center.y);
		center[@"active"] = @(mi.active);
		[monsters addObject:center];
	}
	dic.dictionary[@"monster_centers"] = monsters;
	[dic saveToFile];
}

- (NSArray*) loadState {
	PersistentDictionary *dic = [PersistentDictionary dictionaryWithName:@"gamestate"];
	if ([dic.dictionary[@"version"] intValue] != CURRENT_DIC_VERSION) {
		return nil;
	}
	
	_shotsAttempted = [dic.dictionary[@"shots"]   intValue];
	_hitsMade       = [dic.dictionary[@"hits"]    intValue];
	_shotgunsLeft   = [dic.dictionary[@"shotgun"] intValue];
		
	return dic.dictionary[@"monster_centers"];
}


@end
