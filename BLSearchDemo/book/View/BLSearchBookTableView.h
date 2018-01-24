//
//  BLSearchBookTableView.h
//  OilReading
//
//  Created by Balopy on 2018/1/12.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSearchBookTableView : UITableView

- (void) dataSourceArray:(NSArray *)dataArray searching:(BOOL)searching text:(NSString *)text;

@end
