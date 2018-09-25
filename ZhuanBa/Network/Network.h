//
//  Network.h
//  ZhuanBa
//
//  Created by developer on 2018/9/1.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Network : NSObject
-(void)registeraccount:(NSString *)phone password:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)loginWithPhone:(NSString *)phone password:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)resetPwdPhone:(NSString *)phone passwrod:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))erro;
-(void)getphoneSaleinfo:(NSString *)phone success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
// 获取用户信息
-(void)getInfoPhone:(NSString *)phone success:(void (^)(id))data fail:(void (^)(NSError * error))error;
// 获取用户头像
-(void)getUserHeaderInfo:(NSString *)phone success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)changeinfo:(NSString *)phone parmars:(NSDictionary *)parmars headImage:(NSData *)headData success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
// 修改用户的统计数据
-(void)personScalesuccess:(NSString *)phone countDay:(NSString *)countday saleDay:(NSString *)saleDay countMonth:(NSString *)montcount saleMonth:(NSString *)monthSale countTotal:(NSString *)counttotal saletotal:(NSString *)totalsale success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)getqiangDanTaskList:(NSString *)phone paidancity:(NSString *)city type:(int)type  success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)getqiangdanlist:(NSString *)phone paidancity:(NSString *)city type:(int)type  success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)getpaidanlist:(NSString *)phone  type:(int)type success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)getPaiDanDetail:(NSString *)phone tasknumber:(NSString *)tasknumber success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)getShareLink:(NSString *)phone success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)fabupaiDan:(NSString *)phone sourceAddress:(NSString *)sourAddr desAddress:(NSString *)desAddr taskDetail:(NSString *)taskdetail scale:(CGFloat)scale taskCity:(NSString *)city success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)qiangDanphone:(NSString * )phone tasknumber:(NSString * )tasknumber success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)confirmFinishTask:(NSString *)phone tasknumber:(NSString *)number success:(void (^)(id))data fail:(void (^)(NSError *))error;

-(void)confirmFinishPay:(NSString *)phone tasknumber:(NSString *)number success:(void (^)(id))data fail:(void (^)(NSError *))error;
-(void)submit:(NSString *)phone Content:(NSString *)content success:(void (^)(id data))data fail:(void (^)(NSError * error))error;
-(void)changInfoMation:(NSString *)phone headData:(NSData *)head parmars:(NSMutableDictionary *)parmar success:(void (^)(id))success fail:(void (^)(NSError *))error;
-(void)getNetworkLocation:(void (^)(NSString *))cityblock fail:(void (^)(NSError *))errorblock;
@end
