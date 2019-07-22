//
//  HomeCollectionViewCell.h
//  TaskU
//
//  Created by rhaypapenfuzz on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeViewImage;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImages;
@end

@protocol HomeCollectionCellDelegate
@required
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)didTapCategory:(NSString *) category;
@end
NS_ASSUME_NONNULL_END
