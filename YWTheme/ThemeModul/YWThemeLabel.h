//
//  YWThemeLabel.h
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWThemeLabel : UILabel

//背景颜色名称
@property(nonatomic,copy)NSString * ywBackColorName;
///文字颜色名称
@property(nonatomic,copy)NSString * ywFontColorName;
///文字字体类型和大小 名称
@property(nonatomic,copy)NSString * ywFontTypeSizeName;


- (id)initWithFontColorName:(NSString *)ywFontColorName;

@end
