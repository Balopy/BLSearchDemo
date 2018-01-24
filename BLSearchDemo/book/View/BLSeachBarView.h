//
//  BLSeachBarView.h
//  OilReading
//
//  Created by Balopy on 2018/1/11.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSeachBarView : UIView<UITextFieldDelegate>

/*! 自定义搜索框 */
@property (nonatomic, strong) UITextField *searchBar;

/*! 搜索左边图标 */
@property (nonatomic, copy) NSString *searchBarLeftImage;

/*! 搜索框右边按钮, 正常title */
- (void) footerIconName:(NSString *)footerIcon title:(NSString *)footerTitle color:(UIColor *)color;

/*! 搜索框右边按钮, 选中状态下的 title */
- (void)footerSelectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor;

/*! 搜索按钮的点击事件 */
@property (nonatomic, copy) BLUsuallyBlock searchEventBlock;

/*! 字符变化通知 */
@property (nonatomic, copy) BLUsuallyBlock textChangeBlock;

@end
