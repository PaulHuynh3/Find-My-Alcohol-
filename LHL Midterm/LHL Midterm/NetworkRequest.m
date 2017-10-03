//
//  NetworkRequest.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

+(void)queryProductComplete:(void (^)(NSArray<LCBO*> *))complete{
    
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://lcboapi.com/products?where=is_seasonal&order=price_in_cents"]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
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
        NSMutableArray<LCBO*> *seasonalAlcohol = [@[] mutableCopy];
        
        //creates an empty array where i am accessing the dictionary-array and then saving its array to my mutable array.
        for (NSDictionary *LCBOInfo in result[@"result"]) {
            //use the instance method of flickrPhoto to save the item into the method.
            [seasonalAlcohol addObject:[[LCBO alloc]initWithInfo:LCBOInfo]];
        }
        //save the mutable array catphotos to the block.
        complete(seasonalAlcohol);
        
    }];
    //always set after block to make sure the program continues to run while block is retriving data.
    [task resume];
    
}

//this method finds the image and set it to the block "complete" to display in view.
+(void)loadImageForPhoto:(LCBO *)photo complete:(void (^)(UIImage *))complete{
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[photo url] completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        
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
        
        UIImage *image = [UIImage imageWithData:data];
        
        //complete is the block input we are putting the return image in it.
        complete(image);
    }];
    //resume is outside block to continue program.
    [task resume];
    
}

+(void)queryLocationComplete:(void (^)(NSArray<Location*> *))complete{
    
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://lcboapi.com/stores?lat=43.659&lon=-79.439&order=distance_in_meters&where=has_parking,has_tasting_bar"]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
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
        NSMutableArray<Location*> *location = [@[] mutableCopy];
        
        //creates an empty array where i am accessing the dictionary-array and then saving its array to my mutable array.
        for (NSDictionary *locationInfo in result[@"result"]) {
            //use the instance method of flickrPhoto to save the item into the method.
            [location addObject:[[Location alloc]initWithInfo:locationInfo]];
        }
        //save the mutable array catphotos to the block.
        complete(location);
        
    }];
    //always set after block to make sure the program continues to run while block is retriving data.
    [task resume];
    
}






@end
