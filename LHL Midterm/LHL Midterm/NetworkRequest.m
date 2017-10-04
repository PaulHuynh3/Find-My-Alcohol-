//
//  NetworkRequest.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "NetworkRequest.h"
#import "Secret.h"

@interface NetworkRequest ()

@property (nonatomic) Product *lcboProduct;

@end

@implementation NetworkRequest

+(void)queryProductComplete:(void (^)(NSArray<Product*> *))complete{
    
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://lcboapi.com/products?where=has_value_added_promotion&order=price_in_cents"]];
    
    //this is when you have a header
    NSMutableURLRequest *reqWithHeader = [NSMutableURLRequest requestWithURL:queryURL];
    [reqWithHeader addValue:[NSString stringWithFormat:@"Token token=%@",LCBO_KEY] forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:reqWithHeader completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //happening inside this block of code.
        // this is where we get the results
        if (error != nil) {
            NSLog(@"error in url session: %@", error.localizedDescription);
            abort(); // TODO: display an alert or something
        }
        // TODO: check the response code we got; if it's >= 300 something is wrong
        // remember to check status code, we need to cast response to a NSHTTPURLResponse
        if (((NSHTTPURLResponse*)response).statusCode >= 300) {
            NSLog(@"Unexpected http response: %@", response);
            abort(); // TODO: display an alert or something
        }
        
        NSError *err = nil;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (err != nil) {
            NSLog(@"Something went wrong parsing JSON: %@", err.localizedDescription);
            abort();
        }
        //short way of doing [[NSMutableArray alloc]init];
        NSMutableArray<Product*> *promotionalAlcohol = [@[] mutableCopy];
         
        //creates an empty array where i am accessing the dictionary-array and then saving its array to my mutable array.
        for (NSDictionary *LCBOInfo in result[@"result"]) {
            
            //make a method here to say if json data is nil do not include in array
            [promotionalAlcohol addObject:[[Product alloc]initWithInfo:LCBOInfo]];
        
        }
        //save the mutable array catphotos to the block.
        complete(promotionalAlcohol);
        
    }];
    //always set after block to make sure the program continues to run while block is retriving data.
    [task resume];
    
}


//this method finds the image and set it to the block "complete" to display in view.
+(void)loadImageForPhoto:(Product *)photo complete:(void (^)(UIImage *))complete{
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[photo url] completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        

        //commented this section out because it crashes app even tho we set some photos nill instead of null
        if (error != nil) {
            NSLog(@"error in url session: %@", error.localizedDescription);
//            abort(); // TODO: display an alert or something
            return;
        }
        // TODO: check the response code we got; if it's >= 300 something is wrong
        if (((NSHTTPURLResponse*)response).statusCode >= 300) {
            NSLog(@"Unexpected http response: %@", response);
            abort(); // TODO: display an alert or something
        }
        

        UIImage *image = [UIImage imageWithData:data];
        
        //complete is the block input we are putting the return image in it.
        complete(image);
    }];
    //resume is outside block to continue program.
    [task resume];
    
}


+(void)queryLocationPromotionItem:(double)latitude longitude:(double)longitude product:(int)productId display:(int)stores complete:(void (^)(NSArray<Store*>*))complete{
    
    //return only stores that have product_id of seasonal products have to make this link dynamic so that when my seasonal products are returned with these ids..
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://lcboapi.com/stores?lat=%f&lon=%f&product_id=%i",latitude,longitude,productId]];
    
    //header for website
    NSMutableURLRequest *reqWithHeader = [NSMutableURLRequest requestWithURL:queryURL];
    [reqWithHeader addValue:[NSString stringWithFormat:@"Token token=%@",LCBO_KEY] forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:reqWithHeader completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //happening inside this block of code.
        // this is where we get the results
        if (error != nil) {
            NSLog(@"error in url session: %@", error.localizedDescription);
            return; // TODO: display an alert or something
        }
        // TODO: check the response code we got; if it's >= 300 something is wrong
        // remember to check status code, we need to cast response to a NSHTTPURLResponse
        if (((NSHTTPURLResponse*)response).statusCode >= 300) {
            NSLog(@"Unexpected http response: %@", response);
            abort(); // TODO: display an alert or something
        }
        
        NSError *err = nil;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (err != nil) {
            NSLog(@"Something went wrong parsing JSON: %@", err.localizedDescription);
            abort();
        }
        //short way of doing [[NSMutableArray alloc]init];
        NSMutableArray<Store*> *locationArray = [@[] mutableCopy];
   
        
        for (NSDictionary *locationInfo in result[@"result"]) {
            
            [locationArray addObject:[[Store alloc]initWithInfo:locationInfo]];
            
        }
        
        
    NSArray *numberOfStores = [locationArray subarrayWithRange:NSMakeRange(0, MIN(stores, locationArray.count))];
        
        
        //save the mutable array to the completion block.
        complete(numberOfStores);
        
    }];
    //always set after block to make sure the program continues to run while block is retriving data.
    [task resume];
    
}






@end
