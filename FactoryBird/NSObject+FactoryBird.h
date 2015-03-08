//
//  NSObject+FactoryBird.h
//  Redbooth
//
//  Created by Maria Bernis on 20/02/15.
//  Copyright (c) 2015 teambox. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FactoryBirdObject <NSObject>
@required
+ (NSDictionary *)factoryAttributes;
@end

@interface NSObject (FactoryBird) <NSObject>
+ (instancetype)build;
+ (instancetype)buildUsing:(NSDictionary *)attributes;
+ (NSArray *)buildTimes:(NSUInteger)times;
+ (NSArray *)buildTimes:(NSUInteger)times using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex;
@end
