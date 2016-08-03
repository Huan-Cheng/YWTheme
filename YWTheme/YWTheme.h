//
//  YWTheme.h
//  YWTheme
//
//  Created by huancheng on 16/8/3.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWThemeUIFactory.h"

//! Project version number for YWTheme.
FOUNDATION_EXPORT double YWThemeVersionNumber;

//! Project version string for YWTheme.
FOUNDATION_EXPORT const unsigned char YWThemeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <YWTheme/PublicHeader.h>


////主题保存主题类别
#define kThemeName @"kThemeName"
///通知切换主题
#define kThemeDidChangeNofication @"kThemeDidChangeNofication"


@interface YWTheme : NSObject


//当前使用的主题名称
@property(nonatomic,retain)NSString *themeName;
///ywtheme.plist文件
@property(nonatomic,retain)NSDictionary * themeBasePlist;
///配置的主题列表，只包含主题
@property(nonatomic,retain)NSArray * themeArray;
//配置主题的字典，key value 包含 主题和主题对应的目录
@property(nonatomic,retain)NSDictionary *themesPlist;
//配置颜色plist文件
@property(nonatomic,retain)NSDictionary * ywColorPlist;
//配置字体plist文件
@property(nonatomic,retain)NSDictionary * ywFontPlist;

+ (YWTheme *)shareInstance;

///取得主题列表
+(NSArray *)getThemesArray;
///取得当前主题
+ (NSString *)getCurrentThemeName;
///保存设置的主题
+ (void)saveCurrentThemeName:(NSString *)currentThemeName;

//返回当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//返回当前主题下，颜色
- (UIColor *)getColorWithName:(NSString *)name;

//返回当前主题下，字体
- (UIFont *)getFontWithName:(NSString *)name;




/********************
 说明：
 1、引入基本文件。
 2、创建一个 ywtheme.plist 文件
 3、在 ywtheme.plist 文件中 Root type修改为 Dictionary ，字典的value  type 修改为 String.
 4、Root下包含 themeOrder (这是个Array,列表，排序用的，字典取出来是无序的，)， 另一个是 themeTitle （这个是字典，key与 themeOrder中一一对应，value 是目录或者前缀） 在该字典中增加主题，以 key value 形式增加。
 5、key 为 themeName ,切换主题时，靠它。  value 为主题路径，资源文件。
 6、在添加主题文件时，以蓝色文件形式添加。 文件名、路径，要和 第5条中配置的value值一致。
 7、在每一个主题文件夹中，都创建一个 ywColor.plist 文件，该文件主要用于配置颜色。
 8、该plist文件， Root type为 Dictionary ,key为自定义颜色名，value type 为String，存储颜色值 RGB格式 r,g,b  如：255,255,255
 9、图片存放说明，如果是以 Images.xcassets 来管理图片的，
 10、可以从xib 中的 User Defined Runtime Attributes 中配置属性
 11、
 **/
@end