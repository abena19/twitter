//
//  User.m
//  twitter
//
//  Created by Abena Ofosu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.userName = dictionary[@"name"];
        self.userScreenName = dictionary[@"screen_name"];
        self.userProfilePicture = dictionary[@"profile_image_url_https"];
        self.userProfileBanner = dictionary[@"profile_banner_url"];
        self.userFollowers = dictionary[@"followers_count"];
        self.userAccountCreatetime = dictionary[@"created_at"];
    }
    return self;
}

@end
