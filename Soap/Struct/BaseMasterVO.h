//
//  BaseMasterVO.h
//  Soap
//
//  Created by isid on 2015/03/13.
//  Copyright (c) 2015年 isid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMasterVO : NSObject
{
@private
    NSString            *validFlag;                                     //  有効フラグ
    NSString            *createUserId;                                  //  作成者ID
    NSDate              *createDate;                                    //  作成日
    NSString            *updateUserId;                                  //  更新者ID
    NSDate              *updateDate;                                    //  更新日時
    NSString            *updateType;                                    //  更新種別（1:新規, 2:更新, 3:削除）
    
}

@property (nonatomic, retain)NSString            *validFlag;
@property (nonatomic, retain)NSString            *createUserId;
@property (nonatomic, retain)NSDate              *createDate;
@property (nonatomic, retain)NSString            *updateUserId;
@property (nonatomic, retain)NSDate              *updateDate;
@property (nonatomic, retain)NSString            *updateType;

@end
