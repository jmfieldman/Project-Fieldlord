//
//  MainGameController.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MainGameController.h"

@interface MainGameController ()

@end


@implementation MainGameController

SINGLETON_IMPL(MainGameController);

- (id) init {
	if ((self = [super init])) {
		
		self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		self.view.backgroundColor = [UIColor whiteColor];
		
		/* Create the monster field */
		_monsterField = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		_monsterField.backgroundColor = [UIColor clearColor];
		[self.view addSubview:_monsterField];
		
		/* Add monsters to field */
		[MonsterInfo monsterAtIndex:0];
		for (int i = 0; i < [MonsterInfo maxMonsterCount]; i++) {
			MonsterView *v = [MonsterInfo monsterAtIndex:i].view;
			[_monsterField addSubview:v];
		}
		
		UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 200, 50)];
		lab.text = @"Hello World!";
		lab.font = [UIFont fontWithName:@"Dosis-Regular" size:20];
		[self.view addSubview:lab];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
			[self animateMonsterCountTo:3];
		});
	}
	return self;
}


- (void) animateMonsterCountTo:(int)numMonsters {
	
	if (_currentMonsterCount < numMonsters) {
		for (int i = _currentMonsterCount; i < numMonsters; i++) {
			MonsterView *m = [MonsterInfo monsterAtIndex:i].view;
			double ang = rand();
			m.center = CGPointMake( 160 + 240*cos(ang), 240 + 320*sin(ang) );
			
			[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				m.center = CGPointMake(rand()%200+60, rand()%200+60);
			} completion:nil];
			
		}
	}
	
}


@end
