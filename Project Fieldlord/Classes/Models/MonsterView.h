//
//  MonsterView.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonsterView : UIView

@property (nonatomic, strong, readonly) UIView *bodyView;
@property (nonatomic, strong, readonly) UIView *LEyeView;
@property (nonatomic, strong, readonly) UIView *REyeView;
@property (nonatomic, strong, readonly) UIView *noseView;


- (void) animateBlink;

@end
