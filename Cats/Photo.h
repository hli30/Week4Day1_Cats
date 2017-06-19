//
//  Photo.h
//  Cats
//
//  Created by Harry Li on 2017-06-19.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *catImage;

- (instancetype)initWithDictionary:(NSDictionary *) dict;
- (void)catPhotoWithCompletion:(void (^)(UIImage * image))completionHandler;

@end
