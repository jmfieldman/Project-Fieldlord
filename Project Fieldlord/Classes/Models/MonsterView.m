//
//  MonsterView.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MonsterView.h"

@implementation MonsterView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {

		self.backgroundColor = [UIColor clearColor];
		
		_bodyView = [[UIView alloc] initWithFrame:self.bounds];
		_bodyView.backgroundColor = [UIColor redColor];
		[self addSubview:_bodyView];
		
		_LEyeView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 5, 5)];
		_LEyeView.backgroundColor = [UIColor blackColor];
		[self addSubview:_LEyeView];
		
		_REyeView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 5, 5)];
		_REyeView.backgroundColor = [UIColor blackColor];
		[self addSubview:_REyeView];
		
		_noseView = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 5, 5)];
		_noseView.backgroundColor = [UIColor blackColor];
		[self addSubview:_noseView];
		
		[self performSelector:@selector(animateBlinkDefault) withObject:nil afterDelay:2];
		
	}
	return self;
}


- (void) animateBlinkDefault {
	[self animateBlinkWithSpeed:0.15 duration:0];
}

- (void) animateBlinkWithSpeed:(float)speed duration:(float)duration {
	[UIView animateWithDuration:speed
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 _LEyeView.transform = CGAffineTransformMakeScale(1, 0);
						 _REyeView.transform = CGAffineTransformMakeScale(1, 0);
					 } completion:^(BOOL finished) {
						 [UIView animateWithDuration:speed
											   delay:duration
											 options:UIViewAnimationOptionCurveEaseInOut
										  animations:^{
											  _LEyeView.transform = CGAffineTransformIdentity;
											  _REyeView.transform = CGAffineTransformIdentity;
										  } completion:^(BOOL finished) {
											  
										  }];
					 }];
}


- (void) animateBugeyesDefault {
	[self animateBugeyesWithScale:1.5 duration:0.5];
}

- (void) animateBugeyesWithScale:(float)scale duration:(float)duration {
	[UIView animateWithDuration:0.25
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 _LEyeView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(scale, scale), M_PI_2);
						 _REyeView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(scale, scale), M_PI_2);
					 } completion:^(BOOL finished) {
						 [UIView animateWithDuration:0.25
											   delay:duration
											 options:UIViewAnimationOptionCurveEaseInOut
										  animations:^{
											  _LEyeView.transform = CGAffineTransformIdentity;
											  _REyeView.transform = CGAffineTransformIdentity;
										  } completion:^(BOOL finished) {
											  
										  }];
					 }];
}


@end
