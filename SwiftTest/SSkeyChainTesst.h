//
//  SSkeyChainTesst.h
//  SwiftTest
//
//  Created by shanbay410 on 2018/5/23.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSkeyChainTesst : NSObject
//存储password
+ (BOOL)storeYourPassword:(NSString *)password;
//读取数据
+ (NSString *)readYourpassword;
@end
