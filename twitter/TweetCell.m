//
//  TweetCell.m
//  twitter
//
//  Created by Abena Ofosu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited == YES) {  // case for already favorited -> unfavorite
        [self.favIcon setImage:[UIImage imageNamed:@"favor-icon"]
          forState:UIControlStateNormal];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             } else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
    } else {  // favorite not already favorited
        [self.favIcon setImage:[UIImage imageNamed:@"favor-icon-red"]
          forState:UIControlStateNormal];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    self.tweetFavCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];  //updating UI
}


- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {  // case for already retweeted -> unretweet
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet-icon"]
          forState:UIControlStateNormal];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
    } else {  // retweet not already tweeted
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet-icon-green"]
          forState:UIControlStateNormal];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    self.tweetRetweetedCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];

}
@end
