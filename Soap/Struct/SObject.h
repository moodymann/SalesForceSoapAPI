//
//  SObject.h
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "BaseMasterVO.h"

@interface SObject : BaseMasterVO
{
}

@property(nonatomic, retain) NSString *autoNumber;
@property(nonatomic, retain) NSString *label;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *nameField;
@property(nonatomic, retain) NSString *digits;
@property(nonatomic, retain) NSString *precision;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *calculated;
@property(nonatomic, retain) NSString *length;
@property(nonatomic, retain) NSString *byteLength;
@property(nonatomic, retain) NSString *restrictedPickList;
@property(nonatomic, retain) NSString *scale;
@property(nonatomic, retain) NSString *namePointing;
@property(nonatomic, retain) NSString *createble;
@property(nonatomic, retain) NSString *defaultedoncreate;
@property(nonatomic, retain) NSString *sortable;
@property(nonatomic, retain) NSString *custom;
@property(nonatomic, retain) NSMutableArray *pickListvalues;

@end
