//
//  NSString+Encode.m
//  Excel2Plist
//
//  Created by Minghu Hu on 11/12/21.
//  Copyright (c) 2011年 sf-sky. All rights reserved.
//

#import "NSString+Encode.h"
#import "GTMBase64.h"

@implementation NSString(Encode)

- (NSString *)encodedString
{
    return [NSString encodeString:self];
}
- (NSString *)decodedString
{
    return [NSString decodeString:self];
}

+ (NSString *)encodeString:(NSString *)stringToEncode
{
    NSData    *data       = [stringToEncode dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodingStr = [GTMBase64 stringByEncodingData:data];
    return encodingStr;
}

+ (NSString *)decodeString:(NSString *)stringToDecode
{
    NSData   *newData = [GTMBase64 decodeString:stringToDecode];
    NSString *newStr  = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
    return newStr;;
}

@end
