//
//  QCloudAppParamEncryptTool.h
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 25/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

#ifndef JingJianLogistics_iOS_QCloudAppParamEncryptTool_h
#define JingJianLogistics_iOS_QCloudAppParamEncryptTool_h


#endif

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface QCloudAppParamEncrptTool : NSObject

- (NSString *) signParamWithString:(NSString *)stringToSign andKey:(NSString *)keyToSign;
- (Boolean) decryptParamWithString:(NSString *)stringToDecrypt;
- (NSString *) requestRandomEncryptedString;

@end