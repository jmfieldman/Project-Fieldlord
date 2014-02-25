//
//  MainGameController.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonsterView.h"
#import "MonsterInfo.h"
#import "GameState.h"

@interface MainGameController : UIViewController {
	int _currentMonsterCount;
	
	/* Views */
	UIView *_monsterField;
}

SINGLETON_INTR(MainGameController);

- (void) animateMonsterCountTo:(int)numMonsters;

@end
