//
//  HelpView.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 3/2/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "HelpView.h"

#define HELPLABEL_FONT @"MuseoSansRounded-300"
#define INSET_L 5
#define INSET_T 5
#define INSET_R 5
#define INSET_B 5

@implementation HelpView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

		_closeField = [UIButton buttonWithType:UIButtonTypeCustom];
		_closeField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
		_closeField.frame = self.bounds;
		[_closeField addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_closeField];
		
		_soundHelp = [self createHelpBubbleWithinFrame:CGRectMake(5, self.bounds.size.height - 130, 100, 92)
											   forText:@"Toggle sound"
												arrowX:10
										arrowDirection:1];
		
		_gamecHelp = [self createHelpBubbleWithinFrame:CGRectMake(30, self.bounds.size.height - 95, 100, 57)
											   forText:@"Check scores in Game Center"
												arrowX:60
										arrowDirection:1];
		
		_powerHelp = [self createHelpBubbleWithinFrame:CGRectMake(100, self.bounds.size.height - 175, 120, 137)
											   forText:@"Arm your power shot for extra touch radius.  Earn another for every ten hits"
												arrowX:61
										arrowDirection:1];
		
		_resetHelp = [self createHelpBubbleWithinFrame:CGRectMake(180, self.bounds.size.height - 90, 120, 52)
											   forText:@"Restart the game"
												arrowX:51
										arrowDirection:1];
		
		_qmarkHelp = [self createHelpBubbleWithinFrame:CGRectMake(275, self.bounds.size.height - 125, 160, 87)
											   forText:@"Help!"
												arrowX:26
										arrowDirection:1];
		
		_ratioHelp = [self createHelpBubbleWithinFrame:CGRectMake(10, 65, 200, 45)
											   forText:@"# of Hits / # of Attempts"
												arrowX:40
										arrowDirection:-1];
		
		_scoreHelp = [self createHelpBubbleWithinFrame:CGRectMake(160, 65, 200, 55)
											   forText:@"Your score:\n25 * (# hits)² / (# attempts)"
												arrowX:100
										arrowDirection:-1];
		
		_instrHelp = [self createHelpBubbleWithinFrame:CGRectMake(20, 160, 280, 100)
											   forText:@"Each round, a random one of your minions is it.  Tap it to score, then start a new round!\n\nTapping hits all minions under your finger.  Since your score is based on your hit ratio, maximize your score by tapping where lots of minions overlap!"
												arrowX:100
										arrowDirection:0];
		
		
		[self addSubview:_soundHelp];
		[self addSubview:_gamecHelp];
		[self addSubview:_powerHelp];
		[self addSubview:_resetHelp];
		[self addSubview:_qmarkHelp];
		
		[self addSubview:_ratioHelp];
		[self addSubview:_scoreHelp];
		[self addSubview:_instrHelp];
		
		
		_bubbles = @[_soundHelp, _gamecHelp, _powerHelp, _resetHelp, _qmarkHelp, _ratioHelp, _scoreHelp, _instrHelp];
	}
	return self;
}


- (void) pressedClose:(id)sender {
	[self animateOut];
}

- (void) animateIn {
	self.userInteractionEnabled = YES;
	
	[UIView animateWithDuration:0.25
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						self.alpha = 1;
					 }
					 completion:nil];
	
	for (UIView *b in _bubbles) {
		b.transform = CGAffineTransformMakeScale(0.4, 0.4);
		b.alpha = 0;
		[self animateArrowForView:b alpha:0 delay:0 duration:0];
		
		float delay = floatBetween(0, 0.2);
		[UIView animateWithDuration:0.65
							  delay:delay
			 usingSpringWithDamping:0.5
			  initialSpringVelocity:0.5
							options:0
						 animations:^{
							 b.transform = CGAffineTransformIdentity;
							 b.alpha = 1;
						 } completion:^(BOOL finished) {
							 
						 }];
		
		[self animateArrowForView:b alpha:1 delay:0.30+delay duration:0.25];
	}
		
	
}

- (void) animateOut {
	[UIView animateWithDuration:0.25
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.alpha = 0;
					 }
					 completion:nil];
	
	self.userInteractionEnabled = NO;
}

- (void) animateArrowForView:(UIView*)view alpha:(float)alpha delay:(float)delay duration:(float)duration {
	/* This is the worst thing I've done in my life. */
	for (UIView *v in view.subviews) {
		if (v.tag == 0xA55) {
			if (delay == 0 && duration == 0) {
				v.alpha = alpha;
			} else {
				[UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
					v.alpha = alpha;
				} completion:nil];
			}
		}
	}
}

- (UIView*) createHelpBubbleWithinFrame:(CGRect)frame
								forText:(NSString*)text
								 arrowX:(float)arrowX
						 arrowDirection:(int)arrowDir {
	
	UIView *container = [[UIView alloc] initWithFrame:frame];
	container.userInteractionEnabled = NO;
	container.backgroundColor = [UIColor clearColor];
	
	UIFont *font = [UIFont fontWithName:HELPLABEL_FONT size:12];
	float labelWidth = frame.size.width - (INSET_R + INSET_L);
	CGRect labelBox = [text boundingRectWithSize:CGSizeMake(labelWidth, 10000)
										 options:NSStringDrawingUsesLineFragmentOrigin
									  attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]
										 context:nil];
	
	
	float bubbleHeight = INSET_T + INSET_B + ceil(labelBox.size.height);
	
	UIView *bubble = [[UIView alloc] initWithFrame:CGRectMake(0, (arrowDir == -1) ? (frame.size.height-bubbleHeight) : 0, INSET_L + INSET_R + ceil(labelBox.size.width), bubbleHeight)];
	bubble.backgroundColor = [UIColor whiteColor];
	bubble.layer.cornerRadius = 4;
	bubble.layer.borderColor = [UIColor blackColor].CGColor;
	bubble.layer.borderWidth = 1;
	bubble.layer.shadowColor = [UIColor blackColor].CGColor;
	bubble.layer.shadowOpacity = 0.7;
	bubble.layer.shadowOffset = CGSizeMake(0, 0);
	bubble.layer.shadowRadius = 2;
	[container addSubview:bubble];
	
	UILabel *bText = [[UILabel alloc] initWithFrame:CGRectMake(INSET_L, INSET_T + bubble.frame.origin.y, ceil(labelBox.size.width), ceil(labelBox.size.height))];
	bText.text = text;
	bText.font = font;
	bText.numberOfLines = 0;
	[container addSubview:bText];
	
	if (arrowDir == 0) return container;
	
	UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(arrowX, (arrowDir == 1) ? bubbleHeight : (0), 1, frame.size.height - bubbleHeight)];
	arrowView.backgroundColor = [UIColor blackColor];
	arrowView.tag = 0xA55;
	[container insertSubview:arrowView belowSubview:bubble];
	
	return container;
}


@end
