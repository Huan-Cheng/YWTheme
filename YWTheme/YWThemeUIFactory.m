//
//  YWThemeUIFactory.m
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import "YWThemeUIFactory.h"


@implementation YWThemeUIFactory

/***
 * 创建button
 * @param imageName
 * @param highlightedName
 * @return button
 **/
+ (YWThemeButton *)createButtonImage:(NSString *)imageName highlightedImage:(NSString *)highlightedName
{
    YWThemeButton *button = [[YWThemeButton alloc] initWithImage:imageName highlighted:highlightedName];
    return button;
}

/***
 * 创建button
 * @param backgroundImageName
 * @param highlightedName
 * @return button
 **/
+ (YWThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)highlightedName
{
    YWThemeButton *button = [[YWThemeButton alloc] initWithBackground:backgroundImageName highlightedBackground:highlightedName];
    return button;
}

+ (YWThemeButton *)createButtonBackColor:(NSString *)colorName
{
    return nil;
}

+ (YWThemeImageView *)createImageView:(NSString *)imageName
{
    YWThemeImageView *themeImage = [[YWThemeImageView alloc] initWithImageName:imageName];
    return themeImage;
}

+ (YWThemeLabel *)createLabel:(NSString *)colorName
{
    YWThemeLabel *themeLabel = [[YWThemeLabel alloc] initWithFontColorName:colorName];
    return themeLabel;
}

@end
