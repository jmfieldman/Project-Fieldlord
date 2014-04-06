//
//  MyViewController.m
//  Period2
//
//  Created by Jason Fieldman on 1/7/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController



- (id) init {
	
	if ((self = [super init])) {
		
		srand(time(0));
		
		_counter = 0;
		
		self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
		self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
		
		
		UIButton *missed = [UIButton buttonWithType:UIButtonTypeCustom];
		missed.frame = self.view.frame;
		[missed addTarget:self action:@selector(missed:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:missed];
		
		
		
		_helloLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
		_helloLabel.text = @"Hello World";
		_helloLabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:_helloLabel];
		
		
		
		_dancingSquares = [NSMutableArray array];
		for (int i = 0; i < 10; i++) {
			
			UIView *v = [[UIView alloc] initWithFrame:[self randomFrame]];
			v.userInteractionEnabled = NO;
			v.backgroundColor = [self randomColor];
			[self.view addSubview:v];
			[_dancingSquares addObject:v];

			
			{
				UIView *a = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 5, 5)];
				a.backgroundColor = [UIColor blackColor];
				[v addSubview:a];
			}
			
			{
				UIView *a = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 5, 5)];
				a.backgroundColor = [UIColor blackColor];
				[v addSubview:a];
			}
			
			{
				UIView *a = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 5, 5)];
				a.backgroundColor = [UIColor blackColor];
				[v addSubview:a];
			}
			
			
		}
		
		
		_myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		_myButton.frame = CGRectMake(10, 50, 300, 50);
		[_myButton setTitle:@"" forState:UIControlStateNormal];
		[_myButton addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_myButton];
		
		[self moveToRandomSquare];
		
	}
	
	return self;
	
}


- (void) missed:(id)sender {
	_missedCount++;
	_helloLabel.text = [NSString stringWithFormat:@"KDR: %f", _counter / (float)_missedCount];
}

- (int) moveToRandomSquare {
	int sq = rand() % [_dancingSquares count];
	UIView *squ = [_dancingSquares objectAtIndex:sq];
	_myButton.frame = squ.frame;
	
	return sq;
}

- (CGRect) randomFrame {
	return CGRectMake(10  + rand()%200,
					  100 + rand()%250,
					  50  + rand()%50,
					  50  + rand()%50);
}

- (UIColor*) randomColor {
	return [UIColor colorWithRed:rand()%255/255.0
						   green:rand()%255/255.0
							blue:rand()%255/255.0
						   alpha:rand()%128/255.0 + 0.5];
	
}


- (void) pressedButton:(id)sender {
	_counter++;
	_helloLabel.text = [NSString stringWithFormat:@"KDR: %f", _counter / (float)_missedCount];
	
	
	for (UIView *v in _dancingSquares) {
		
		[UIView animateWithDuration:0.25
							  delay:rand()%100/200.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 v.backgroundColor = [self randomColor];
							 v.frame = [self randomFrame];
						 } completion:nil];
		
	}
	
	//float scale = 1.0 - (_counter * 0.005);
	//_myButton.transform = CGAffineTransformMakeScale(scale, scale);
	
	
	//if (_counter % 5 == 0) {
	//	[[[UIAlertView alloc] initWithTitle:@"You win" message:@"YAY" delegate:nil cancelButtonTitle:@"fantastic" otherButtonTitles:nil] show];
	//}
	
	[UIView animateWithDuration:0.25
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						[self moveToRandomSquare];
						 
					 } completion:nil];
	
	
	
}



@end
