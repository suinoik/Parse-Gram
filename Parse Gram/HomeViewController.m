//
//  HomeViewController.m
//  Parse Gram
//
//  Created by Onwuosiuno Ikhioda on 6/28/22.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "ViewController.h"
#import "PostViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "DateTools.h"
#import "DetailsViewController.h"

@interface HomeViewController ()<PostViewControllerDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController
- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
            mySceneDelegate.window.rootViewController = loginViewController;    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(didPost) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self didPost];
    [self.tableView reloadData];

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfPosts = (NSMutableArray *)posts;
            [self.tableView reloadData];
            
        }
        else {
            // handle error
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
     [self.tableView reloadData];

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier] isEqualToString:@"composeSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        PostViewController *postController = (PostViewController*)navigationController.topViewController;
        postController.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailsViewController *detailsViewController = [segue destinationViewController];
        PostCell *cell = sender;
        detailsViewController.post = cell.post;
        
        
        
        
    }
}

- (void) didPost {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    self.tableView.dataSource = self;

    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfPosts = (NSMutableArray *)posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];

        }
        else {
            // handle error
        }
    }];
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.post = post;
    PFFileObject *photoImageFile = post.image;
    [photoImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (data) {
                cell.picturePosted.image = [UIImage imageWithData:data];
            }
    }];
    cell.pictureCaption.text = post.caption;
    cell.userName.text = post.author.username;
    NSLog(@"%@", post.createdAt);
    
    
    cell.dateLabel.text = [post.createdAt shortTimeAgoSinceNow];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

@end
