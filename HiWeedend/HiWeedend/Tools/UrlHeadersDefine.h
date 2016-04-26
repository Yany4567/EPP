//
//  UrlHeadersDefine.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#ifndef UrlHeadersDefine_h
#define UrlHeadersDefine_h
//	首页定位接口地址

#define HWPOSITIONING  @"http://api.lanrenzhoumo.com/other/common/location/?"


//首页列表接口地址

#define HWHOMEPAGE    @"http://api.lanrenzhoumo.com/main/recommend/index/?"


//第一张图片点击后列表接口地址

#define HWFIRSTIMAGE   @"http://api.lanrenzhoumo.com/market/event/index/?id=371&lat=39.90855&lon=116.3975&page=1&session_id=0000423d7ecd75af788f3763566472ed27f06e"

//再点击详细内容地址接口

#define HWFIRSTDETAILT  @"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=1353246609&session_id=0000423d7ecd75af788f3763566472ed27f06e&v=4"

//第二个图片接口

#define HWSECONEIMAGE   @"http://api.lanrenzhoumo.com/market/event/index/?id=358&lat=39.90855&lon=116.3975&page=1&session_id=0000423d7ecd75af788f3763566472ed27f06e"

//再点击详细内容地址接口

#define HWSEONDDETAILT  @"http://api.lanrenzhoumo.com/wh/common/leo_detail?"




//点击详细列表接口地址

#define HWDETAILT       @"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=1355286404&session_id=0000423d7ecd75af788f3763566472ed27f06e&v=4"




//收藏接口

#define HWCOLLECTION   @"http://api.lanrenzhoumo.com/user/common/get_user_collect/?page=1&session_id=0000423d7ecd75af788f3763566472ed27f06e"


//我的预定

#define HWRESERVATION  @"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=1355286404&session_id=0000423d7ecd75af788f3763566472ed27f06e&v=4"

// 收藏button接口

#define HWCOLLECTIONBUTTON @"http://api.lanrenzhoumo.com/user/common/add_user_collect"


// 取消收藏接口
#define HWCANCEL       @"http://api.lanrenzhoumo.com/user/common/delete_user_collect"




#pragma mark ============/兴趣爱好接口========

//点击城市后
#define OncolickCity @"http://api.lanrenzhoumo.com/main/recommend/index/?city_id=321&lat=39.90854&lon=116.3975&page=1&session_id=000042eead60e2f01f344af95d0e75d9050867&v=3"

//户外
#define Outdoors @"http://api.lanrenzhoumo.com/wh/common/leos?category=outdoor&city_id=53&keyword=&lat=40.02932&lon=116.3376&page=1&session_id=000042eead60e2f01f344af95d0e75d9050867"
//剧场
#define Theatre @"http://api.lanrenzhoumo.com/wh/common/leos?category=music&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"

//手工
#define DIY @"http://api.lanrenzhoumo.com/wh/common/leos?category=food&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"
//聚会
#define  Meeting @"http://api.lanrenzhoumo.com/wh/common/leos?category=party&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"

//健身
#define Health  @"http://api.lanrenzhoumo.com/wh/common/leos?category=sport&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"

//文艺
#define  Literature  @"http://api.lanrenzhoumo.com/wh/common/leos?category=charity&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"

//学堂
#define School @"http://api.lanrenzhoumo.com/wh/common/leos?category=others&city_id=53&keyword=&lat=40.0294&lon=116.3375&page=1&session_id=000042c8e69cff884054bb4ccd6352be417c1d"

//茶会
#define Tea @"http://api.lanrenzhoumo.com/wh/common/leos?category=ch-yj&city_id=321&keyword=&lat=39.90854&lon=116.3975&page=1&session_id=000042eead60e2f01f344af95d0e75d9050867"
//城市列表
#define CityList  @"http://api.lanrenzhoumo.com/district/list/allcity?session_id=000042eead60e2f01f344af95d0e75d9050867"



#endif /* UrlHeadersDefine_h */
