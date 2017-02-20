//
//  PhotoShowManager.h
//  YangLiWu
//
//  Created by 孙云 on 16/9/6.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoShowManager : NSObject
//图片传递
@property(nonatomic,copy)void((^iconBlock)(UIImage *icon));
//图片完成传递事件
//@property(nonatomic,copy)void((^photoSubmitBlock)(NSString *imageName));
//单类
+ (instancetype)sharePhotoManager;
//跳转相册
- (void)skipPhotoAlbumVC;
@end
