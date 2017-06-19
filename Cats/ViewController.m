//
//  ViewController.m
//  Cats
//
//  Created by Harry Li on 2017-06-19.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "Photo.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *catPhotoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=525ee4cddb2e8d117d3e680cde6cb0ae&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *photoDictionary = jsonDictionary[@"photos"];
        NSArray *catArray = photoDictionary[@"photo"];
        
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        self.catPhotoArray = [NSMutableArray array];
        
        for (NSDictionary *cat in catArray) {
            
            Photo *catPhoto = [[Photo alloc] initWithDictionary:cat];
            [self.catPhotoArray addObject:catPhoto];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
    
    [dataTask resume];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.catPhotoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    if (![self.catPhotoArray[indexPath.item] catImage]) {
        [self.catPhotoArray[indexPath.item] catPhotoWithCompletion:^(UIImage *image) {
            MyCollectionViewCell * cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                cell.catImageView.image = [self.catPhotoArray[indexPath.item] catImage];
            }];
        }];
    } else {
    
        cell.catImageView.image = [self.catPhotoArray[indexPath.item] catImage];
    }
    cell.titleLabel.text = [self.catPhotoArray[indexPath.item] title];
    
    return cell;
}

@end
