//
//  ViewController.h
//  coredata_sample
//
//  Created by Shinya Hirai on 2015/08/17.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)selectImage:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

