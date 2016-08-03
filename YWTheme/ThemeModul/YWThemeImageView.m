//
//  YWThemeImageView.m
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import "YWThemeImageView.h"
#import "YWTheme.h"

@interface YWThemeImageView()
{
    BOOL isOpendNotification;
}
@end

@implementation YWThemeImageView

- (id)init
{
    self = [super init];
    if (self)
    {
        //监听主题切换通知
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
}

- (id)initWithImageName:(NSString *)ywImageName
{
    self = [self init];
    if (self != nil)
    {
        self.ywImageName = ywImageName;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setYwImageName:(NSString *)ywImageName
{
    if (_ywImageName != ywImageName)
    {
        _ywImageName = [ywImageName copy];
    }
    [self loadThemeImage];
}

//加载当前主题下对应的图片
- (void)loadThemeImage
{
    if (self.ywImageName == nil)
    {
        return;
    }
    
    UIImage *image = [[YWTheme shareInstance] getThemeImage:_ywImageName];
    if(self.leftCapWidth > 0 && self.topCapHeight > 0)
    {
        image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    }
    self.image = image;
}

//主题切换的通知
#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
}

@end
