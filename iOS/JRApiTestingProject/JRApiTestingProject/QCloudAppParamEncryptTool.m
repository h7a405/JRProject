//
//  QCloudAppParamEncryptTool.m
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 25/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

#import "QCloudAppParamEncryptTool.h"

@interface QCloudAppParamEncrptTool() {
    NSArray * charArray;
}

@end

@implementation QCloudAppParamEncrptTool

- (NSString *)signParamWithString:(NSString *)stringToSign andKey:(NSString *)keyToSign {
    if ([stringToSign isEqualToString:@""]) {
        return @"";
    }
    if ([keyToSign isEqualToString:@""]) {
        return [self encryptToMD5WithString:stringToSign];
    }
    return [self encryptToMD5WithString:[NSString stringWithFormat:@"%@@%@", stringToSign, keyToSign]];
}

- (Boolean)decryptParamWithString:(NSString *)stringToDecrypt {
    if ([stringToDecrypt isEqualToString:@""]) {
        return NO;
    }
    if (stringToDecrypt.length != 24) {
        return NO;
    }
    
    char first = [stringToDecrypt characterAtIndex:0];
    int firstIndex = [self getCharIndexWithChar:first];
    if (firstIndex == -1 || firstIndex > 23) {
        return NO;
    }
    
    char s = [stringToDecrypt characterAtIndex:firstIndex];
    int sIndex = [self getCharIndexWithChar:s];
    if (sIndex == -1 || sIndex > 23) {
        return NO;
    }
    
    int sum = first + s;
    int j = firstIndex + 1;
    for (int index = 0; index < 11; index++) {
        int nextIndex = j > 23 ? (j) % 23 : j;
        int anotherNextIndex = nextIndex + 11 > 23 ? (nextIndex + 11) % 23 : nextIndex + 11;
        char c1 = [stringToDecrypt characterAtIndex:nextIndex];
        char c2 = [stringToDecrypt characterAtIndex:anotherNextIndex];
        NSNumber * aNumber = [self.charArray objectAtIndex:(c1 + sum + index) % 25];
        char c3 = [aNumber charValue];
        if (c2 != c3) {
            return NO;
        }
        j++;
    }
    return YES;
}

- (NSString *)requestRandomEncryptedString {
    NSMutableArray * ca = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        [ca addObject:[NSNumber numberWithChar:'A']];
    }
    int index = arc4random_uniform(23) + 1;
    int anotherIndex = arc4random_uniform(24);
    ca[0] = (NSNumber *)[self.charArray objectAtIndex:index];
    ca[index] = (NSNumber *)[self.charArray objectAtIndex:anotherIndex];
    
    int j = index + 1;
    int sum = [(NSNumber *)[ca objectAtIndex:0] intValue] + [(NSNumber *)[ca objectAtIndex:index] intValue];
    for (int i = 0; i < 11; i++) {
        int next = arc4random_uniform(26);
        int nextIndex = j > 23 ? (j) % 23 : j;
        int anotherNextIndex = nextIndex + 11 > 23 ? (nextIndex + 11) % 23 : nextIndex + 11;
        ca[nextIndex] = (NSNumber *)[self.charArray objectAtIndex:next];
        ca[anotherNextIndex] = (NSNumber *)[self.charArray objectAtIndex:([(NSNumber *)[ca objectAtIndex:nextIndex] intValue] + sum + i) % 25];
        j++;
    }
    NSMutableString * stringToReturn = [NSMutableString string];
    for (int i = 0; i < 24; i++) {
        [stringToReturn appendFormat:@"%c", [(NSNumber *)[ca objectAtIndex:i] charValue]];
    }
    return stringToReturn;
}

- (int) getCharIndexWithChar:(char) c {
    int charIndex = -1;
    for (int index = 0; index < self.charArray.count; index++) {
        if ([self.charArray objectAtIndex:index] == [NSNumber numberWithChar:c]) {
            charIndex = index;
            break;
        }
    }
    return charIndex;
}

- (NSString *)encryptToMD5WithString:(NSString *)stringToEncrypt {
    const char *cStr = [stringToEncrypt cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned int strLen = (unsigned int)[stringToEncrypt lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const int digestLen = CC_MD5_DIGEST_LENGTH;
    unsigned char result[digestLen];
    CC_MD5(cStr, strLen, result);
    NSMutableString *hash = [[NSMutableString alloc]init];
    for (int i = 0; i < digestLen; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return [NSString stringWithString:hash];
}

- (NSArray *)charArray {
    if (charArray == nil) {
        NSMutableArray * tempArray = [NSMutableArray array];
        NSString * stringOfAlphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (int i = 0; i < stringOfAlphabet.length; i++) {
            [tempArray addObject:[NSNumber numberWithChar:[stringOfAlphabet characterAtIndex:i]]];
        }
        charArray = [NSArray arrayWithArray:tempArray];
    }
    return charArray;
}

@end
