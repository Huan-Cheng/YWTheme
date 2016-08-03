//
//  YWThemeUIFactory.h
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWThemeButton.h"
#import "YWThemeImageView.h"
#import "YWThemeLabel.h"

@interface YWThemeUIFactory : NSObject

/***
 * 创建button
 *
 **/
+ (YWThemeButton *)createButtonImage:(NSString *)imageName highlightedImage:(NSString *)highlightedName;

+ (YWThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)highlightedName;

//创建ImageView
+ (YWThemeImageView *)createImageView:(NSString *)imageName;

//创建Label
+ (YWThemeLabel *)createLabel:(NSString *)colorName;

@end
