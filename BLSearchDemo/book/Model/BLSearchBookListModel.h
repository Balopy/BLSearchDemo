//
//  BLSearchBookListModel.h
//  OilReading
//
//  Created by Balopy on 2018/1/12.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSearchBookListModel : NSObject

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, copy) NSString *mobileUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *expertName;
@property (nonatomic, copy) NSString *rankName;

@property (nonatomic, assign) int courseNumber;
@property (nonatomic, assign) int alreadyBuyNum;
@property (nonatomic, assign) float price;

/*! 搜索结果时用 */
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, copy) NSAttributedString *txtAttributed;
@property (nonatomic, assign) BOOL searching;


@end
