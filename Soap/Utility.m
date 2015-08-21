//
//  Utility.m
//  Soap
//
//  Created by isid on 2015/07/23.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)stringSafeForXML:(NSMutableString *)str
{
    NSRange all = NSMakeRange (0, [str length]);
    
    [str replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:all];
    [str replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:all];
    [str replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:all];
    [str replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:all];
    [str replaceOccurrencesOfString:@"'" withString:@"&apos;" options:NSLiteralSearch range:all];
    return str;
}
@end
