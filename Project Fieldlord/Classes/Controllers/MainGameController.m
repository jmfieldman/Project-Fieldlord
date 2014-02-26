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
		
		/* Add background */
		UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"game_background"]];
		[self.view addSubview:background];
		
		/* Initialize monsters */
		_activeMonsters = [NSMutableArray array];
		
		/* Create the monster field */
		_monsterField = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
		_monsterField.backgroundColor = [UIColor clearColor];
		[self.view addSubview:_monsterField];
		
		/* Add monsters to field */
		[MonsterInfo monsterAtIndex:0];
		for (int i = 0; i < [MonsterInfo maxMonsterCount]; i++) {
			MonsterView *v = [MonsterInfo monsterAtIndex:i].view;
			[_monsterField addSubview:v];
		}
		
		/*
		UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 200, 50)];
		lab.text = @"Hello World!";
		lab.font = [UIFont fontWithName:@"Dosis-Regular" size:20];
		[self.view addSubview:lab];
		 */
		 
		[self setMonsterCountTo:14];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
			[self animateMonstersNewPositions];
		});
		
		
		/* Add guesture pad last */
		_gesturePad = [[UIView alloc] initWithFrame:_monsterField.bounds];
		_gesturePad.backgroundColor = [UIColor clearColor];
		[_monsterField addSubview:_gesturePad];
		
		UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGuesture:)];
		[_gesturePad addGestureRecognizer:recognizer];
		
	}
	return self;
}

- (float) affinityChance {
	return 0.5;
}

- (float) affinityStrength {
	return 0.5;
}

- (float) fearRadius {
	return 60;
}

- (float) fearMultiplier {
	return 5;
}

- (void) setMonsterCountTo:(int)numMonsters {
	
	if ([_activeMonsters count] < numMonsters) {
		for (int i = [_activeMonsters count]; i < numMonsters; i++) {
			
			int mIndex = [MonsterInfo indexForRandomMonsterWithActiveState:NO];
			MonsterInfo *newMonster = [MonsterInfo monsterAtIndex:mIndex];
			
			/* Add to array */
			[_activeMonsters addObject:newMonster];
			newMonster.active = YES;
			
			/* Set to point off screen for next lead in */
			MonsterView *m = newMonster.view;
			double ang = (rand()%360) * M_PI / 180.0 ;
			m.center = CGPointMake( _monsterField.bounds.size.width/2 + 480*cos(ang), _monsterField.bounds.size.height/2 + 480*sin(ang) );			
		}
	}
}

- (void) animateMonstersNewPositions {
	int i = 0;
	for (MonsterInfo *activeMonster in _activeMonsters) {
		CGPoint center = [self newRandomCenterForActiveMonsterAtIndex:i];
		[activeMonster.view animateToNewCenter:center];
		i++;
	}
}

- (CGPoint) newRandomCenterForActiveMonsterAtIndex:(int)index {
	MonsterInfo *monster = _activeMonsters[index];
	CGPoint point = [monster randomValidCenterInSize:_monsterField.bounds.size];
	
	if (0 && index > 0) {
		/* If we need to create affinity to another monster, do so */
		if (self.affinityChance < floatBetween(0, 1)) {
			MonsterInfo *otherMonster = _activeMonsters[rand()%index];
			point.x += (self.affinityStrength) * (otherMonster.view.center.x - point.x);
			point.y += (self.affinityStrength) * (otherMonster.view.center.y - point.y);
		}
	}
	
	return point;
}

- (void) animateMonstersToAvoidTouchAt:(CGPoint)point {
	float fRadius = self.fearRadius;
	float fMulti  = self.fearMultiplier;
	
	for (MonsterInfo *activeMonster in _activeMonsters) {
		CGPoint currentMonsterCenter = ((CALayer*)activeMonster.view.layer.presentationLayer).position;
		float xdiff = currentMonsterCenter.x - point.x;
		float ydiff = currentMonsterCenter.y - point.y;
		float dist = sqrtf(xdiff * xdiff + ydiff * ydiff);
		NSLog(@"dist: %f", dist);
		if (dist < fRadius) {
			if (fabs(xdiff) < 1) xdiff = 1;
			if (fabs(ydiff) < 1) ydiff = 1;
			float fear = fMulti * (fRadius - dist) / fRadius;
			CGPoint newPoint = CGPointMake(currentMonsterCenter.x + xdiff*fear, currentMonsterCenter.y + ydiff*fear);
			if (newPoint.x < -10) newPoint.x = -10;
			if (newPoint.y < -10) newPoint.y = -10;
			if (newPoint.x > (_monsterField.bounds.size.width  + 10)) newPoint.x = (_monsterField.bounds.size.width  + 10);
			if (newPoint.y > (_monsterField.bounds.size.height + 10)) newPoint.y = (_monsterField.bounds.size.height + 10);
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(floatBetween(0, 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
				[activeMonster.view animateToNewCenter:newPoint];
			});
		}
	}
}

- (void)handleTapGuesture:(UIGestureRecognizer *)gestureRecognizer {
	CGPoint p = [gestureRecognizer locationInView:_gesturePad];
	NSLog(@"tapped at %f %f", p.x, p.y);
	[self animateMonstersToAvoidTouchAt:p];
}


@end
