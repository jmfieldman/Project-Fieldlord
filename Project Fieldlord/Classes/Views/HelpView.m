//
//  HelpView.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 3/2/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "HelpView.h"

@implementation HelpView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

		_closeField = [UIButton buttonWithType:UIButtonTypeCustom];
		_closeField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		_closeField.frame = self.bounds;
		[_closeField addTarget:self action:@selector(pressedClose:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:_closeField];
		
	}
	return self;
}


- (void) pressedClose:(id)sender {
	[self animateOut];
}

- (void) animateIn {
	self.userInteractionEnabled = YES;
	self.alpha = 1;
}

- (void) animateOut {
	self.alpha = 0;
	self.userInteractionEnabled = NO;
}


@end
