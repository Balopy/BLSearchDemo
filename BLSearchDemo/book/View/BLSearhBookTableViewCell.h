//
//  BLSearhBookTableViewCell.h
//  OilReading
//
//  Created by Balopy on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLSearchBookListModel.h"

@interface BLSearhBookTableViewCell : UITableViewCell

+ (instancetype) searchBookCellWithTabView:(UITableView *)tableView;

@property (nonatomic, strong) BLSearchBookListModel *model;


@end
