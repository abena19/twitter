//
//  User.h
//  twitter
//
//  Created by Abena Ofosu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userScreenName;
@property (nonatomic, strong) NSString *userProfilePicture;
@property (nonatomic, strong) NSString *userAccountCreatetime;
@property (nonatomic, strong) NSString *userProfileBanner;
@property (nonatomic, strong) NSString *userFollowers;

// Create initializer to set tweet properties based on dictionary
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
