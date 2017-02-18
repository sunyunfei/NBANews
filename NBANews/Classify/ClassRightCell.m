//
//  ClassRightCell.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ClassRightCell.h"

@implementation ClassRightCell

- (void)setTypeName:(NSString *)typeName{

    _typeName = typeName;
    self.typeNameLabel.text = typeName;
}

@end
