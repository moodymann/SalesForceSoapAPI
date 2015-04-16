//
//  WebServiceUtil.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceUtil : NSObject

+(void)appendDateParameterElementWithSoapparam:(NSMutableString *) soapParam key:(NSString *) key value:(NSDate *) value;
+(void)appendIntegerParameterElementWithSoapparam:(NSMutableString *) soapParam key:(NSString *) key value:(NSInteger) value;
+(void)appendStringParameterElementWithSoapparam:(NSMutableString *) soapParam key:(NSString *) key value:(NSString *) value;
+(void)appendSessionHeader:(NSMutableString *)soapParam sessionHeader:(NSString *)sessionHeader;
@end
