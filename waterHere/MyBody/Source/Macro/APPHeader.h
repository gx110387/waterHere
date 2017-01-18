//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h


//-------------controller--------------------

#define NavigationBarHight 64.0f

#define ImageHight 200.0f

#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define CustomerColorOfAlpha(r,g,b,x) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:x]
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
#define G_Iphone6(num) Adapt_IPHONE6_scaleV(num)

#define GHbgWhiteColor CustomerColor(241, 239, 245)

#define Tools [G_getDestinaData shareGetDestinData]

#define Toolshares                   [G_shareTools shareTools]

#define  gwidth  CGRectGetWidth(self.frame)
#define  gheight CGRectGetHeight(self.frame)
#define  G_picholder [UIImage imageNamed:@"picholder"]
///30
#define  kFontSize   Tools.cgkFontSize
///35
#define  kStarWidthAndHeight Tools.cgkStarWidthAndHeight

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#if DEBUG
#define DoLog(...)  NSLog(__VA_ARGS__)
#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define DoLog(...)
#define DDLog(xx, ...)

#endif
#import "AlertShow.h"
 

#import "ActivityMainController.h"

#import "DestinationMainController.h"

#import "TakeMainViewController.h"

#import "TourMainViewController.h"

#import "UserMainViewController.h"

#import "CollectionViewController.h"


#import "UserMainViewController.h"

#import "DestinationDailViewController.h"

#import "DestinationTripsViewController.h"

 

#import "DestinationSectionViewController.h"

#import "DesWebViewController.h"

#import "DesTripsSectionFirstTableViewController.h"

#import "DesTripsSectionSecondTableViewController.h"

#import "SettingTableViewController.h"


#import "restartPsdViewController.h"

 

#import "AboutUsViewController.h"

///---------



//-------------------View--------------------

#import "HeadtitleView.h"

#import "MainTableViewCell.h"

#import "CollectionViewCell.h"

#import "SectionZeroTableViewCell.h"

#import "TripsTableViewCell.h"

#import "MyCollectionViewCell.h"

#import "Trips2TableViewCell.h"

#import "DesTripsSectionFirstTableViewCell.h"

#import "DesTripsSectonSecondTableViewCell.h"

#import "UserView.h"

#import "restartPsdView.h"

//-----------------------Model----------------
#import "DestinationModel.h"

#import "G_waypointsModel.h"

#import "recommendedModel.h"

#import "TripModel.h"

#import "TripsModel.h"

#import "DestirpsSectionFirst.h"

#import "UserLoginModel.h"

#import "FirstCollectionModel.h"

//---------------baseClass ---------------
#import "G_getDestinaData.h"




#import "G_shareTools.h"



//-------------------------HHHHH-------------------------


//-------------controller--------------------




#import "ActivityMainController.h"

#import "DestinationMainController.h"

#import "TakeMainViewController.h"

#import "TourMainViewController.h"

#import "UserMainViewController.h"

#import "CollectionViewController.h"


#import "UserMainViewController.h"

#import "DestinationDailViewController.h"

#import "ActivityTableViewController.h"

#import "SecendTableViewController.h"

#import "ThirdTableViewController.h"

#import "FourTableViewController.h"

#import "FiveTableViewController.h"

#import "SixTableViewController.h"

#import "TourMainViewController.h"

#import "StoryCollectionViewController.h"

#import "StoryDetialViewController.h"

#import "TourTravelViewController.h"

#import "WebViewController.h"
#import "ViewController.h"
//-------------------View--------------------

#import "HeadtitleView.h"

#import "MainTableViewCell.h"

#import "CollectionViewCell.h"

#import "CollectionViewCell1.h"

#import "SectionZeroTableViewCell.h"

#import "ActivityTableViewCell.h"

#import "TourMainView.h"

#import "TourStoryTableViewCell.h"

#import "TourTravelTableViewCell.h"

#import "TourStoryCollectionViewCell.h"

#import "TravelTableViewCell.h"

#import "TourTravelView.h"

#import "StoryDitialView.h"

#import "StoryDetialTableViewCell.h"

//-----------------------Model----------------
#import "DestinationModel.h"

#import "NearModel.h"

#import "StoryModel.h"

#import "TravelNoteModel.h"

#import "UserModel.h"

#import "PositionModel.h"

#import "TourDataTool.h"

#import "StoryTripModel.h"

#import "Detail_listModel.h"

#import "TravrlDayModel.h"

#import "WayPointsModel.h"

#import "BannersModel.h"
//---------------baseClass ---------------
#import "G_getDestinaData.h"


#pragma mark by hqx



#define pich  @"picholder.png"



#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)

#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//-------------------------HHHHH-------------------------
//////////------------ccccccccc---------

#import "Product.h"

#import "ProductViewController.h"


#import "TakeTableViewCell.h"

























//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
