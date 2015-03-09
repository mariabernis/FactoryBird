//
//  FBUser.h
//  Redbooth
//
//  Created by Maria Bernis on 25/02/15.
//  Copyright (c) 2015 teambox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FactoryBird.h"

@interface FBUser : NSObject <FactoryBirdObject>
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign, getter=isPremium) BOOL premium;
@end
