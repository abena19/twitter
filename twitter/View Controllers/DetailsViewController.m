//
//  DetailsViewController.m
//  twitter
//
//  Created by Abena Ofosu on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tweetProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserName;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserScreenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *replyIcon;
@property (weak, nonatomic) IBOutlet UIButton *retweetIcon;
@property (weak, nonatomic) IBOutlet UILabel *tweetRetweetedCount;
@property (weak, nonatomic) IBOutlet UIButton *favIcon;
@property (weak, nonatomic) IBOutlet UILabel *tweetFavCount;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *URLString = self.tweet.user.userProfilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.tweetProfilePicture.image = [UIImage imageWithData:urlData];
    self.tweetUserName.text = self.tweet.user.userName;
    self.tweetUserScreenName.text = self.tweet.user.userScreenName;
    self.tweetText.text = self.tweet.text;
    self.tweetRetweetedCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.tweetFavCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.tweetCreatedAt.text = self.tweet.createdAtString;
}

- (IBAction)didTapFavoriteButton:(id)sender {
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
