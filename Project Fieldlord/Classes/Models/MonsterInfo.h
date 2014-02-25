//
//  MonsterInfo.h
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/25/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonsterView.h"

@interface MonsterInfo : NSObject

@property (nonatomic, assign) BOOL active;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) UIColor *color;

@property (nonatomic, readonly) CGSize defaultSize;
@property (nonatomic, readonly) MonsterView *view;

+ (MonsterInfo*) monsterAtIndex:(int)index;
+ (int) indexForRandomMonsterWithActiveState:(BOOL)active;
+ (int) maxMonsterCount;

- (id) initWithName:(NSString*)name description:(NSString*)description color:(UIColor*)color;

- (CGPoint) randomValidCenterInSize:(CGSize)size;

@end
