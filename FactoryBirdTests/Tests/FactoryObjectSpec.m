#import "FactoryBirdTests.h"
#import "FBUser.h"

SpecBegin(FactoryObject)

describe(@"FactoryObject", ^{
    
    context(@"Building single object", ^{
        __block FBUser *user;
        beforeEach(^{
            user = [FBUser build];
        });
        
        it(@"Returns a User object", ^{
            expect(user).to.beInstanceOf([FBUser class]);
        });
        // TODO user item has default build properties.
    });
    
    context(@"Building array of objects", ^{
        __block NSArray *users;
        beforeEach(^{
            users = [FBUser buildTimes:5];
        });
        
        it(@"Returns a array of User objects", ^{
            NSIndexSet *userObjects = [users indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [obj isKindOfClass:[FBUser class]];
            }];
            expect(userObjects).to.haveCountOf(users.count);
        });
        // TODO each project has default build properties
    });
    
    context(@"Building array overriding attributes", ^{
        __block NSArray *users;
        beforeEach(^{
            users = [FBUser buildTimes:5 using:^NSDictionary *(NSUInteger idx) {
                if (idx == 2) {
                    return @{ @"fullName" : @"Pepa Pig"};
                }
                return nil;
            }];
        });
        
        it(@"Returns a user item with name 'Pepa Pig' at index 2", ^{
            FBUser *item = users[2];
            expect(item.fullName).to.equal(@"Pepa Pig");
        });
    });
    
});

SpecEnd