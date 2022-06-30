//
//  PostCell.h
//  Parse Gram
//
//  Created by Onwuosiuno Ikhioda on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picturePosted;
@property (weak, nonatomic) IBOutlet UILabel *pictureCaption;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
