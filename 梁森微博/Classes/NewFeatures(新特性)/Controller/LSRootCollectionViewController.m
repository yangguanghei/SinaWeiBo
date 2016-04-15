//
//  LSRootCollectionViewController.m
//  梁森微博
//
//  Created by pro on 16/4/15.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSRootCollectionViewController.h"

// 新特性单元格
#import "LSNewFeatureCell.h"
@interface LSRootCollectionViewController ()

@end

@implementation LSRootCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

// 重写初始化的方法
- (instancetype)init
{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // cell的滑动方向改为横向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // cell的间距为零
    layout.minimumLineSpacing = 0;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LSNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

// 单元格的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LSNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor yellowColor];
    NSString * imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
