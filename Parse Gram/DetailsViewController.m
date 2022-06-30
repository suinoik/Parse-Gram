//
//  DetailsViewController.m
//  Parse Gram
//
//  Created by Onwuosiuno Ikhioda on 6/30/22.
//

#import "DetailsViewController.h"
#import "PostCell.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "HomeViewController.h"
#import "DateTools.h"


@interface DetailsViewController ()
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictureCaption.text = self.post.caption;
    PFFileObject *photoImageFile = self.post.image;
    [photoImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (data) {
                self.picturePosted.image = [UIImage imageWithData:data];
            }
    }];
    self.dateLabel.text = [self.post.createdAt shortTimeAgoSinceNow];
    self.userName.text = self.post.author.username;
}



@end
