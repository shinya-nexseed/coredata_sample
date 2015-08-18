//
//  ViewController.m
//  coredata_sample
//
//  Created by Shinya Hirai on 2015/08/17.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Photo.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () {
    NSMutableArray *_result;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    AppDelegate *manager = [AppDelegate sharedManager];
    
    _result = [manager all:@"Photo" sortKey:@"urlStr"];
    
    NSLog(@"results = %lu", (unsigned long)_result.count);


    NSLog(@"%f",self.view.bounds.size.width / 3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectImage:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"photo library invalid.");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // Pathを取得
    NSURL *referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    //
    AppDelegate *manager = [AppDelegate sharedManager];
    
    NSString *urlStr = [referenceURL absoluteString];
    
    Photo *photo = (Photo *)[manager entityForInsert:@"Photo"];
    photo.urlStr = urlStr;
    
    [manager saveContext];
    
    _result = [manager all:@"Photo" sortKey:@"urlStr"];
    
    NSLog(@"=====================");
    for (NSManagedObject *a in _result) {
        Photo *b = (Photo *) a;
        NSLog(@"url = %@", b.urlStr);
    }
    
    [self.collectionView reloadData];
    // モーダルビューを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _result.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    
    AppDelegate *manager = [AppDelegate sharedManager];

    _result = [manager all:@"Photo" sortKey:@"urlStr"];
    NSManagedObject *o = _result[indexPath.row];
    Photo *b = (Photo *) o;
    NSLog(@"b url = %@", b.urlStr);
    
    NSURL *photoUrl = [NSURL URLWithString:b.urlStr];
    
    // AssetsLibratyを作成
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:photoUrl resultBlock:^(ALAsset *asset) {
        // まずassetからバッファをつくる
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES]; //これが必要なデータ
        // データからUIImageを作成
        UIImage *imageFromFile = [UIImage imageWithData:data];
        // 画像をセット
        imageView.image = imageFromFile;
        
    } failureBlock:^(NSError *error) {
        // error handling
    }];

    
    return cell;
}


@end
