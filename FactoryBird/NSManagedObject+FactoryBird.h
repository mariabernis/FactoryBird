//
//  NSManagedObject+FactoryBird.h
//  Redbooth
//
//  Created by Maria Bernis on 25/02/15.
//  Copyright (c) 2015 teambox. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSObject+FactoryBird.h"

@interface NSManagedObject (FactoryBird)
+ (instancetype)buildWithContext:(NSManagedObjectContext *)context;
+ (instancetype)buildWithContext:(NSManagedObjectContext *)context using:(NSDictionary *)attributes;
+ (NSArray *)buildTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context;
+ (NSArray *)buildTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex;

+ (instancetype)createWithContext:(NSManagedObjectContext *)context;
+ (instancetype)createWithContext:(NSManagedObjectContext *)context using:(NSDictionary *)attributes;
+ (NSArray *)createTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context;
+ (NSArray *)createTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex;
@end
