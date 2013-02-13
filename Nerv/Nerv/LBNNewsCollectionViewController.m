//
//  LBNNewsCollectionViewController.m
//  Nerv
//
//  Created by Jonathan Long on 1/26/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import "LBNNewsCollectionViewController.h"
#import "LBNLargeImageCollectionViewCell.h"
#import "LBNLabelCollectionViewCell.h"
#import "LBNTwitterClient.h"
#import "LBNNewsDetailViewController.h"

//segue
static NSString* const NewsToDetailSegue = @"NewsToDetailSegue";
//constants
static NSString* const NORMAL_TWITTER_CELL_REUSE_IDENTIFIER = @"NormalTweetCell";
static NSString* const IMAGE_TWITTER_CELL_REUSE_IDENTIFIER = @"TweetWithImageCell";
static NSString* const ENTITIES_KEY = @"entities";
static NSString* const HASHTAGS_KEY = @"hashtags";
static NSString* const URLS_KEY = @"urls";
static NSString* const MEDIA_KEY = @"media";
static NSString* const IMAGE_URL_KEY = @"media_url_https";
static NSString* const TWEET_TEXT_STRING_KEY = @"text";
static NSString* const TWEETER_USERNAME_KEY = @"from_user_name";

@interface LBNNewsCollectionViewController ()
@property (strong, nonatomic) NSArray* twitterResults;
@property (strong, nonatomic) NSDictionary* selectedTweet;

- (void)removeActivityIndicator:(UIActivityIndicatorView*)activityView;
- (NSDictionary*)tweetAtIndex:(NSUInteger)index;
- (NSDictionary*)mediaDictionaryFromTweet:(NSDictionary*)tweet;
- (NSDictionary*)URLDictionaryFromTweet:(NSDictionary*)tweet;
- (NSDictionary*)tweetSocialEntitiesFromTweetDictionary:(NSDictionary*)tweet;
- (NSDictionary*)hashtagDictionaryFromTweet:(NSDictionary*)tweet;
- (NSDictionary*)dictionaryFromDictionary:(NSDictionary*)dictionary forStringKey:(NSString*)key;
- (NSArray*)arrayFromDictionary:(NSDictionary*)dictionary forStringKey:(NSString*)key;
- (NSDictionary*)dictionaryFromArray:(NSArray*)array;
- (NSDictionary*)dictionaryForObject:(id)object;
- (LBNLargeImageCollectionViewCell*)largeImageCollectionViewCellForCollectionView:(UICollectionView*)collectionView
                                                                     andIndexPath:(NSIndexPath*)indexPath
                                                                        WithTweet:(NSDictionary*)tweetDictionary
                                                                         andMedia:(NSDictionary*)mediaDictionary;
- (LBNLabelCollectionViewCell*)labelCollectionViewCellFromCollectionView:(UICollectionView*)collectionView
                                                           WithIndexPath:(NSIndexPath*)indexPath
                                                     WithTweetDictionary:(NSDictionary*)tweetDictionary;
@end

@implementation LBNNewsCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = BACKGROUND_PATTERN;
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [LBNTwitterClient twitterSearchWithQuery:@"austin" andCompletion:^(NSArray *tweets) {
        self.twitterResults = tweets;
        [self.collectionView reloadData];
        [self removeActivityIndicator:activityIndicator];
        NSLog(@"DONE");
    } andFailure:^(NSError *error) {
        NSLog(@"%@", error);
        [self removeActivityIndicator:activityIndicator];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

- (void)removeActivityIndicator:(UIActivityIndicatorView*)activityView{
    [activityView stopAnimating];
    [activityView removeFromSuperview];
}

#pragma mark - CollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.twitterResults.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    }
    NSDictionary* tweet = [self tweetAtIndex:indexPath.row];
    NSDictionary* mediaDictionary = [self mediaDictionaryFromTweet:tweet];
    NSDictionary* URLDictionary = [self URLDictionaryFromTweet:tweet];
    
    //We need to handle the case where we get a URL and no media, but that url is an instagrma url
    // I think to do this we will need to integrate the Instagram URL and anytime we get a URL we should make
    // a request to the Instagram URL (They have a image for url capability) if we get something back we assume
    // that it is an instagram image, if not then it's a normal URL
    // if we do get an instagram image, maybe we can cache it?
    
    if ([mediaDictionary count] > 0) {
        LBNLargeImageCollectionViewCell* collectionViewCell = [self largeImageCollectionViewCellForCollectionView:collectionView andIndexPath:indexPath WithTweet:tweet andMedia:mediaDictionary];
        if ([URLDictionary count] > 0) {
            //Call method to get URLS for this cell
        }
        return collectionViewCell;
    }
    else{
        LBNLabelCollectionViewCell* collectionViewCell = [self labelCollectionViewCellFromCollectionView:collectionView WithIndexPath:indexPath WithTweetDictionary:tweet];
        if ([URLDictionary count] > 0) {
            //Call method to get URLS for this cell
        }
        return collectionViewCell;
        
    }
    
    if (indexPath.row == self.twitterResults.count) {
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    }
    
}

- (NSDictionary*)tweetAtIndex:(NSUInteger)index{
    id tweetObject = self.twitterResults[index];
    return [self dictionaryForObject:tweetObject];
}

- (NSDictionary*)mediaDictionaryFromTweet:(NSDictionary*)tweet{
    NSDictionary* tweetSocialEntities = [self tweetSocialEntitiesFromTweetDictionary:tweet];
    NSArray* mediaArray = [self arrayFromDictionary:tweetSocialEntities forStringKey:MEDIA_KEY];
    return [self dictionaryFromArray:mediaArray];
    
}

- (NSDictionary*)URLDictionaryFromTweet:(NSDictionary*)tweet{
    NSDictionary* tweetSocialEntities = [self tweetSocialEntitiesFromTweetDictionary:tweet];
    NSArray* URLs = [self arrayFromDictionary:tweetSocialEntities forStringKey:URLS_KEY];
    return [self dictionaryFromArray:URLs];
    
}


- (NSDictionary*)tweetSocialEntitiesFromTweetDictionary:(NSDictionary*)tweet{
    return [self dictionaryFromDictionary:tweet forStringKey:ENTITIES_KEY];
    
}

- (NSDictionary*)hashtagDictionaryFromTweet:(NSDictionary*)tweet{
    NSDictionary* tweetSocialEntities = [self tweetSocialEntitiesFromTweetDictionary:tweet];
    NSArray* hashtagArray = [self arrayFromDictionary:tweetSocialEntities forStringKey:HASHTAGS_KEY];
    return [self dictionaryFromArray:hashtagArray];
    
}

- (NSDictionary*)dictionaryFromDictionary:(NSDictionary*)dictionary forStringKey:(NSString*)key{
    id anotherDictionary = dictionary[key];
    return [self dictionaryForObject:anotherDictionary];
    
}

- (NSArray*)arrayFromDictionary:(NSDictionary*)dictionary forStringKey:(NSString*)key{
    id anArray = dictionary[key];
    return [self arrayForObject:anArray];
}

- (NSDictionary*)dictionaryFromArray:(NSArray*)array{
    if (array && array.count > 0) {
        id object = array[0];
        return [self dictionaryForObject:object];
    }
    else{
        return nil;
    }
}

- (NSDictionary*)dictionaryForObject:(id)object{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary*)object;
    }
    else{
        NSAssert(@"This object is not of type NSDictionary, %@", object);
        return nil;
    }
}

