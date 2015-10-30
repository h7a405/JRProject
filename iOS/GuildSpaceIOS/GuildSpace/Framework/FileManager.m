//
//  FileManager.m
//  GuildSpace
//
//  Created by Chanel.Cheng on 15/5/2.
//  Copyright (c) 2015年 Chanel.Cheng. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+(NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+(NSString *)getResourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+(NSString *)getFullDocumentPath:(NSString *)relativePath
{
    return [NSString stringWithFormat:@"%@/%@",[FileManager getDocumentPath],relativePath];
}

+(NSString *)getFullResoucePath:(NSString *)relativePath
{
    return [NSString stringWithFormat:@"%@/%@",[FileManager getResourcePath],relativePath];
}

+(NSString *)readUtf8StringWithFilePath:(NSString *)path
{
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        NSLog(@"Error: %@", error.description);
        return @"";
    }
    return str;
}

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*)filePath
{
//    struct stat st;
//    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
//        return st.st_size;
//    }
    return 0;
}

//遍历文件夹获得文件夹大小
+ (long long)folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [FileManager fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize;
}

@end
