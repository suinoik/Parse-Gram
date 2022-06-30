//
//  PostViewController.h
//  Parse Gram
//
//  Created by Onwuosiuno Ikhioda on 6/29/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PostViewControllerDelegate

- (void)didPost;

@end


@interface PostViewController : UIViewController

@property (nonatomic, weak) id<PostViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
