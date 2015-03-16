#import "NSObject+FactoryBird.h"
#import <objc/runtime.h>

@implementation NSObject (FactoryBird)

+ (instancetype)build
{
    return [self buildUsing:nil];
}

+ (instancetype)buildUsing:(NSDictionary *)attributes
{
    id factoryObj = [[self alloc] init];
    NSMutableDictionary *mergedAttrs = [NSMutableDictionary dictionaryWithDictionary:[self factoryAttributes]];
    if (attributes.count) [mergedAttrs addEntriesFromDictionary:attributes];
    NSArray *propertyList = [self propertyList];
    for (NSString *propertyName in propertyList) {
        if (mergedAttrs[propertyName]) {
            [factoryObj setValue:mergedAttrs[propertyName] forKey:propertyName];
        }
    }
    return factoryObj;
}

+ (NSArray *)propertyList {
    Class currentClass = [self class];
    
    NSMutableArray *propertyList = [NSMutableArray array];
    // class_copyPropertyList does not include properties declared in super classes
    // so we have to follow them until we reach NSObject
    do {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
        
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            
            NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
            
            [propertyList addObject:propertyName];
        }
        free(properties);
        currentClass = [currentClass superclass];
    } while ([currentClass superclass]);
    
    return propertyList;
}

+ (NSArray *)buildTimes:(NSUInteger)times
{
    return [self buildTimes:times using:nil];
}

+ (NSArray *)buildTimes:(NSUInteger)times using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex
{
    NSMutableArray *factories = [NSMutableArray array];
    for (NSUInteger i = 0; i < times; i++) {
        id newObject = [self buildUsing:attributesForIndex ? attributesForIndex(i) : nil];
        [factories addObject:newObject];
    }
    return [factories copy];
}


#pragma mark - FactoryObject methods

+ (NSDictionary *)factoryAttributes
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"%@ must implement FactoryObject protocol and %@ method", NSStringFromClass(self), NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
