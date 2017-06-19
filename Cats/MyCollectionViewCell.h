//
//  MyCollectionViewCell.h
//  Cats
//
//  Created by Harry Li on 2017-06-19.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
