//
//  YWTheme.m
//  YWTheme
//
//  Created by huancheng on 16/7/31.
//  Copyright © 2016年 huancheng. All rights reserved.
//

#import "YWTheme.h"

static YWTheme *sigleton = nil;
static NSFileManager * fm = nil;///文件管理

@implementation YWTheme


+ (YWTheme *)shareInstance
{
    if (sigleton == nil)
    {
        @synchronized(self)
        {
            sigleton = [[YWTheme alloc] init];
            fm = [NSFileManager defaultManager];
        }
    }
    return sigleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //读取主题配置文件
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"ywtheme" ofType:@"plist"];
        self.themeBasePlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        if(self.themeBasePlist == nil)
        {
            NSLog(@"YWTheme告诉你, ywtheme.plist文件不存在！请检查！");
        }else{
            self.themeArray = [self.themeBasePlist objectForKey:@"themeOrder"];
            self.themesPlist = [self.themeBasePlist objectForKey:@"themeTitle"];
        }
        //默认为空
        self.themeName = nil;
    }
    return self;
}
///取得主题列表
+(NSArray *)getThemesArray
{
    return [YWTheme shareInstance].themeArray;
}
///取得当前主题
+ (NSString *)getCurrentThemeName
{
    NSString * currentThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
    return currentThemeName;
}
///保存设置的主题
+ (void)saveCurrentThemeName:(NSString *)currentThemeName
{
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults] setObject:currentThemeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[YWTheme shareInstance] setThemeName:currentThemeName];
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNofication object:currentThemeName];
}
//切换主题时，会调用此方法设置主题名称
- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName)
    {
        _themeName = [themeName copy];
    }
    NSString * themeDir = [self getThemeBasePath];
    //切换主题，重新加载当前主题下的颜色配置文件
    NSString * filePathColor = [themeDir stringByAppendingPathComponent:@"ywColor.plist"];
    self.ywColorPlist = [NSDictionary dictionaryWithContentsOfFile:filePathColor];
    if(self.ywColorPlist == nil)
    {
        ///如果前面的路径没有，则有可能是 blueywColor.plist   格式的命名
        self.ywColorPlist = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@ywColor.plist",themeDir]];
    }
    if(self.ywColorPlist == nil)
    {
        NSLog(@"YWTheme告诉你, ywColor.plist 文件不存在！请检查！");
    }
    
    //切换主题，重新加载当前主题下的字体配置文件
    NSString * filePathFont = [themeDir stringByAppendingPathComponent:@"ywFont.plist"];
    self.ywFontPlist = [NSDictionary dictionaryWithContentsOfFile:filePathFont];
    if(self.ywFontPlist == nil)
    {
        ///如果前面的路径没有，则有可能是 blueywFont.plist   格式的命名
        self.ywFontPlist = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@ywFont.plist",themeDir]];
    }
    if(self.ywFontPlist == nil)
    {
        NSLog(@"YWTheme告诉你, ywFont.plist 文件不存在！请检查！");
    }
    
}

///获取主题下对应的配置
-(NSString *)getThemePath
{
    if(self.themeName == nil || [@"" isEqualToString:self.themeName])
    {
        return @"";
    }
    return [self.themesPlist objectForKey:_themeName];
}

//获取主题目录
- (NSString *)getThemeBasePath
{
    if (self.themeName == nil|| [@"" isEqualToString:self.themeName])
    {
        //如果主题名为空，则使用项目包根目录下的默认主题图片
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        return resourcePath;
    }
    
    //取得主题目录, 如：Skins/blue
    NSString *themePath = [self.themesPlist objectForKey:_themeName];
    //程序包的根目录
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    //完整的主题包目录
    NSString *path = [resourcePath stringByAppendingPathComponent:themePath];
    
    return path;
}

//返回当前主题下的图片，由于目前用 xcassets来管理图片的项目多了，所以
- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0)
    {
        return nil;
    }
    UIImage *image = nil;
    if(self.themeName == nil || [@"" isEqualToString:self.themeName])
    {
        ///没有主题，取基本的默认的图吧
        image = [UIImage imageNamed:imageName];
    }else
    {
        ///如果主题不为空的，则直接取xcassets中的图，图片命名： themPath+imageName, 如 themPath为 blue ,imageName为 icon.png ,则为 blueicon
        NSString * newimageName = [NSString stringWithFormat:@"%@%@",[self getThemePath],imageName];
        image = [UIImage imageNamed:newimageName];
    }
    if(image == nil)
    {
        ///还是空的？没有找到图？那就取主题目录
        //获取主题目录
        NSString *themePath = [self getThemeBasePath];
        //imageName在当前主题的路径
        NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    if(image == nil)
    {
        NSLog(@"我告诉你咯，你的图片没有找到，主题：%@   图片名：%@",[self getThemePath],imageName);
    }
    return image;
}

////根据名称，取得当前主题所对应的颜色值
- (UIColor *)getColorWithName:(NSString *)name
{
    if (name.length == 0)
    {
        return nil;
    }
    if(self.ywColorPlist == nil)
    {
        return nil;
    }
    //返回三色值，如：24,35,60
    NSString *rgb = [_ywColorPlist objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","]; ///格式： r,g,b
    if (rgbs.count == 3)
    {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        return color;
    }
    return nil;
}

///根据名称，取得当前主题所对应的字体
-(UIFont *)getFontWithName:(NSString *)name
{
    if(name.length == 0)
    {
        return nil;
    }
    if(self.ywFontPlist == nil)
    {
        return nil;
    }
    //返回字体配置
    NSString * fontStr = [_ywFontPlist objectForKey:name];
    /// 格式： 字大小,字体类型   如： 18,AmericanTypewriter  如果后面类型没有，则默认系统字体
    NSArray * fontsizearray = [fontStr componentsSeparatedByString:@","];
    UIFont * font = nil;
    if(fontsizearray.count == 1)
    {
        ///只有大小，没有类型，默认系统
        float fontSize = [fontsizearray[0] floatValue];
        font = [UIFont systemFontOfSize:fontSize];
    }else if(fontsizearray.count == 2)
    {
        ///有大小，有类型
        float fontSize = [fontsizearray[0] floatValue];
        NSString * fontName = [fontsizearray[1] description];
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    return font;
}
//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sigleton == nil)
        {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
