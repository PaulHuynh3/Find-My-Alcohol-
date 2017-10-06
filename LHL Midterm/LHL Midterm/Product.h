//
//  LCBO.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* origin;
@property (nonatomic) int priceInCents;
@property (nonatomic) int alcoholContent;
@property (nonatomic) NSString* urlImage;
@property (nonatomic) int productID;
@property (nonatomic) NSString* packageDescription;
@property (nonatomic) NSString* primaryCategory;
@property (nonatomic) NSString* secondaryCategory;


@property (nonatomic) UIImage* image;


-(instancetype)initWithInfo:(NSDictionary*)info;

- (NSURL *)url;



@end
