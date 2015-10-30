//
//  FileManager.h
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/5/2.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(NSString *)getDocumentPath;

+(NSString *)getResourcePath;

+(NSString *)getFullDocumentPath:(NSString *)relativePath;

+(NSString *)getFullResoucePath:(NSString *)relativePath;

+(NSString *)readUtf8StringWithFilePath:(NSString *)path;

+ (long long)fileSizeAtPath:(NSString*)filePath;
+ (long long)folderSizeAtPath:(NSString*)folderPath;

@end
