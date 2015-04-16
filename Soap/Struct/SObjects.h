//
//  SObjects.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "BaseMasterVO.h"

@interface SObjects : BaseMasterVO
{
    NSMutableArray *sObjectList;
}

@property(nonatomic, retain)NSMutableArray *sObjectList;

@end
