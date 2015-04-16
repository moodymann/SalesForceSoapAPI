//
//  WebServiceUtil.m
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "WebServiceUtil.h"

@implementation WebServiceUtil

+ (void)appendDateParameterElementWithSoapparam:(NSMutableString *)soapParam key:(NSString *)key value:(NSDate *)value
{
    if (value) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];         //  フォーマット作成
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"jp_JP"];   //  ロケール作成
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [df setLocale:locale];                                                      //  ロケール設定
        [df setCalendar:calendar];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];                                //  フォーマット
#ifdef DEBUG
        NSLog(@"%@", [df stringFromDate:value]);
#endif
        [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:key value:[df stringFromDate:value]];
    }
}

+ (void)appendIntegerParameterElementWithSoapparam:(NSMutableString *)soapParam key:(NSString *)key value:(NSInteger)value
{
    if (value) {
        [soapParam appendFormat:@"<%@>%ld</%@>", key, (long)value, key];
    }
}

+ (void)appendStringParameterElementWithSoapparam:(NSMutableString *)soapParam key:(NSString *)key value:(NSString *)value
{
    [WebServiceUtil appendStringParameterElementWithSoapparam:soapParam key:key value:value enableEmpty:NO];
}

+ (void)appendStringParameterElementWithSoapparam:(NSMutableString *)soapParam key:(NSString *)key value:(NSString *)value enableEmpty:(BOOL)enableEmpty
{
    if (enableEmpty) {
        if (value) {
            [soapParam appendFormat:@"<%@>%@</%@>", key, value, key];
        } else {
            [soapParam appendFormat:@"<%@></%@>", key, key];
        }
    } else {
        if (value) {
            [soapParam appendFormat:@"<%@>%@</%@>", key, value, key];
        }
    }
}

+(void)appendSessionHeader:(NSMutableString *)soapParam sessionHeader:(NSString *)sessionHeader
{
    if (sessionHeader) {
        [soapParam appendFormat:@"<soap:Header>"];
        [soapParam appendFormat:@"<urn:SessionHeader><urn:sessionId>%@</urn:sessionId></urn:SessionHeader>", sessionHeader];
        [soapParam appendFormat:@"</soap:Header>"];
    }

}
@end
