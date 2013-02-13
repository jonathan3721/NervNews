//
//  LBNTweetView.m
//  Nerv
//
//  Created by Jonathan Long on 2/7/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNTweetView.h"


#define DISTANCE_FROM_LEFT_EDGE 10.0f
#define DISTANCE_FROM_TOP_EDGE 10.0f
#define AVATAR_WIDTH 50.0f
#define AVATAR_HEIGHT 50.0f

@implementation LBNTweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializePropertiesWithFrame:frame];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame authorName:(NSString*)author username:(NSString*)username tweetText:(NSString*)tweetText timestamp:(NSDate*)timestamp avatarImageURL:(NSURL*)avatarImageURL
{
    self = [self initWithFrame:frame];
    if (self) {
        self.authorName.text = author;
        self.username.text = username;
        self.tweetText.text = tweetText;
        [self.avatarImageView setImageWithURL:avatarImageURL];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        self.timestamp.text = [dateFormatter stringFromDate:timestamp];
    }
    return self;
}

- (void)initializePropertiesWithFrame:(CGRect)frame
{
    self.authorName = [[UILabel alloc] init];
    self.username = [[UILabel alloc] init];
    self.tweetText = [[UILabel alloc] init];
    self.timestamp = [[UILabel alloc] init];
    self.avatarImageView = [[UIImageView alloc] init];
    CGFloat frameX = frame.origin.x;
    CGFloat frameY = frame.origin.y;
    CGFloat frameWidth = frame.size.width;
    CGFloat frameHeight = frame.size.height;
    self.avatarImageView.frame = CGRectMake(frameX + DISTANCE_FROM_LEFT_EDGE, frameY + DISTANCE_FROM_TOP_EDGE, AVATAR_WIDTH, AVATAR_HEIGHT);
    self.authorName.frame = CGRectMake(self.avatarImageView.frame.size.width + DISTANCE_FROM_LEFT_EDGE, self.avatarImageView.frame.origin.y, 100.0f, self.avatarImageView.frame.size.height/2.0f);
    self.username.frame = CGRectMake(self.avatarImageView.frame.size.width + DISTANCE_FROM_LEFT_EDGE, self.avatarImageView.frame.origin.y + self.authorName.frame.size.height, 100.0f, self.avatarImageView.frame.size.height/2.0f);
    self.tweetText.frame = CGRectMake(frameX + DISTANCE_FROM_LEFT_EDGE, CGRectGetMaxY(self.username.frame) + 10.0f, frameWidth - 2*DISTANCE_FROM_LEFT_EDGE, 100.0f);
    self.timestamp.frame = CGRectMake(DISTANCE_FROM_LEFT_EDGE, frameHeight - 50.0f, 100.0f, 50.0f);
    [self addSubview:_authorName];
    [self addSubview:_username];
    [self addSubview:_tweetText];
    [self addSubview:_timestamp];
    [self addSubview:_avatarImageView];
}



@end
