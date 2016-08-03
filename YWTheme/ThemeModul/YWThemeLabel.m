//
//  YWThemeLabel.m
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import "YWThemeLabel.h"
#import "YWTheme.h"

@implementation YWThemeLabel

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

//使用xib创建后，调用的初始化方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    
    ///从xib 中的 User Defined Runtime Attributes 中获取配置
    self.ywBackColorName = [self valueForKey:@"ywBackColorName"];
    self.ywFontColorName = [self valueForKey:@"ywFontColorName"];
    self.ywFontTypeSizeName = [self valueForKey:@"ywFontTypeSizeName"];
}
- (id)initWithFontColorName:(NSString *)ywFontColorName
{
    self = [self init];
    if (self != nil)
    {
        self.ywFontColorName = ywFontColorName;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setColor
{
    ///背景颜色
    if(self.ywBackColorName.length > 0)
    {
        UIColor * color = [[YWTheme shareInstance] getColorWithName:_ywBackColorName];
        [self setBackgroundColor:color];
    }
    ///文字颜色
    if(self.ywFontColorName.length > 0)
    {
        UIColor * color = [[YWTheme shareInstance] getColorWithName:_ywFontColorName];
        self.textColor = color;
    }
    ///文字类型和大小
    if(self.ywFontTypeSizeName.length > 0)
    {
        UIFont * font = [[YWTheme shareInstance] getFontWithName:_ywFontTypeSizeName];
        if(font != nil)
        {
            [self setFont:font];
        }
    }
}

#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification
{
    [self setColor];
}

/**
 * 设置背景颜色
 *
 **/
-(void)setYwBackColorName:(NSString *)ywBackColorName
{
    if(_ywBackColorName != ywBackColorName)
    {
        _ywBackColorName = [ywBackColorName copy];
    }
    //重新加载颜色
    UIColor * color = [[YWTheme shareInstance] getColorWithName:_ywBackColorName];
    [self setBackgroundColor:color];
}

/**
 * 设置文字颜色
 *
 **/
-(void)setYwFontColorName:(NSString *)ywFontColorName
{
    if(_ywFontColorName != ywFontColorName)
    {
        _ywFontColorName = [ywFontColorName copy];
    }
    //重新加载颜色
    UIColor * color = [[YWTheme shareInstance] getColorWithName:_ywFontColorName];
    self.textColor = color;
}
/**
 * 设置字体类型和大小
 *
 ***/
-(void)setYwFontTypeSizeName:(NSString *)ywFontTypeSizeName
{
    if(_ywFontTypeSizeName != ywFontTypeSizeName)
    {
        _ywFontTypeSizeName = [ywFontTypeSizeName copy];
    }
    ///重新加载字体类型和大小
    UIFont * font = [[YWTheme shareInstance] getFontWithName:_ywFontTypeSizeName];
    if(font != nil)
    {
        [self setFont:font];
    }
}

@end
