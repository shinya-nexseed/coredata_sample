//
//  Photo.h
//  coredata_sample
//
//  Created by Shinya Hirai on 2015/08/17.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * urlStr;

@end
