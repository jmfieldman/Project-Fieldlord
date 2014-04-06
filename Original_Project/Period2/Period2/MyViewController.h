//
//  MyViewController.h
//  Period2
//
//  Created by Jason Fieldman on 1/7/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController {
	int _counter;
	int _missedCount;
	
	NSMutableArray *_dancingSquares;
}


@property (nonatomic, strong) UILabel *helloLabel;
@property (nonatomic, strong) UIButton *myButton;


@end
