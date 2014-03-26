//
//  MonsterView.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonsterView : UIView {
	SKBounceAnimation *_bodyBobbleWideWAnimation;
	SKBounceAnimation *_bodyBobbleWideHAnimation;
	SKBounceAnimation *_bodyBobbleBackWAnimation;
	SKBounceAnimation *_bodyBobbleBackHAnimation;
	
	BOOL _isBobbling;
}

@property (nonatomic, strong, readonly) UIView *bodyView;
@property (nonatomic, strong, readonly) UIView *faceView;
@property (nonatomic, strong, readonly) UIView *LEyeView;
@property (nonatomic, strong, readonly) UIView *REyeView;
@property (nonatomic, strong, readonly) UIView *noseView;

- (void) animateToNewCenter:(CGPoint)newCenter;
- (void) animateToFaceLeft:(BOOL)left;

@end
