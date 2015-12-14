//
//  CustomDatePicker.m
//  Kaoke
//
//  Created by xiaogu on 14-2-12.
//
//

#import "CustomDatePicker.h"

#define DEFAULT_TITLE [UIColor blackColor]
#define DEFAULT_BACKGROUND [UIColor whiteColor]
#define DEFAULT_TOOLBAR [UIColor colorWithWhite:0.9 alpha:1]
#define DATEHIGHT 216

static CustomDatePicker *piker = nil;

@interface CustomDatePicker()
{
    UIView *_mainView;
    UIView *_toolBar;
    UIButton *_close;
    UIButton *_submmite;
    UIDatePicker *_datePicker;
    NSLayoutConstraint *_bottomConstraint;
}
@end

@implementation CustomDatePicker

+(CustomDatePicker*)pickerForTarget:(id<CustomDatePickerDelegate>)target{
    CustomDatePicker *picker = [[CustomDatePicker alloc] init];
    picker.delegate = target;
    return picker;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.frame           = [UIScreen mainScreen].bounds;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        /**
         主背景
         */
        _mainView            = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width,DATEHIGHT+44)];
        [_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeLeft multiplier:1 constant:DATEHIGHT]];
        _bottomConstraint = [NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:self.frame.size.height];
        _mainView.backgroundColor = DEFAULT_BACKGROUND;
        [_mainView addConstraint:_bottomConstraint];
        
        /**
         工具栏
        */
        _toolBar          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _toolBar.backgroundColor  = DEFAULT_TOOLBAR;
        [_toolBar addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [_toolBar addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [_toolBar addConstraint:[NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [_toolBar addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeLeft multiplier:1 constant:44]];
        [_mainView addSubview:_toolBar];
        
        
        _close                = [UIButton buttonWithType:UIButtonTypeCustom];
//        [close setImage:[UIImage imageNamed:@"bt_cancel"] forState:UIControlStateNormal];
        [_close setTitleColor:DEFAULT_TITLE forState:UIControlStateNormal];
        [_close setTitle:@"关闭" forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        
        _submmite             = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submmite setTitleColor:DEFAULT_TITLE forState:UIControlStateNormal];
        [_submmite setTitle:@"确定" forState:UIControlStateNormal];
        [_submmite addTarget:self action:@selector(submite:) forControlEvents:UIControlEventTouchUpInside];
        _submmite.frame                    = CGRectMake(10,0, 44, 44);
        _submmite.frame                 = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 44,  0, 44, 44);
        [_mainView addSubview:_submmite];
        [_mainView addSubview:_close];

        /**
         时间
         */
        _datePicker                    = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, DATEHIGHT)];
        _datePicker.datePickerMode     = UIDatePickerModeDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_mainView addSubview:_datePicker];
        [self addSubview:_mainView];
        
    }
    return self;
}
/**
 *  设置时间背景颜色
 *
 *  @param pickerBackgroundColor 时间背景颜色
 */
-(void)setPickerBackgroundColor:(UIColor *)pickerBackgroundColor
{
    _pickerBackgroundColor = pickerBackgroundColor;
    _mainView.backgroundColor = pickerBackgroundColor;
}
/**
 *  设置工具栏背景颜色
 *
 *  @param toolBarBackgroundColor 工具栏背景颜色
 */
-(void)setToolBarBackgroundColor:(UIColor *)toolBarBackgroundColor
{
    _toolBarBackgroundColor = toolBarBackgroundColor;
    _toolBar.backgroundColor = toolBarBackgroundColor;
}
/**
 *  设置按钮标题颜色
 *
 *  @param actionButtonColor 按钮文字颜色
 */
-(void)setActionButtonColor:(UIColor *)actionButtonColor{
    _actionButtonColor = actionButtonColor;
    [_submmite setTitleColor:actionButtonColor forState:UIControlStateNormal];
    [_close setTitleColor:actionButtonColor forState:UIControlStateNormal];
}
/**
 *  点击空白区域将隐藏
 *
 *  @param touches 手势
 *  @param event   事件
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hidden];
}
/**
 *  在目标View中现实
 *
 *  @param view 目标View
 */
-(void)showInView:(UIView*)view{
    [view addSubview:self];
    [self animatedIn];
}
/**
 *  弹出动画
 */
-(void)animatedIn{
    [UIView animateWithDuration:.35 animations:^{
        _bottomConstraint.constant = 0;
    }];
}
/**
 *  隐藏事件
 */
-(void)hidden{
    [self animatedOut];
}
/**
 *  隐藏动画
 */
-(void)animatedOut{
    [UIView animateWithDuration:.35 animations:^{
        _bottomConstraint.constant = self.frame.size.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  点击确定按钮触发事件
 *
 *  @param sender 确定按钮
 */
-(void)submite:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(changeDateSubmite:)]) {
        [self.delegate performSelector:@selector(changeDateSubmite:) withObject:_datePicker.date];
    }
    [self hidden];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
