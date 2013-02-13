//
//  LBNLabelCollectionViewCell.h
//  Nerv
//
//  Created by Jonathan Long on 1/26/13.
//  Copyright (c) 2013 Jonathan Long. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
 LBNCollectionViewCellPositionTop,
 LBNCollectionViewCellPositionMiddle,
 LBNCollectionViewCellPositionBottom
}LBNCollectionViewCellPosition;

@interface LBNLabelCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (nonatomic) LBNCollectionViewCellPosition position;

@end