- (NSArray*)arrayForObject:(id)object{
    if ([object isKindOfClass:[NSArray class]]) {
        return (NSArray*)object;
    }
    else{
        NSAssert(@"This object is not of type NSArray, %@", object);
        return nil;
    }
}

- (LBNLargeImageCollectionViewCell*)largeImageCollectionViewCellForCollectionView:(UICollectionView*)collectionView
                                                                     andIndexPath:(NSIndexPath*)indexPath
                                                                        WithTweet:(NSDictionary*)tweetDictionary
                                                                         andMedia:(NSDictionary*)mediaDictionary{
    LBNLargeImageCollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:IMAGE_TWITTER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    [self positionFor:collectionViewCell atIndex:indexPath];
    
    if (mediaDictionary != nil && tweetDictionary != nil) {
        NSString* mediaURLString = mediaDictionary[IMAGE_URL_KEY];
        NSURL* mediaURL = [NSURL URLWithString:mediaURLString];
        NSString* tweetText = tweetDictionary[TWEET_TEXT_STRING_KEY];
        [collectionViewCell.tweetImageView setImageWithURL:mediaURL];
        collectionViewCell.tweetLabel.text = tweetText;
        collectionViewCell.usernameLabel.text = tweetDictionary[TWEETER_USERNAME_KEY];
    }
    
    return collectionViewCell;
    
}

- (LBNLabelCollectionViewCell*)labelCollectionViewCellFromCollectionView:(UICollectionView*)collectionView
                                                           WithIndexPath:(NSIndexPath*)indexPath
                                                     WithTweetDictionary:(NSDictionary*)tweetDictionary{
    LBNLabelCollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:NORMAL_TWITTER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    [self positionFor:collectionViewCell atIndex:indexPath];
    if (tweetDictionary != nil) {
        collectionViewCell.tweetLabel.text = tweetDictionary[@"text"];
        collectionViewCell.usernameLabel.text = tweetDictionary[@"from_user_name"];
    }
    
    return collectionViewCell;
    
}

- (void)positionFor:(LBNLabelCollectionViewCell*)collectionViewCell atIndex:(NSIndexPath*)indexPath{
    if (indexPath.row == 0) {
        collectionViewCell.position = LBNCollectionViewCellPositionTop;
    }
    else if(indexPath.row == self.twitterResults.count - 1){
        collectionViewCell.position = LBNCollectionViewCellPositionBottom;
        
    }
    else{
        collectionViewCell.position = LBNCollectionViewCellPositionMiddle;
    }
    
    [collectionViewCell setNeedsDisplay];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* tweet = [self tweetAtIndex:indexPath.row];
    NSDictionary* mediaDictionary = [self mediaDictionaryFromTweet:tweet];
    if ([mediaDictionary count] > 0) {
        return CGSizeMake(300.0f, 413.0f);
    }
    
    return CGSizeMake(300.0f, 130.0f);
}

#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedTweet =[self tweetAtIndex:indexPath.row];
    [self performSegueWithIdentifier:NewsToDetailSegue sender:nil];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        if ([segue.identifier isEqualToString:NewsToDetailSegue]) {
            NSString* text = self.selectedTweet[TWEET_TEXT_STRING_KEY];
            NSString* username = self.selectedTweet[TWEETER_USERNAME_KEY];
            LBNNewsDetailViewController* detailViewController = (LBNNewsDetailViewController*)segue.destinationViewController;
            [detailViewController setUsername:username tweet:text];
    }
}


@end
