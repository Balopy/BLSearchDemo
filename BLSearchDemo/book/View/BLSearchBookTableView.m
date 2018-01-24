//
//  BLSearchBookTableView.m
//  OilReading
//
//  Created by Balopy on 2018/1/12.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "BLSearchBookTableView.h"
#import "BLSearhBookTableViewCell.h"

@interface BLSearchBookTableView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, assign) BOOL searching;


@end


@implementation BLSearchBookTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
       
        self.delegate = self;
        self.dataSource = self;
      
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (void) dataSourceArray:(NSArray *)dataArray searching:(BOOL)searching text:(NSString *)text {
    self.results = dataArray;
    self.searching = searching;
    self.searchText = text;
    [self reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BLSearhBookTableViewCell *cell = [BLSearhBookTableViewCell searchBookCellWithTabView:tableView];
    BLSearchBookListModel *model = self.results[indexPath.row];

    model.searching = self.searching;
    model.searchText = self.searchText;
    
    cell.model = model;
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90+2*16;
}
@end

