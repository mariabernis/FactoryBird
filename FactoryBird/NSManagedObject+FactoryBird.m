#import "NSManagedObject+FactoryBird.h"

@implementation NSManagedObject (FactoryBird)


#pragma mark - Build

+ (instancetype)buildUsing:(NSDictionary *)attributes
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You cannot use %@ with a managed object, use buildWithContext or createWithContext instead", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

+ (instancetype)buildWithContext:(NSManagedObjectContext *)context
{
    return [self buildWithContext:context using:nil];
}

+ (instancetype)buildWithContext:(NSManagedObjectContext *)context using:(NSDictionary *)attributes
{
    NSEntityDescription *entity = [self entityDescriptionForCurrentClassInContext:context];
    NSManagedObject *factoryObj = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    NSMutableDictionary *mergedAttrs = [NSMutableDictionary dictionaryWithDictionary:[self factoryAttributes]];
    if (attributes.count) [mergedAttrs addEntriesFromDictionary:attributes];
    // All properties including superclasses (attributes and relationships)
    NSDictionary *propertiesNames = factoryObj.entity.propertiesByName;
    for (NSString *propertyName in [propertiesNames allKeys]) {
        if (mergedAttrs[propertyName]) {
            [factoryObj setValue:mergedAttrs[propertyName] forKey:propertyName];
        }
    }
    return factoryObj;
}

+ (NSArray *)buildTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context
{
    return [self buildTimes:times withContext:context using:nil];
}

+ (NSArray *)buildTimes:(NSUInteger)times
            withContext:(NSManagedObjectContext *)context
                  using:(NSDictionary *(^)(NSUInteger))attributesForIndex
{
    NSMutableArray *factories = [NSMutableArray array];
    for (NSUInteger i = 0; i < times; i++) {
        id newObject = [self buildWithContext:context using:attributesForIndex ? attributesForIndex(i) : nil];
        [factories addObject:newObject];
    }
    return [factories copy];
}


#pragma mark Helpers

+ (NSEntityDescription *)entityDescriptionForCurrentClassInContext:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity;
    Class currentClass = [self class];
    do {
        entity = [NSEntityDescription entityForName:NSStringFromClass(currentClass) inManagedObjectContext:context];
        currentClass = [currentClass superclass];
    } while (!entity);
    return entity;
}


#pragma mark - Create

+ (instancetype)createWithContext:(NSManagedObjectContext *)context
{
    return [self createWithContext:context using:nil];
}

+ (instancetype)createWithContext:(NSManagedObjectContext *)context using:(NSDictionary *)attributes
{
    id factoryObj = [self buildWithContext:context using:attributes];
    [context save:nil];
    return factoryObj;
}

+ (NSArray *)createTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context
{
    return [self createTimes:times withContext:context using:nil];
}

+ (NSArray *)createTimes:(NSUInteger)times withContext:(NSManagedObjectContext *)context using:(NSDictionary *(^)(NSUInteger idx))attributesForIndex
{
    NSArray *factories = [self buildTimes:times withContext:context using:attributesForIndex];
    [context save:nil];
    return factories;
}


#pragma mark - FactoryObject methods

+ (NSDictionary *)factoryAttributes
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"%@ must implement FactoryObject protocol and %@ method", NSStringFromClass(self), NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
