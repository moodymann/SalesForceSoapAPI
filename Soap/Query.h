//
//  Query.h
//  Soap
//
//  Created by isid on 2015/04/06.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Query : NSObject
{
    NSMutableArray *result;
    NSMutableArray *sortOrder;
}
@property (nonatomic, retain)NSMutableArray *result;
@property (nonatomic, retain)NSMutableArray *sortOrder;

@end
