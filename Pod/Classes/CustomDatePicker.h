//
//  CustomDatePicker.h
//  Kaoke
//
//  Created by xiaogu on 14-2-12.
//
//

#import <UIKit/UIKit.h>
/**
 *  代理
 */
@protocol CustomDatePickerDelegate <NSObject>
/**
 *  确定按钮代理方法
 *
 *  @param date 当前选择的时间
 */
-(void)changeDateSubmite:(NSDate*)date;
@end

@interface CustomDatePicker : UIView
@property (nonatomic,assign) id<CustomDatePickerDelegate> delegate;
@property (nonatomic,retain) UIColor *toolBarBackgroundColor;
@property (nonatomic,retain) UIColor *pickerBackgroundColor;
@property (nonatomic,retain) UIColor *actionButtonColor;

/**
 *  快速构建方法
 *
 *  @return 自定义Picker实例
 */
+(CustomDatePicker*)pickerForTarget:(id<CustomDatePickerDelegate>)target;
/**
 *  此方法用于弹出显示DatePicker
 */
-(void)showInView:(UIView*)view;
@end
