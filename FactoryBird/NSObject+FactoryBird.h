#import <Foundation/Foundation.h>

@interface NSObject (FactoryBird) <NSObject>
+ (instancetype)build;
+ (instancetype)buildUsing:(NSDictionary *)attributes;
+ (NSArray *)buildTimes:(NSUInteger)times;
+ (NSArray *)buildTimes:(NSUInteger)times using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex;
@end
