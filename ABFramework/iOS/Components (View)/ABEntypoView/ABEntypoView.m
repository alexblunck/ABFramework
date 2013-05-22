//
//  ABEntypoView.m
//  ABFramework
//
//  Created by Alexander Blunck on 3/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ABEntypoView.h"

#define DEFAULT_SIZE 32.0f

@interface ABEntypoView ()
{
    ABLabel *_label;
}

@end

@implementation ABEntypoView

#pragma mark - Utility
+(id) viewWithIconName:(NSString*)iconName size:(CGFloat)size
{
    return [[self alloc] initWithIconName:iconName size:size];
}



#pragma mark - Initializer
-(id) initWithIconName:(NSString*)iconName size:(CGFloat)size
{
    self = [super init];
    if (self)
    {
        //Config
        self.frame = cgr(0, 0, size, size);
        self.userInteractionEnabled = NO;
        
        _label = [ABLabel new];
        _label.frame = self.bounds;
        _label.text = [self unicodeFromIconName:iconName];
        _label.centeredHorizontally = YES;
        _label.centeredVertically = YES;
        _label.customFont = [UIFont customFontWithName:@"Entypo" fontPath:@"ABFramework.bundle/ABEntypoView/Entypo" extension:@"otf" size:1.0f];        
        _label.textSize = size*1.7;
        _label.minimumFontSize = 20.0f;
    }
    return self;
}



#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [self addSubview:_label];
}



#pragma mark - Helper
-(NSString*) unicodeFromIconName:(NSString*)iconName
{
    NSString *string =  [[self unicodeDictionary] safeObjectForKey:iconName];
    if (string)
    {
        return string;
    }
    return nil;
}

