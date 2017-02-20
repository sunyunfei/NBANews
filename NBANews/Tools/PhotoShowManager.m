//
//  PhotoShowManager.m
//  YangLiWu
//
//  Created by 孙云 on 16/9/6.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "PhotoShowManager.h"
@interface PhotoShowManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@end
@implementation PhotoShowManager
//单类
+ (instancetype)sharePhotoManager{

    static PhotoShowManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PhotoShowManager alloc]init];
    });
    return manager;
}

//跳转相册
- (void)skipPhotoAlbumVC{

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate                 = self;
    picker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing            = YES;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *avatar = info[UIImagePickerControllerEditedImage];
    //图片传递
    if(self.iconBlock){
    
        self.iconBlock(avatar);
    }
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self saveImage:avatar WithName:@"userAvatar.jpg"];
}

//保存图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    //测试用
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.1);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    
    //上传
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(tempImage)) {
        //返回为png图像。
        UIImage *imagenew = [self imageWithImageSimple:tempImage scaledToSize:CGSizeMake(110, 110)];
        imageData = UIImagePNGRepresentation(imagenew);
    }else {
        //返回为JPEG图像。
        UIImage *imagenew = [self imageWithImageSimple:tempImage scaledToSize:CGSizeMake(110, 110)];
        imageData = UIImageJPEGRepresentation(imagenew, 0.3);
    }
    
    //上传图片
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[self getTimeNow]];
    BmobFile *file = [[BmobFile alloc] initWithFileName:fileName withFileData:imageData];
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
          
            //更新
            BmobQuery *bquery = [BmobQuery queryWithClassName:@"news_user"];
            [bquery getObjectInBackgroundWithId:[NSString stringWithFormat:@"%@",[YFDefaultsManager obtainUserId:login_userId]] block:^(BmobObject *object, NSError *error) {
                
                if (!error) {
                    if (object) {
                        BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:@"news_user" objectId:[YFDefaultsManager obtainUserId:login_userId]];
                        //设置cheatMode为YES
                        [obj1 setObject:fileName forKey:@"user_icon"];
                        //异步更新数据
                        [obj1 updateInBackground];
                        NSLog(@"上传成功");
                    }else{
                    
                        NSLog(@"上传失败");
                    }
                }else{
                
                     NSLog(@"上传失败,%@",error);
                }
            }];
        }else{
        
            NSLog(@"上传失败");
        }
    }];
    
}

//压缩图片尺寸
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

/**
 *  返回当前时间
 *
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    //NSLog(@"%@", timeNow);
    return timeNow;
}

@end
