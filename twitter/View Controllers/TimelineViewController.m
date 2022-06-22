//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource>
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timelineTableView.dataSource = self;
    
    // initialising refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:refreshControl atIndex:0];
    self.timelineTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = [NSMutableArray arrayWithArray:(NSArray*)tweets];
            [self.timelineTableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = [NSMutableArray arrayWithArray:(NSArray*)tweets];
            [self.timelineTableView reloadData];
            [refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

// cell Foreach tweet
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCellReuseId"];
    //  this is of a dictionary type
    Tweet *tweets = self.arrayOfTweets[indexPath.row];
    
    NSString *URLString = tweets.user.userProfilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.tweetProfilePicture.image = [UIImage imageWithData:urlData];
    cell.tweetUserName.text = tweets.user.userName;
    cell.tweetText.text = tweets.text;
    cell.tweetUserScreenName.text = tweets.user.userScreenName;
    cell.tweetCreatedAt.text = tweets.createdAtString;
    cell.tweetRetweetedCount.text = [NSString stringWithFormat:@"%i", tweets.retweetCount];
    cell.tweetFavCount.text = [NSString stringWithFormat:@"%i", tweets.favoriteCount];
    
    NSLog(@"%@", self.arrayOfTweets);
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)didTapLogout:(id)sender {
    // access app delegate
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    // switch content to LoginViewController
    appDelegate.window.rootViewController = loginViewController;
    //  clear access tokens
    [[APIManager shared] logout];
}
@end
