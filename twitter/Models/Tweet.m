//
//  Tweet.m
//  twitter
//
//  Created by Abena Ofosu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet


+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *tweetDictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

- (instancetype)initWithDictionary:(NSDictionary *)tweetDictionary {
    self = [super init];

    if (self) {
        // case for a re-tweet
        NSDictionary *originalTweet = tweetDictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = tweetDictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            tweetDictionary = originalTweet;
        }
        self.idStr = tweetDictionary[@"id_str"];
        if([tweetDictionary valueForKey:@"full_text"] != nil) {
               self.text = tweetDictionary[@"full_text"]; // uses full text if Twitter API provided it
           } else {
               self.text = tweetDictionary[@"text"]; // fallback to regular text that Twitter API provided
           }        
        
        self.favoriteCount = [tweetDictionary[@"favorite_count"] intValue];
        self.favorited = [tweetDictionary[@"favorited"] boolValue];
        self.retweetCount = [tweetDictionary[@"retweet_count"] intValue];
        self.retweeted = [tweetDictionary[@"retweeted"] boolValue];

        // initialize user
        NSDictionary *user = tweetDictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        // Format createdAt date string
        NSString *createdAtOriginalString = tweetDictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        NSLog(@"%@", tweetDictionary);
    }
    return self;
}

@end
