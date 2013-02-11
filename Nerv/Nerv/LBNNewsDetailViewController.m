//
//  LBNNewsDetailViewController.m
//  Nerv
//
//  Created by Jonathan Long on 2/5/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNNewsDetailViewController.h"

@interface LBNNewsDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UIView * backgroundView;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* tweet;
@end

@implementation LBNNewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLabels];
    self.view.backgroundColor = BACKGROUND_PATTERN;
}

- (void)setupLabels{
    self.usernameLabel.text = _username;
    self.tweetLabel.text = _tweet;
}

- (void) setUsername:(NSString*)username tweet:(NSString*)tweet{
    self.username = username;
    self.tweet = tweet;
    
}

@end
