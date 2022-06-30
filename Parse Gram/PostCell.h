//
//  PostCell.h
//  Parse Gram
//
//  Created by Onwuosiuno Ikhioda on 6/29/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picturePosted;
@property (weak, nonatomic) IBOutlet UILabel *pictureCaption;

@end

NS_ASSUME_NONNULL_END
