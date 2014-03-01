//
//  MainGameController.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MainGameController.h"

//#define SCORELABEL_FONT @"Dosis-Regular"
#define SCORELABEL_FONT @"MuseoSansRounded-300"
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
		_monsterField = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, ([UIScreen mainScreen].bounds.size.height > 481) ? (516-20-40) : (418-20-40))];
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
		
		_statsView = [[UIView alloc] initWithFrame:CGRectMake(5, self.view.bounds.size.height-48, 310, 40)];
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
		
		
		/* Menu buttons */
		
		const float buttonScale = 1.0;
		
		_helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_helpButton.frame = CGRectMake(280, 20, 40, 40);
		_helpButton.alpha = 1;
		[_helpButton addTarget:self action:@selector(pressedHelp:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_helpButton];
		
		UIImageView *helpIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_question"]];
		helpIcon.center = CGPointMake(22,18);
		helpIcon.alpha = 0.75;
		[_helpButton addSubview:helpIcon];
		helpIcon.transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
		
		
		_restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_restartButton.frame = CGRectMake(320-110, 20, 40, 40);
		_restartButton.alpha = 1;
		[_restartButton addTarget:self action:@selector(pressedRestart:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_restartButton];
		
		UIImageView *restartIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_restart"]];
		restartIcon.center = CGPointMake(22,18);
		restartIcon.alpha = 0.75;
		[_restartButton addSubview:restartIcon];
		restartIcon.transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
		
		
		_gcButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_gcButton.frame = CGRectMake(70, 20, 40, 40);
		_gcButton.alpha = 1;
		[_gcButton addTarget:self action:@selector(pressedRestart:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_gcButton];
		
		UIImageView *gcIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_gc"]];
		gcIcon.center = CGPointMake(22,18);
		gcIcon.alpha = 0.75;
		[_gcButton addSubview:gcIcon];
		gcIcon.transform = CGAffineTransformMakeScale(buttonScale, buttonScale);

		
		
		_muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		_muteButton.frame = CGRectMake(0, 20, 40, 40);
		_muteButton.alpha = 1;
		[_muteButton addTarget:self action:@selector(pressedMute:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_muteButton];
		
		UIImageView *muteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_speaker"]];
		muteIcon.center = CGPointMake(18,18);
		muteIcon.alpha = 0.75;
		[_muteButton addSubview:muteIcon];
		muteIcon.transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
		
		_muteXout = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_xout"]];
		_muteXout.center = CGPointMake(18,18);
		_muteXout.alpha = 0.75;
		[_muteButton addSubview:_muteXout];
		_muteXout.hidden = [PreloadedSFX isMute] ? NO : YES;
		_muteXout.transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
		
		
		
		/* --------- Setup level -------- */
		
		[self setMonsterCountTo:24];
		[self setNewIt];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
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

- (void) pressedMute:(id)sender {
	[PreloadedSFX setMute:![PreloadedSFX isMute]];
	_muteXout.hidden = [PreloadedSFX isMute] ? NO : YES;
	[PreloadedSFX playSFX:PLSFX_MENUTAP];
}

- (void) pressedHelp:(id)sender {
	[PreloadedSFX playSFX:PLSFX_MENUTAP];
}

- (void) pressedRestart:(id)sender {
	[PreloadedSFX playSFX:PLSFX_MENUTAP];
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

- (void) setNewIt {
	_indexIt = rand() % ([_activeMonsters count]);
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
	
	[self animateTapAtPoint:p];
	
	NSArray *monstersTapped = [self monsterIndexesOverlappingPoint:p];
	BOOL     itTapped = [self doesIndexArrayContainIt:monstersTapped];
	
	if (!itTapped) {
		[self animateMonstersToAvoidTouchAt:p];
	} else {
		/* Record hit */
		[GameState sharedInstance].hitsMade++;
		
		/* Scatter */
		[self animateMonstersNewPositions];
		
		/* New it */
		[self setNewIt];
	}
	
	/* Update stats */
	[GameState sharedInstance].shotsAttempted++;
	[self updateStats];
}

- (NSArray*) monsterIndexesOverlappingPoint:(CGPoint)point {
	NSMutableArray *monsters = [NSMutableArray array];
	
	int i = 0;
	for (MonsterInfo *activeMonster in _activeMonsters) {
		CGRect monsterFrame = ((CALayer*)activeMonster.view.layer.presentationLayer).frame;
		if (CGRectContainsPoint(CGRectInset(monsterFrame, -4, -4), point)) {
			[monsters addObject:@(i)];
		}
		i++;
	}
	
	return monsters;
}

- (BOOL) doesIndexArrayContainIt:(NSArray*)indexArray {
	for (NSNumber *n in indexArray) {
		if ([n intValue] == _indexIt) return YES;
	}
	return NO;
}


- (void) animateTapAtPoint:(CGPoint)point {
	UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	tapView.center = point;
	tapView.backgroundColor = [UIColor clearColor];
	tapView.userInteractionEnabled = NO;
	tapView.layer.borderWidth = 10;
	tapView.layer.borderColor = [UIColor colorWithHue:(rand()%256)/256.0 saturation:0.5 brightness:1 alpha:1].CGColor;
	tapView.layer.cornerRadius = 25;
	tapView.layer.shouldRasterize = YES;
	tapView.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
	tapView.transform = CGAffineTransformMakeScale(0.1, 0.1);
	const float duration = 0.35;
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		tapView.transform = CGAffineTransformIdentity;
		tapView.alpha = 0;
	} completion:nil];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
		[tapView removeFromSuperview];
	});

	
	[_monsterField addSubview:tapView];
}


@end
