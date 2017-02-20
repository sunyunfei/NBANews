//
//  ClassRightCell.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFBaseCell.h"

@interface ClassRightCell : YFBaseCell
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property(nonatomic,copy)NSString *typeName;
@end
