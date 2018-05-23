//
//  SSkeyChainTesst.m
//  SwiftTest
//
//  Created by shanbay410 on 2018/5/23.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

#import "SSkeyChainTesst.h"
#import "SSKeychain.h"

#define SERVERNAME @"MyServer"

@implementation SSkeyChainTesst

//存储password
+ (BOOL)storeYourPassword:(NSString *)password{
    NSError * error = nil;
    [SSKeychain setPassword:password forService:SERVERNAME account:@"user" error:&error];
    if([error code] == SSKeychainErrorInteractionNotAllowed){
        return NO;
    }else{
        return YES;
    }
}
//读取password
+ (NSString *)readYourpassword{
    NSError * error = nil;
    NSString * password = [SSKeychain passwordForService:SERVERNAME account:@"user" error:&error];
    if([error code] == SSKeychainErrorNotFound){
        return nil;
    }
    return password;
}

@end
