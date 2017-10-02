//
//  AppDelegate.h
//  LHL Midterm
//
//  Created by Paul on 2017-10-02.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

