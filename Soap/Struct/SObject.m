//
//  SObject.m
//  Soap
//
//  Created by isid on 2015/03/16.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import "SObject.h"

@implementation SObject

@synthesize autoNumber;
@synthesize label;
@synthesize name;
@synthesize nameField;
@synthesize digits;
@synthesize precision;
@synthesize type;
@synthesize calculated;
@synthesize length;
@synthesize byteLength;
@synthesize restrictedPickList;
@synthesize scale;
@synthesize namePointing;
@synthesize createble;
@synthesize defaultedoncreate;
@synthesize sortable;
@synthesize custom;

/*******************************************************************************
 *  init
 *  初期処理
 */
- (id)init
{
    if ((self = [super init])) {
    }
	return self;
}

@end
