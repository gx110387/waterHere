//
//  URLHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里是URL信息

#ifndef Project_URLHeader_h
#define Project_URLHeader_h
//-----------------GGGGGGGGGGGG________________

#define G_DestinationURL @"http://api.breadtrip.com/destination/v3/?last_modified_since=0"
#define G_getJData @"http://api.breadtrip.com/destination/index_places/%ld/"

#define G_getMData @"http://api.breadtrip.com/destination/place/%@/%@/"

#define G_GetIData @"http://api.breadtrip.com/destination/place/5/%@/poi_trips/?start=%ld&count=%ld"
#define G_GetITripsData @"http://api.breadtrip.com/destination/place/5/%@/tips/?start=%ld&count=%ld"
//精品游记
#define G_GetTripTravle @"http://api.breadtrip.com/destination/place/%@/%@/trips/?start=%ld&count=%ld"
//旅行地点
#define G_GetTripsPosition @"http://api.breadtrip.com/destination/place/%@/%@/pois/all/?start=%ld&count=%ld"
///////-------------------HHHHHHHHH----------


// by hqx 15-1015 tourmain页面接口
#define TMURL @"http://api.breadtrip.com/v2/index/"

// by hqx 1017 story页面接口
#define TSURL @"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=0"

///////-----------------------CCCCCCCCCCCC_------------



#define CURL @"http://api.breadtrip.com/hunter/products/more/?city_name=%@&start=0"


#define C_getDataURL @"http://web.breadtrip.com/hunter/product/%ld/"


#endif
