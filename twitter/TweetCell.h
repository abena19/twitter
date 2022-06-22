//
//  TweetCell.h
//  twitter
//
//  Created by Abena Ofosu on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetUserScreenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetCreatedAt;
@property (weak, nonatomic) IBOutlet UIImageView *tweetProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *tweetUserName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *replyIcon;
@property (weak, nonatomic) IBOutlet UIButton *favIcon;
@property (weak, nonatomic) IBOutlet UIButton *retweetIcon;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;
@property (weak, nonatomic) IBOutlet UILabel *tweetRetweetedCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetFavCount;
@property (nonatomic, strong) NSDictionary *tweet;


@end

NS_ASSUME_NONNULL_END