-(NSDictionary*) unicodeDictionary
{
    return @{
             @"phone" : @"\U0001F4DE",
             @"mobile" : @"\U0001F4F1",
             @"mouse" : @"\U0000E789",
             @"address" : @"\U0000E723",
             @"mail" : @"\U00002709",
             @"paper-plane" : @"\U0001F53F",
             @"pencil" : @"\U0000270E",
             @"feather" : @"\U00002712",
             @"attach" : @"\U0001F4CE",
             @"inbox" : @"\U0000E777",
             @"reply" : @"\U0000E712",
             @"reply-all" : @"\U0000E713",
             @"forward" : @"\U000027A6",
             @"user" : @"\U0001F464",
             @"users" : @"\U0001F465",
             @"add-user" : @"\U0000E700",
             @"vcard" : @"\U0000E722",
             @"export" : @"\U0000E715",
             @"location" : @"\U0000E724",
             @"map" : @"\U0000E727",
             @"compass" : @"\U0000E728",
             @"direction" : @"\U000027A2",
             @"hair-cross" : @"\U0001F3AF",
             @"share" : @"\U0000E73C",
             @"shareable" : @"\U0000E73E",
             @"heart" : @"\U00002665",
             @"heart-empty" : @"\U00002661",
             @"star" : @"\U00002605",
             @"star-empty" : @"\U00002606",
             @"thumbs-up" : @"\U0001F44D",
             @"thumbs-down" : @"\U0001F44E",
             @"chat" : @"\U0000E720",
             @"comment" : @"\U0000E718",
             @"quote" : @"\U0000275E",
             @"home" : @"\U00002302",
             @"popup" : @"\U0000E74C",
             @"search" : @"\U0001F50D",
             @"flashlight" : @"\U0001F526",
             @"print" : @"\U0000E716",
             @"bell" : @"\U0001F514",
             @"link" : @"\U0001F517",
             @"flag" : @"\U00002691",
             @"cog" : @"\U00002699",
             @"tools" : @"\U00002692",
             @"trophy" : @"\U0001F3C6",
             @"tag" : @"\U0000E70C",
             @"camera" : @"\U0001F4F7",
             @"megaphone" : @"\U0001F4E3",
             @"moon" : @"\U0000263D",
             @"palette" : @"\U0001F3A8",
             @"leaf" : @"\U0001F342",
             @"note" : @"\U0000266A",
             @"beamed-note" : @"\U0000266B",
             @"new" : @"\U0001F4A5",
             @"graduation-cap" : @"\U0001F393",
             @"book" : @"\U0001F4D5",
             @"newspaper" : @"\U0001F4F0",
             @"bag" : @"\U0001F45C",
             @"airplane" : @"\U00002708",
             @"lifebuoy" : @"\U0000E788",
             @"eye" : @"\U0000E70A",
             @"clock" : @"\U0001F554",
             @"mic" : @"\U0001F3A4",
             @"calendar" : @"\U0001F4C5",
             @"flash" : @"\U000026A1",
             @"thunder-cloud" : @"\U000026C8",
             @"droplet" : @"\U0001F4A7",
             @"cd" : @"\U0001F4BF",
             @"briefcase" : @"\U0001F4BC",
             @"air" : @"\U0001F4A8",
             @"hourglass" : @"\U000023F3",
             @"gauge" : @"\U0001F6C7",
             @"language" : @"\U0001F394",
             @"network" : @"\U0000E776",
             @"key" : @"\U0001F511",
             @"battery" : @"\U0001F50B",
             @"bucket" : @"\U0001F4FE",
             @"magnet" : @"\U0000E7A1",
             @"drive" : @"\U0001F4FD",
             @"cup" : @"\U00002615",
             @"rocket" : @"\U0001F680",
             @"brush" : @"\U0000E79A",
             @"suitcase" : @"\U0001F6C6",
             @"traffic-cone" : @"\U0001F6C8",
             @"globe" : @"\U0001F30E",
             @"keyboard" : @"\U00002328",
             @"browser" : @"\U0000E74E",
             @"publish" : @"\U0000E74D",
             @"progress-3" : @"\U0000E76B",
             @"progress-2" : @"\U0000E76A",
             @"progress-1" : @"\U0000E769",
             @"progress-0" : @"\U0000E768",
             @"light-down" : @"\U0001F505",
             @"light-up" : @"\U0001F506",
             @"adjust" : @"\U000025D1",
             @"code" : @"\U0000E714",
             @"monitor" : @"\U0001F4BB",
             @"infinity" : @"\U0000221E",
             @"light-bulb" : @"\U0001F4A1",
             @"credit-card" : @"\U0001F4B3",
             @"database" : @"\U0001F4F8",
             @"voicemail" : @"\U00002707",
             @"clipboard" : @"\U0001F4CB",
             @"cart" : @"\U0000E73D",
             @"box" : @"\U0001F4E6",
             @"ticket" : @"\U0001F3AB",
             @"rss" : @"\U0000E73A",
             @"signal" : @"\U0001F4F6",
             @"thermometer" : @"\U0001F4FF",
             @"water" : @"\U0001F4A6",
             @"sweden" : @"\U0000F601",
             @"line-graph" : @"\U0001F4C8",
             @"pie-chart" : @"\U000025F4",
             @"bar-graph" : @"\U0001F4CA",
             @"area-graph" : @"\U0001F53E",
             @"lock" : @"\U0001F512",
             @"lock-open" : @"\U0001F513",
             @"logout" : @"\U0000E741",
             @"login" : @"\U0000E740",
             @"check" : @"\U00002713",
             @"cross" : @"\U0000274C",
             @"squared-minus" : @"\U0000229F",
             @"squared-plus" : @"\U0000229E",
             @"squared-cross"  : @"\U0000274E ",
             @"circled-minus" : @"\U00002296",
             @"circled-plus" : @"\U00002295",
             @"circled-cross" : @"\U00002716",
             @"minus" : @"\U00002796",
             @"plus" : @"\U00002795",
             @"erase" : @"\U0000232B",
             @"block" : @"\U0001F6AB",
             @"info" : @"\U00002139",
             @"circled-info" : @"\U0000E705",
             @"help" : @"\U00002753",
             @"circled-help" : @"\U0000E704",
             @"warning" : @"\U000026A0",
             @"cycle" : @"\U0001F504",
             @"cw" : @"\U000027F3",
             @"ccw" : @"\U000027F2",
             @"shuffle" : @"\U0001F500",
             @"back" : @"\U0001F519",
             @"level-down" : @"\U000021B3",
             @"retweet" : @"\U0000E717",
             @"loop" : @"\U0001F501",
             @"back-in-time" : @"\U0000E771",
             @"level-up" : @"\U000021B0",
             @"switch" : @"\U000021C6",
             @"numbered-list" : @"\U0000E005",
             @"add-to-list" : @"\U0000E003",
             @"layout" : @"\U0000268F",
             @"list" : @"\U00002630",
             @"text-doc" : @"\U0001F4C4",
             @"text-doc-inverted" : @"\U0000E731",
             @"doc" : @"\U0000E730",
             @"docs" : @"\U0000E736",
             @"landscape-doc" : @"\U0000E737",
             @"picture" : @"\U0001F304",
             @"video" : @"\U0001F3AC",
             @"music" : @"\U0001F3B5",
             @"folder" : @"\U0001F4C1",
             @"archive" : @"\U0000E800",
             @"trash" : @"\U0000E729",
             @"upload" : @"\U0001F4E4",
             @"download" : @"\U0001F4E5",
             @"save" : @"\U0001F4BE",
             @"install" : @"\U0000E778",
             @"cloud" : @"\U00002601",
             @"upload-cloud" : @"\U0000E711",
             @"bookmark" : @"\U0001F516",
             @"bookmarks" : @"\U0001F4D1",
             @"open-book" : @"\U0001F4D6",
             @"play" : @"\U000025B6",
             @"paus" : @"\U00002016",
             @"record" : @"\U000025CF",
             @"stop" : @"\U000025A0",
             @"ff" : @"\U000023E9",
             @"fb" : @"\U000023EA",
             @"to-start" : @"\U000023EE",
             @"to-end" : @"\U000023ED",
             @"resize-full" : @"\U0000E744",
             @"resize-small" : @"\U0000E746",
             @"volume" : @"\U000023F7",
             @"sound" : @"\U0001F50A",
             @"mute" : @"\U0001F507",
             @"flow-cascade" : @"\U0001F568",
             @"flow-branch" : @"\U0001F569",
             @"flow-tree" : @"\U0001F56A",
             @"flow-line" : @"\U0001F56B",
             @"flow-parallel" : @"\U0001F56C",
             @"left-bold" : @"\U0000E4AD",
             @"down-bold" : @"\U0000E4B0",
             @"up-bold" : @"\U0000E4AF",
             @"right-bold" : @"\U0000E4AE",
             @"left" : @"\U00002B05",
             @"down" : @"\U00002B07",
             @"up" : @"\U00002B06",
             @"right" : @"\U000027A1",
             @"circled-left" : @"\U0000E759",
             @"circled-down" : @"\U0000E758",
             @"circled-up" : @"\U0000E75B",
             @"circled-right" : @"\U0000E75A",
             @"triangle-left" : @"\U000025C2",
             @"triangle-down" : @"\U000025BE",
             @"triangle-up" : @"\U000025B4",
             @"triangle-right" : @"\U000025B8",
             @"chevron-left" : @"\U0000E75D",
             @"chevron-down" : @"\U0000E75C",
             @"chevron-up" : @"\U0000E75F",
             @"chevron-right" : @"\U0000E75E",
             @"chevron-small-left" : @"\U0000E761",
             @"chevron-small-down" : @"\U0000E760",
             @"chevron-small-up" : @"\U0000E763",
             @"chevron-small-right" : @"\U0000E762",
             @"chevron-thin-left" : @"\U0000E765",
             @"chevron-thin-down" : @"\U0000E764",
             @"chevron-thin-up" : @"\U0000E767",
             @"chevron-thin-right" : @"\U0000E766",
             @"left-thin" : @"\U00002190",
             @"down-thin" : @"\U00002193",
             @"up-thin" : @"\U00002191",
             @"right-thin" : @"\U00002192",
             @"arrow-combo" : @"\U0000E74F",
             @"three-dots" : @"\U000023F6",
             @"two-dots" : @"\U000023F5",
             @"dot" : @"\U000023F4",
             @"cc" : @"\U0001F545",
             @"cc-by" : @"\U0001F546",
             @"cc-nc" : @"\U0001F547",
             @"cc-nc-eu" : @"\U0001F548",
             @"cc-nc-jp" : @"\U0001F549",
             @"cc-sa" : @"\U0001F54A",
             @"cc-nd" : @"\U0001F54B",
             @"cc-pd" : @"\U0001F54C",
             @"cc-zero" : @"\U0001F54D",
             @"cc-share" : @"\U0001F54E",
             @"cc-remix" : @"\U0001F54F",
             @"db-logo" : @"\U0001F5F9",
             @"db-shape" : @"\U0001F5FA"
             };
}



#pragma mark - Accessors
#pragma mark - color
-(void) setColor:(UIColor *)color
{
    _color = color;
    _label.textColor = _color;
}

-(void) setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    _label.selectedTextColor = _selectedColor;
}

#pragma mark - shadow
-(void) setShadow:(ABShadowType)shadow
{
    _shadow = shadow;
    [_label setShadow:_shadow];
}

#pragma mark - shadowColor
-(void) setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    _label.shadowColor = _shadowColor;
}

@end
