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

#define HWSEONDDETAILT  @"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=1355295201&session_id=0000423d7ecd75af788f3763566472ed27f06e&v=4"




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

#endif /* UrlHeadersDefine_h */
