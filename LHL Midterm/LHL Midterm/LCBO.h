//
//  LCBO.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCBO : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* origin;
@property (nonatomic) int priceInCents;
@property (nonatomic) BOOL isSeasonal;
@property (nonatomic) int alcoholContent;
@property (nonatomic) NSString* alcoholDescription;
@property (nonatomic) UIImage* image;


-(instancetype)initWithInfo:(NSDictionary*)info;





@end
