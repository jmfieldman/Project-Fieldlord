//
//  MainGameController.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MainGameController.h"

#define SCORELABEL_FONT @"Dosis-Regular"
#define SCORELABEL_SIZE 20

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
		_monsterField = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height > 481) ? 44 : 0, 320, 480)];
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
		
		/* --------- Views --------- */
		
		_statsView = [[UIView alloc] initWithFrame:CGRectMake(5, 520, 310, 40)];
		_statsView.backgroundColor = [UIColor whiteColor];
		_statsView.layer.cornerRadius = 16;
		_statsView.layer.borderColor = [UIColor blackColor].CGColor;
		_statsView.layer.borderWidth = 1.5;
		_statsView.layer.shadowOpacity = 0.5;
		_statsView.layer.shadowColor = [UIColor blackColor].CGColor;
		_statsView.layer.shadowOffset = CGSizeMake(1, 1);
		_statsView.layer.shadowRadius = 2;
		_statsView.layer.shouldRasterize = YES;
		_statsView.layer.rasterizationScale = [UIScreen mainScreen].scale;
		[self.view addSubview:_statsView];
		
		_reticuleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reticule"]];
		_reticuleView.frame = CGRectMake(4, 7, 24, 24);
		[_statsView addSubview:_reticuleView];
		
		_shotsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 7, 200, 24)];
		_shotsLabel.text = @"0 / 0";
		_shotsLabel.font = [UIFont fontWithName:SCORELABEL_FONT size:SCORELABEL_SIZE];
		[_statsView addSubview:_shotsLabel];
		
		_scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 133, 24)];
		_scoreLabel.text = @"0 pts";
		_scoreLabel.textAlignment = NSTextAlignmentRight;
		_scoreLabel.font = [UIFont fontWithName:SCORELABEL_FONT size:SCORELABEL_SIZE];
		[_statsView addSubview:_scoreLabel];
		 
		[self updateStats];
		
		/* --------- Setup level -------- */
		
		[self setMonsterCountTo:24];
		
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

- (void) updateStats {
	_shotsLabel.text = [NSString stringWithFormat:@"%d / %d", [GameState sharedInstance].hitsMade, [GameState sharedInstance].shotsAttempted];
	_scoreLabel.text = [NSString stringWithFormat:@"%d pts", [GameState sharedInstance].score];
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
			CGSize monsterSize = activeMonster.view.bounds.size;
			if (fabs(xdiff) < 1) xdiff = 1;
			if (fabs(ydiff) < 1) ydiff = 1;
			float fear = fMulti * (fRadius - dist) / fRadius;
			CGPoint newPoint = CGPointMake(currentMonsterCenter.x + xdiff*fear, currentMonsterCenter.y + ydiff*fear);
			if (newPoint.x < monsterSize.width/2)  newPoint.x = monsterSize.width/2;
			if (newPoint.y < monsterSize.height/2) newPoint.y = monsterSize.height/2;
			if (newPoint.x > (_monsterField.bounds.size.width  - monsterSize.width/2))  newPoint.x = (_monsterField.bounds.size.width  - monsterSize.width/2);
			if (newPoint.y > (_monsterField.bounds.size.height - monsterSize.height/2)) newPoint.y = (_monsterField.bounds.size.height - monsterSize.height/2);
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
	
	if (rand()%3 == 0) [GameState sharedInstance].hitsMade++;
	[GameState sharedInstance].shotsAttempted++;
	[self updateStats];
}


@end
