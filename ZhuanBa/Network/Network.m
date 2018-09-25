//
//  Network.m
//  ZhuanBa
//
//  Created by developer on 2018/9/1.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "Network.h"

//#define domain @"http://192.168.1.170/"
#define domain @"http://103.45.70.198:1000/"

@implementation Network
-(void)registeraccount:(NSString *)phone password:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
     NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",pwd,@"pwd", nil];
    [self sendRequest:@"register.php" parmarsDict:parmars success:data fail:error];
    
}
-(void)loginWithPhone:(NSString *)phone password:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary  dictionaryWithObjectsAndKeys:phone,@"phone",pwd,@"pwd", nil];
    [self sendRequest:@"login.php" parmarsDict:parmars success:data fail:error];
}
-(void)resetPwdPhone:(NSString *)phone passwrod:(NSString *)pwd success:(void (^)(id data))data fail:(void (^)(NSError * error))erro{
    
     NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",pwd,@"pwd", nil];
     [self sendRequest:@"resetpwd.php" parmarsDict:parmars success:data fail:erro];
    
}
-(void)getphoneSaleinfo:(NSString *)phone success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone", nil];
    [self sendRequest:@"phoneScale.php" parmarsDict:parmars success:data fail:error];
}
-(void)getInfoPhone:(NSString *)phone success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",phone,@"phone", nil];
    
    [self sendRequest:@"infomar.php" parmarsDict:dict success:data fail:error];
}
-(void)getUserHeaderInfo:(NSString *)phone success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",phone,@"phone", nil];
 
    [self sendRequest:@"infomar.php" parmarsDict:parmars success:data fail:error];
}
-(void)changeinfo:(NSString *)phone parmars:(NSDictionary *)parmars headImage:(NSData *)headData success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    [self changInfoMation:phone headData:headData parmars:parmars success:data fail:error];
}
-(void)personScalesuccess:(NSString *)phone countDay:(NSString *)countday saleDay:(NSString *)saleDay countMonth:(NSString *)montcount saleMonth:(NSString *)monthSale countTotal:(NSString *)counttotal saletotal:(NSString *)totalsale success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",countday,@"daycount",saleDay,@"dayscalecount",montcount,@"moncount",monthSale,@"monscalecount",counttotal,@"totalcount",totalsale,@"totalscalecount",@"type",@"type", nil];
    
    [self sendRequest:@"phoneScale.php"  parmarsDict:parmars success:data fail:error];
    
}
-(void)getqiangDanTaskList:(NSString *)phone paidancity:(NSString *)city type:(int)type  success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",city,@"city",@"1",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)getqiangdanlist:(NSString *)phone paidancity:(NSString *)city type:(int)type  success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",city,@"city",@"8",@"type", nil];
  
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)getpaidanlist:(NSString *)phone  type:(int)type success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",@"2",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)getPaiDanDetail:(NSString *)phone tasknumber:(NSString *)tasknumber success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",tasknumber,@"tasknumber",@"3",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)getShareLink:(NSString *)phone success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"sharelink", nil];
    
    [self sendRequest:@"opinion.php" parmarsDict:parmars success:data fail:error];
}
-(void)fabupaiDan:(NSString *)phone sourceAddress:(NSString *)sourAddr desAddress:(NSString *)desAddr taskDetail:(NSString *)taskdetail scale:(CGFloat)scale taskCity:(NSString *)city success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",sourAddr,@"sourceaddress",desAddr,@"desaddress",taskdetail,@"detail",[NSString stringWithFormat:@"%.f",scale],@"taskscale",city,@"city",@"4",@"type", nil];
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)qiangDanphone:(NSString * )phone tasknumber:(NSString * )tasknumber success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:tasknumber,@"tasknumber",phone,@"phone",@"5",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)confirmFinishTask:(NSString *)phone tasknumber:(NSString *)number success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",number,@"tasknumber",@"6",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}

-(void)confirmFinishPay:(NSString *)phone tasknumber:(NSString *)number success:(void (^)(id))data fail:(void (^)(NSError *))error{
    
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",number,@"tasknumber",@"7",@"type", nil];
    
    [self sendRequest:@"task.php" parmarsDict:parmars success:data fail:error];
}
-(void)submit:(NSString *)phone Content:(NSString *)content success:(void (^)(id data))data fail:(void (^)(NSError * error))error{
    
    NSDictionary * parmars = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",content,@"content", nil];
    
    [self sendRequest:@"opinion.php" parmarsDict:parmars success:data fail:error];
    
}
-(void)getNetworkLocation:(void (^)(NSString *))cityblock fail:(void (^)(NSError *))errorblock{
    
    
    NSString * str = @"http://2018.ip138.com/ic.asp";
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * task,NSData * data){
        
        
                NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
                NSString * returnStr = [[NSString alloc] initWithData:data encoding:encode];
    
        
                NSRange rangeOrginal = [returnStr rangeOfString:@"来自"];
                NSRange rangeDestion = [returnStr rangeOfString:@"</center>"];

                NSString * contentString = [returnStr substringWithRange:NSMakeRange(rangeOrginal.location + rangeOrginal.length, rangeDestion.location - rangeOrginal.location - rangeOrginal.length)];
        
                contentString = [contentString stringByReplacingOccurrencesOfString:@" " withString:@""];
                contentString = [contentString stringByReplacingOccurrencesOfString:@"：" withString:@""];
        
                cityblock(contentString);
        
            } failure:^(NSURLSessionDataTask * task,NSError * error){
                
                if (errorblock) {
                    
                    errorblock(error);
                }
                
    }];
    
}
-(void)changInfoMation:(NSString *)phone headData:(NSData *)head parmars:(NSDictionary *)parmar success:(void (^)(id))success fail:(void (^)(NSError *))errorblock{
    
    NSString * method = @"infomar.php";
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",domain,method]];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:url.absoluteString parameters:parmar constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        if (head) {
                                 
            [formData appendPartWithFileData:head name:@"head" fileName:@"head" mimeType:@"image/jpeg"];
        }
            
        
        } progress:nil success:^(NSURLSessionTask * task,NSData * data){
        
            id rest = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            success(rest);
            
        } failure:^(NSURLSessionDataTask * task,NSError * error){
        
        
            if (error) {
                
                errorblock(error);
            }
            
        
    }];
    
}
-(void)sendRequest:(NSString *)method parmarsDict:(NSDictionary *)parmars success:(void (^)(id returnData))successBlock fail:(void (^)(NSError * error))failBlock{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",domain,method]];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url.absoluteString parameters:parmars progress:^(NSProgress * progress){
     
        
    } success:^(NSURLSessionTask * task,NSData * data){
        
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dict) {
            successBlock(dict);
            
        }else{
            
            successBlock(data);
            
        }
    } failure:^(NSURLSessionTask * tasks,NSError * error){
        
        failBlock(error);
    }];
    
}
@end
