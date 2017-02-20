//
//  VideoVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "VideoVC.h"
#import "VideoCell.h"
#import "VideoModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
static NSString *cell_video = @"VideoCell";
@interface VideoVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;//布局
@property(nonatomic,strong)NSMutableArray *videoArray;//数据
@property(nonatomic,assign)int lastIndex;
@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastIndex = 0;
    self.videoArray = [NSMutableArray array];
    [self p_loadCollectionView];
    [self p_loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCoolectionViewColor) name:Night_Not object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)changeCoolectionViewColor{

    [YFDefaultsManager obtainIsNightStatus] ? (self.collectionView.backgroundColor = [UIColor blackColor]) :(self.collectionView.backgroundColor = [UIColor whiteColor]);
}
#pragma mark ----ui加载

- (void)p_loadCollectionView{

    UICollectionViewFlowLayout *f = [[UICollectionViewFlowLayout alloc]init];
    f.itemSize = CGSizeMake(K_W / 2 - 4, K_W / 2 -4);
    f.minimumLineSpacing = 1;
    f.minimumInteritemSpacing = 1;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:f];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self changeCoolectionViewColor];
    [self.collectionView registerNib:[UINib nibWithNibName:cell_video bundle:nil] forCellWithReuseIdentifier:cell_video];
    
    __block typeof(self)weakSelf = self;
    [YFMYRefresh pushDownAndRefreshCollectionView:self.collectionView withResult:^{
        
        [weakSelf.videoArray removeAllObjects];
        weakSelf.lastIndex = 0;
        [weakSelf p_loadData];
    }];
    
    [YFMYRefresh pushUpAndMoreCollectionView:self.collectionView withResult:^{
        
        [weakSelf p_loadData];
    }];
    [self.view addSubview:self.collectionView];
}

#pragma mark ----data
- (void)p_loadData{

    //查找home表(测试用，以后可以建立一个表头数据表)
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_video"];
    bquery.limit = 20;
    bquery.skip = self.lastIndex;
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                VideoModel *model = [[VideoModel alloc]initWithBmob:obj];
                [_videoArray addObject:model];
            }
            //刷新表
            [_collectionView reloadData];
            [_collectionView.mj_header endRefreshing];
            [_collectionView.mj_footer endRefreshing];
            self.lastIndex += 20;
        }else{
            
            NSLog(@"error");
        }
        
    }];
}

#pragma mark ----代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.videoArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_video forIndexPath:indexPath];
    cell.model = self.videoArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoModel *model = self.videoArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.video_videoUrl];
    NSLog(@"%@",url);
    AVPlayerViewController * play = [[AVPlayerViewController alloc]init];
    play.player = [[AVPlayer alloc]initWithURL:url];
    [self presentViewController:play animated:YES completion:nil];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
