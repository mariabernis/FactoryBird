//
//  FactoryBirdObject.h
//  
//
//  Created by Maria Bernis on 09/03/15.
//
//

#import <Foundation/Foundation.h>

@protocol FactoryBirdObject <NSObject>
@required
+ (NSDictionary *)factoryAttributes;
@end
