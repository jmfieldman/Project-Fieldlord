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
		_bodyView.layer.cornerRadius = 4;
		_bodyView.layer.borderWidth = 1;
		_bodyView.layer.shadowOpacity = 0.5;
		_bodyView.layer.shadowColor = [UIColor blackColor].CGColor;
		_bodyView.layer.shadowOffset = CGSizeMake(1, 1);
		_bodyView.layer.shadowRadius = 2;
		_bodyView.layer.shouldRasterize = YES;
		_bodyView.layer.rasterizationScale = [UIScreen mainScreen].scale;
		_bodyView.alpha = 0.5;
		[self addSubview:_bodyView];
		
		_faceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
		_faceView.backgroundColor = [UIColor clearColor];
		[self addSubview:_faceView];
		
		_LEyeView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 5, 5)];
		_LEyeView.backgroundColor = [UIColor blackColor];
		[_faceView addSubview:_LEyeView];
		
		_REyeView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 5, 5)];
		_REyeView.backgroundColor = [UIColor blackColor];
		[_faceView addSubview:_REyeView];
		
		_noseView = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 5, 5)];
		_noseView.backgroundColor = [UIColor blackColor];
		[_faceView addSubview:_noseView];
		
		/* Create animations */
		float shrink = 0.9;
		
		_bodyBobbleWideWAnimation = [SKBounceAnimation animationWithKeyPath:@"transform.scale.x"];
		_bodyBobbleWideWAnimation.fromValue = [NSNumber numberWithFloat:1.0];
		_bodyBobbleWideWAnimation.toValue = [NSNumber numberWithFloat:shrink];
		_bodyBobbleWideWAnimation.duration = 0.4;
		_bodyBobbleWideWAnimation.fillMode = kCAFillModeForwards;
		_bodyBobbleWideWAnimation.removedOnCompletion = NO;
		_bodyBobbleWideWAnimation.stiffness = SKBounceAnimationStiffnessLight;
		_bodyBobbleWideWAnimation.numberOfBounces = 2;
		
		_bodyBobbleWideHAnimation = [SKBounceAnimation animationWithKeyPath:@"transform.scale.y"];
		_bodyBobbleWideHAnimation.fromValue = [NSNumber numberWithFloat:1.0];
		_bodyBobbleWideHAnimation.toValue = [NSNumber numberWithFloat:shrink];
		_bodyBobbleWideHAnimation.duration = _bodyBobbleWideWAnimation.duration;
		_bodyBobbleWideHAnimation.fillMode = kCAFillModeForwards;
		_bodyBobbleWideHAnimation.removedOnCompletion = NO;
		_bodyBobbleWideHAnimation.stiffness = _bodyBobbleWideWAnimation.stiffness;
		_bodyBobbleWideHAnimation.numberOfBounces = 2;

		_bodyBobbleBackWAnimation = [SKBounceAnimation animationWithKeyPath:@"transform.scale.x"];
		_bodyBobbleBackWAnimation.fromValue = [NSNumber numberWithFloat:shrink];
		_bodyBobbleBackWAnimation.toValue = [NSNumber numberWithFloat:1.0];
		_bodyBobbleBackWAnimation.duration = 0.4;
		_bodyBobbleBackWAnimation.fillMode = kCAFillModeForwards;
		_bodyBobbleBackWAnimation.removedOnCompletion = NO;
		_bodyBobbleBackWAnimation.stiffness = SKBounceAnimationStiffnessLight;
		_bodyBobbleBackWAnimation.numberOfBounces = 2;

		_bodyBobbleBackHAnimation = [SKBounceAnimation animationWithKeyPath:@"transform.scale.y"];
		_bodyBobbleBackHAnimation.fromValue = [NSNumber numberWithFloat:shrink];
		_bodyBobbleBackHAnimation.toValue = [NSNumber numberWithFloat:1.0];
		_bodyBobbleBackHAnimation.duration = _bodyBobbleBackWAnimation.duration;
		_bodyBobbleBackHAnimation.fillMode = kCAFillModeForwards;
		_bodyBobbleBackHAnimation.removedOnCompletion = NO;
		_bodyBobbleBackHAnimation.stiffness = _bodyBobbleBackWAnimation.stiffness;
		_bodyBobbleBackHAnimation.numberOfBounces = 2;
		
		
		[self animateBlinkDefault];
	}
	return self;
}

- (void) animateToFaceLeft:(BOOL)left {
	[UIView animateWithDuration:0.4
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 _faceView.frame = CGRectMake(left?0:(_bodyView.bounds.size.width-_faceView.bounds.size.width), 0, _faceView.bounds.size.width, _faceView.bounds.size.height);
					 } completion:nil];
}

- (void) animateToNewCenter:(CGPoint)newCenter {
	/*
	[UIView animateWithDuration:1.5
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.center = newCenter;
					 } completion:nil];
	*/
	self.center = newCenter;
	SKBounceAnimation *animation = [SKBounceAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [NSValue valueWithCGPoint:((CALayer*)self.layer.presentationLayer).position];
	animation.toValue = [NSValue valueWithCGPoint:newCenter];
	animation.duration = 2.5;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	animation.stiffness = SKBounceAnimationStiffnessHeavy;
	animation.numberOfBounces = 3;
	[self.layer addAnimation:animation forKey:@"moveMonster"];
	
	[self animateBodyBobbleWithDuration:animation.duration * 0.20];
}


- (void) animateBlinkDefault {
	[self animateBlinkWithSpeed:0.125 duration:0];
	
	[self performSelector:@selector(animateBlinkDefault) withObject:nil afterDelay:(rand()%300/30.0)+2];
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


- (void) animateBodyBobbleDefault {
	[self animateBodyBobbleWithDuration:1];
}

- (void) animateBodyBobbleWithDuration:(float)duration {
	
	if (_isBobbling) return;
	_isBobbling = YES;
	
	[self.layer addAnimation:_bodyBobbleWideWAnimation forKey:@"bobbleW"];
	[self.layer addAnimation:_bodyBobbleWideHAnimation forKey:@"bobbleH"];
	
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
		_isBobbling = NO;
				
		[self.layer addAnimation:_bodyBobbleBackWAnimation forKey:@"bobbleW"];
		[self.layer addAnimation:_bodyBobbleBackHAnimation forKey:@"bobbleH"];
	
		if (rand()%2==0) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
			[PreloadedSFX playSFX:PLSFX_POP1+rand()%NUM_POP];
		});
		
	});
	
}


@end
