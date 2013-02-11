//
//  LBNTweetView.h
//  Nerv
//
//  Created by Jonathan Long on 2/7/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBNTweetView : UIView
@property (strong, nonatomic) IBOutlet UILabel* authorName;
@property (strong, nonatomic) IBOutlet UILabel* username;
@property (strong, nonatomic) IBOutlet UILabel* tweetText;
@property (strong, nonatomic) IBOutlet UILabel* timestamp;
@property (strong, nonatomic) IBOutlet UIImageView* avatarImageView;
- (id) initWithFrame:(CGRect)frame authorName:(NSString*)author username:(NSString*)username tweetText:(NSString*)tweetText timestamp:(NSDate*)timestamp avatarImageURL:(NSURL*)avatarImageURL;

@end
