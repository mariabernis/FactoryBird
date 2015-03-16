#import "FBUser.h"

@implementation FBUser

+ (NSDictionary *)factoryAttributes
{
    return @{ @"fullName" : @"Mrs Jane Doe",
              @"email"    : @"janedoe@email.com",
              @"address"  : @"15th, Sesam Street",
              @"country"  : @"Neverland",
              @"premium"  : @NO };
}

@end
