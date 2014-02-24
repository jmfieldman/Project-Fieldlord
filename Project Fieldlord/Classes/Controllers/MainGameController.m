//
//  MainGameController.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MainGameController.h"

@interface MainGameController ()

@end

@implementation MainGameController

- (id) init {
	if ((self = [super init])) {
		
		self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		self.view.backgroundColor = [UIColor whiteColor];
		
		
		MonsterView *foo = [[MonsterView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
		[self.view addSubview:foo];
	}
	return self;
}


@end
