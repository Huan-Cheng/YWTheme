//
//  YWThemeButton.m
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import "YWThemeButton.h"
#import "YWTheme.h"

@implementation YWThemeButton

- (id)init
{
    self = [super init];
    if (self)
    {
        //监听主题切换的通知
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
    self.ywImageName = [self valueForKey:@"ywImageName"];
    self.ywHighligtImageName = [self valueForKey:@"ywHighligtImageName"];
    self.ywBackgroundImageName = [self valueForKey:@"ywBackgroundImageName"];
    self.ywBackgroundHighligtImageName = [self valueForKey:@"ywBackgroundHighligtImageName"];
    self.ywBackColorName = [self valueForKey:@"ywBackColorName"];
    self.ywFontColorName = [self valueForKey:@"ywFontColorName"];
    self.ywFontTypeSizeName = [self valueForKey:@"ywFontTypeSizeName"];
}

- (id)initWithImage:(NSString *)ywImageName highlighted:(NSString *)ywHighligtImageName
{
    self = [self init];
    if (self)
    {
        self.ywImageName = ywImageName;
        self.ywHighligtImageName = ywHighligtImageName;
    }
    return self;
}

- (id)initWithBackground:(NSString *)ywBackgroundImageName highlightedBackground:(NSString *)ywBackgroundHighligtImageName
{
    self = [self init];
    if (self)
    {
        self.ywBackgroundImageName = ywBackgroundImageName;
        self.ywBackgroundHighligtImageName = ywBackgroundHighligtImageName;
    }
    return self;
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification action
//切换主题的通知
- (void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
}

//加载图片
- (void)loadThemeImage
{
    YWTheme * themeManager = [YWTheme shareInstance];
    

    UIImage *image = [themeManager getThemeImage:_ywImageName];
    [self setImage:image forState:UIControlStateNormal];
    
    UIImage *highligtImage = [themeManager getThemeImage:_ywHighligtImageName];
    [self setImage:highligtImage forState:UIControlStateHighlighted];
    
    
    UIImage *backImage = [themeManager getThemeImage:_ywBackgroundImageName];
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    UIImage *backHighligtImage = [themeManager getThemeImage:_ywBackgroundHighligtImageName];
    [self setBackgroundImage:backHighligtImage forState:UIControlStateHighlighted];
    
    if(self.ywBackColorName.length > 0)
    {
        UIColor * color = [themeManager getColorWithName:_ywBackColorName];
        [self setBackgroundColor:color];
    }
    
    if(self.ywFontColorName.length > 0)
    {
        UIColor * color = [themeManager getColorWithName:_ywFontColorName];
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    
    if(self.ywFontTypeSizeName.length > 0)
    {
        UIFont * font = [[YWTheme shareInstance] getFontWithName:_ywFontTypeSizeName];
        if(font != nil)
        {
            [self.titleLabel setFont:font];
        }
    }
}

#pragma mark - setter  设置图片名后，重新加载该图片名对应的图片
- (void)setYwImageName:(NSString *)ywImageName
{
    if (_ywImageName != ywImageName)
    {
        _ywImageName = [ywImageName copy];
    }
    //重新加载图片
    UIImage *image = [[YWTheme shareInstance] getThemeImage:_ywImageName];
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setYwHighligtImageName:(NSString *)ywHighligtImageName
{
    if (_ywHighligtImageName != ywHighligtImageName)
    {
        _ywHighligtImageName = [ywHighligtImageName copy];
    }
    //重新加载图片
    UIImage *highligtImage = [[YWTheme shareInstance] getThemeImage:_ywHighligtImageName];
    [self setImage:highligtImage forState:UIControlStateHighlighted];
}

- (void)setYwBackgroundImageName:(NSString *)ywBackgroundImageName
{
    if (_ywBackgroundImageName != ywBackgroundImageName)
    {
        _ywBackgroundImageName = [ywBackgroundImageName copy];
    }
    //重新加载图片
    UIImage *backImage = [[YWTheme shareInstance] getThemeImage:_ywBackgroundImageName];
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
}

- (void)setYwBackgroundHighligtImageName:(NSString *)ywBackgroundHighligtImageName
{
    if (_ywBackgroundHighligtImageName != ywBackgroundHighligtImageName)
    {
        _ywBackgroundHighligtImageName = [ywBackgroundHighligtImageName copy];
    }
    //重新加载图片
    UIImage * backHighligtImage = [[YWTheme shareInstance] getThemeImage:_ywBackgroundHighligtImageName];
    [self setBackgroundImage:backHighligtImage forState:UIControlStateHighlighted];
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
     [self setTitleColor:color forState:UIControlStateNormal];
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
        [self.titleLabel setFont:font];
    }
}
@end
