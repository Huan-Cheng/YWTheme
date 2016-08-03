//
//  YWThemeImageView.h
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWThemeImageView : UIImageView

//图片名称
@property(nonatomic,copy)NSString * ywImageName;

@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;

- (id)initWithImageName:(NSString *)ywImageName;


@end
