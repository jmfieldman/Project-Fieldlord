//
//  MonsterInfo.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/25/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "MonsterInfo.h"

static __strong NSMutableArray *s_monsterArray = nil;


@implementation MonsterInfo

+ (MonsterInfo*) monsterAtIndex:(int)index {
	if (!s_monsterArray) {
		s_monsterArray = [NSMutableArray array];
		
		[s_monsterArray addObject:[[MonsterInfo alloc] initWithName:@"Foob" description:@"Boof" color:[UIColor redColor]]];
		[s_monsterArray addObject:[[MonsterInfo alloc] initWithName:@"Foob" description:@"Boof" color:[UIColor blueColor]]];
		[s_monsterArray addObject:[[MonsterInfo alloc] initWithName:@"Foob" description:@"Boof" color:[UIColor greenColor]]];
	}
	
	if (index >= [s_monsterArray count]) return nil;
	
	return s_monsterArray[index];
}

+ (int) maxMonsterCount {
	return [s_monsterArray count];
}

- (id) initWithName:(NSString*)name description:(NSString*)description color:(UIColor*)color {
	if ((self = [super init])) {
		_name = name;
		_description = description;
		_color = color;
		
		_defaultSize = CGSizeMake(50, 70);
		
		_view = [[MonsterView alloc] initWithFrame:CGRectMake(-1000, -1000, _defaultSize.width, _defaultSize.height)];
		_view.bodyView.backgroundColor = color;
	}
	return self;
}


@end
