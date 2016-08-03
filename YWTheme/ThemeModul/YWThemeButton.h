//
//  YWThemeButton.h
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWThemeButton : UIButton


//Normal状态下的图片名称
@property(nonatomic,copy)NSString * ywImageName;
//高亮状态下的图片名称
@property(nonatomic,copy)NSString * ywHighligtImageName;

//Normal状态下的背景图片名称
@property(nonatomic,copy)NSString * ywBackgroundImageName;
//高亮状态下的背景图片名称
@property(nonatomic,copy)NSString * ywBackgroundHighligtImageName;

//背景颜色名称
@property(nonatomic,copy)NSString * ywBackColorName;
///文字颜色名称
@property(nonatomic,copy)NSString * ywFontColorName;
///文字字体类型和大小 名称
@property(nonatomic,copy)NSString * ywFontTypeSizeName;

- (id)initWithImage:(NSString *)ywImageName highlighted:(NSString *)ywHighligtImageName;

- (id)initWithBackground:(NSString *)ywBackgroundImageName highlightedBackground:(NSString *)ywBackgroundHighligtImageName;

@end
