#import <Foundation/Foundation.h>

@protocol FactoryBirdObject <NSObject>
@required
+ (NSDictionary *)factoryAttributes;
@end
