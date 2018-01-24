//
//  BLSeachBookViewController.m
//  OilReading
//
//  Created by Balopy on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "BLSeachBookViewController.h"
#import "BLSeachBarView.h"
#import "BLSearchBookTableView.h"
#import "BLSearchBookListModel.h"


@interface BLSeachBookViewController ()

/*!  searchBar  */
@property (nonatomic, weak) BLSeachBarView *searchBar;
/**< 搜索范围 */
@property (nonatomic, strong) NSMutableArray *rangeOfSearchData;

/**< 搜索结果 */
@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic, weak) BLSearchBookTableView *tableView;

@end

@implementation BLSeachBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createSubViews {
    
    CGRect frame = (CGRect){CGPointZero, {kScreen_width-4*Spacing15, 2*Spacing15}};
    
    BLSeachBarView *searchBar = [[BLSeachBarView alloc] initWithFrame:frame];
    searchBar.searchBarLeftImage = @"图书_首页_搜索";
    searchBar.searchBar.background = MMIMAGENAMED(@"图书_搜索结果_搜索背景");
    [searchBar footerIconName:nil title:@"搜索" color:[UIColor blackColor]];
    [searchBar footerSelectedTitle:@"取消" selectedColor:nil];
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    BLSearchBookTableView *tableView = [[BLSearchBookTableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    MJWeakSelf
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(Spacing10);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
    
    self.rangeOfSearchData = @[].mutableCopy;
    self.searchResults = @[].mutableCopy;
    
    NSArray *temp = @[@"中国石油212123", @"中国电信324322", @"中南海324536", @"中海油234290", @"中国电信324322", @"中南海324536", @"中海油234290", @"中国电信324322", @"中南海324536", @"中海油234290", @"中国电信324322", @"中南海324536", @"中海油234290"];
    for (NSUInteger i = 0; i < temp.count; i ++) {
        
        BLSearchBookListModel *model = [BLSearchBookListModel new];
        model.price = arc4random()%1000;
        model.title = temp[i];
        model.txtAttributed = [[NSAttributedString alloc] initWithString:model.title];
        model.expertName = @"王教授";
        model.rankName = @"石油专家";
        model.courseNumber = arc4random()%20;
        model.alreadyBuyNum = arc4random()%1000;
        [self.rangeOfSearchData addObject:model];
    }
    
    [self searchEventMethod];
}


/*! 匹配选中文字, 将包含文字的数据放到数组中*/
- (void)searchEventMethod {
    
    [self.tableView dataSourceArray:self.rangeOfSearchData searching:NO text:nil];;
    MJWeakSelf
    self.searchBar.textChangeBlock = ^(id object, id varities) {
        
        if (varities && [varities length]) {
            
            NSMutableArray *tempArr = @[].mutableCopy;
          
            for (BLSearchBookListModel *temp in self.rangeOfSearchData) {

                if ([temp.title containsString:varities]) {
                   
                    [tempArr addObject:temp];
                }
            }
            self.searchResults = [tempArr mutableCopy];
            
        } else {
            
            [weakSelf.tableView dataSourceArray:weakSelf.rangeOfSearchData searching:NO text:varities];
        }
    };
    
    self.searchBar.searchEventBlock = ^(id object, id varities) {
        
        if ([varities boolValue]) {
            
            [weakSelf.tableView dataSourceArray:weakSelf.searchResults searching:YES text:object];
        } else {
            
            [weakSelf.tableView dataSourceArray:weakSelf.rangeOfSearchData searching:NO text:object];
        }
    };
}


@end
