//
//  Photo.m
//  Cats
//
//  Created by Harry Li on 2017-06-19.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        _title = dict[@"title"];
        _photoURL = [self buildURL:dict];
    }
    return self;
}

//prototypeURL: https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
- (NSURL *)buildURL:(NSDictionary *) dict{
    NSString *farm = dict[@"farm"];
    NSString *server = dict[@"server"];
    NSString *photoId = dict[@"id"];
    NSString *secret = dict[@"secret"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, photoId, secret];
    
    NSURL *photoURL = [NSURL URLWithString:urlString];
    
    return photoURL;
}

- (void) catPhotoWithCompletion:(void (^)(UIImage * image))completionHandler{
    NSURL *url= self.photoURL;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        self.catImage = image;
        
        completionHandler(image);
    }];
    [downloadTask resume];
}

@end
