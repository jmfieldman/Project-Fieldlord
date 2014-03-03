//
//  HelpView.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 3/2/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIView {
	UIButton *_closeField;
	
	UIView *_soundHelp;
	UIView *_gamecHelp;
	UIView *_powerHelp;
	UIView *_resetHelp;
	UIView *_qmarkHelp;
	
	
	UIView *_ratioHelp;
	UIView *_scoreHelp;
	UIView *_instrHelp;
	
	NSArray *_bubbles;
}


- (void) animateIn;

@end
