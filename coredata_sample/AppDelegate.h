//
//  AppDelegate.h
//  coredata_sample
//
//  Created by Shinya Hirai on 2015/08/17.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
-(NSMutableArray *)all:(NSString *)entityName;
-(NSMutableArray *)all:(NSString *)entityName sortKey:(NSString *)key;
-(NSMutableArray *)fetch:(NSString *)entityName limit:(int)limit;
-(NSMutableArray *)fetch:(NSString *)entityName sortKey:(NSString *)key limit:(int)limit;
-(NSManagedObject *)entityForInsert:(NSString *)entityName;

- (NSURL *)applicationDocumentsDirectory;

+ (id)sharedManager;



@end

