//
//  BLSeachBarView.m
//  OilReading
//
//  Created by Balopy on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "BLSeachBarView.h"

@interface BLSeachBarView ()

@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UIButton *rightButton;


@end
@implementation BLSeachBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITextField *searchBar = [[UITextField alloc] init];
        searchBar.delegate = self;
        searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchBar.backgroundColor = [UIColor colorNamed:@"0xf3f5f7"];
        searchBar.placeholder = @"请输入内容";
        searchBar.keyboardType = UIKeyboardTypeWebSearch;
        searchBar.frame = CGRectMake(5, 0, CGRectGetWidth(frame)-2*5, CGRectGetHeight(frame));
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    return self;
}



- (void)inputTextChange:(NSNotification *)notify {
    
    NSUInteger result = self.searchBar.text.length;
    // 获取关键字
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchBar.text];
    
    // 用关键字过滤数组中的内容, 将过滤后的内容放入结果数组
    //    self.searchResults = [[self.rangeOfSearchData filteredArrayUsingPredicate:predicate] mutableCopy];
    if (result) {//有字符,
        
        self.rightButton.selected = NO;
        
        if (self.textChangeBlock) {
            self.textChangeBlock(self.searchBar.text, self.searchBar.text);
        }
        
    } else {
        self.rightButton.selected = YES;
        if (self.textChangeBlock) {
            self.textChangeBlock(nil, @"");
        }
    }
}




- (void)setSearchBarLeftImage:(NSString *)searchBarLeftImage {
    _searchBarLeftImage = searchBarLeftImage;
    
    UIImage *image = [UIImage imageNamed:searchBarLeftImage];
    [self.headerBtn setImage:image forState:UIControlStateNormal];
    self.headerBtn.size = CGSizeMake(image.size.width*2.5, image.size.height);
}


- (void)footerIconName:(NSString *)footerIcon title:(NSString *)footerTitle color:(UIColor *)color {
    
    if (footerIcon && footerIcon.length) {
        
        UIImage *image = [UIImage imageNamed:footerIcon];
        [self.rightButton setImage:image forState:UIControlStateNormal];
    }
    
    [self.rightButton setTitleColor:color?:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:footerTitle?:@"" forState:UIControlStateNormal];
}

- (void)footerSelectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor {
    
    [self.rightButton setTitle:selectedTitle?:@"" forState:UIControlStateSelected];
    
    if (selectedColor) {
        [self.rightButton setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}

#pragma mark -- textField Delegate --
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.rightButton.selected = YES;
    
    [self updateSearchBarWithHiddenBtn:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    self.rightButton.selected = YES;
    
    if (self.searchEventBlock && textField.text.length) {
        
        self.searchEventBlock(textField.text, @(self.rightButton.selected));
    }
    
    return YES;
}


#pragma mark -- 右边按钮事件 --
- (void)rightButtonEventClick:(UIButton *)sender {
    
    [self.searchBar resignFirstResponder];
    
    sender.selected = !sender.selected;
    
    if (!sender.selected) {

        self.searchBar.text = nil;
        [self updateSearchBarWithHiddenBtn:YES];
    }
    
    if (self.searchEventBlock) {
        self.searchEventBlock(self.searchBar.text, @(sender.selected));
    }
}

#pragma mark -- 更新searchBar 宽 --
- (void) updateSearchBarWithHiddenBtn:(BOOL)hidden {
    
    __block CGRect frame = self.searchBar.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (hidden) {
            frame.size.width = CGRectGetWidth(self.bounds)-2*5;
        } else {
            frame.size.width = CGRectGetMinX(self.rightButton.frame) - 10;
        }
        self.searchBar.frame = frame;
    }];
    
    self.rightButton.hidden = hidden;
}
- (UIButton *)headerBtn {
    
    if (!_headerBtn) {
        _headerBtn = [BLGeneralControl createUIButtonWithNormalIcon:@"选课_推荐_搜索" selectedIcon:@"选课_推荐_搜索"];
        self.searchBar.leftView = _headerBtn;
        self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    }
    return _headerBtn;
}

- (UIButton *)rightButton {
    
    if (!_rightButton) {
        
        _rightButton = [BLGeneralControl createUIButtonWithNormalIcon:@"选课_推荐_搜索" selectedIcon:@"选课_推荐_搜索"];
        _rightButton.titleLabel.font = MFONT_15;
        _rightButton.hidden = YES;
        [_rightButton addTarget:self action:@selector(rightButtonEventClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightButton.frame = CGRectMake(CGRectGetWidth(self.bounds)-50, 0, 50, CGRectGetHeight(self.searchBar.frame));
        [self addSubview:_rightButton];
        
    }
    return _rightButton;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"---%@---销毁了", [self class]);
}
@end
