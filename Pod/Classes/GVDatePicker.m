//
//  GVDatePicker.m
//
//  Created by xiaogu on 14-2-12.
//
//

#import "GVDatePicker.h"

#define DEFAULT_TITLE [UIColor blackColor]
#define DEFAULT_BACKGROUND [UIColor whiteColor]
#define DEFAULT_TOOLBAR [UIColor colorWithWhite:0.9 alpha:1]
#define DATEHIGHT 216

static GVDatePicker *piker = nil;

@interface GVDatePicker()
{
    UIView *_mainView;
    UIView *_toolBar;
    UIButton *_close;
    UIButton *_submmite;
    UIDatePicker *_datePicker;
    NSLayoutConstraint *_bottomConstraint;
}
@end

@implementation GVDatePicker

+(GVDatePicker*)pickerForTarget:(id<GVDatePickerDelegate>)target{
    GVDatePicker *picker = [[GVDatePicker alloc] init];
    picker.delegate = target;
    return picker;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setTranslatesAutoresizingMaskIntoConstraints:false];
        /**
         主背景
         */
        _mainView            = [[UIView alloc] init];
        [_mainView setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self addSubview:_mainView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_mainView);
        NSString *vfl = @"V:[_mainView(260)]";
        NSString *vfl1 = @"H:|-0-[_mainView]-0-|";
        NSString *vfl2 = @"V:[_mainView]-(-260)-|";

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:vfl2 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views];
        _bottomConstraint = constraints[0];
        [self addConstraints:constraints];
//
        _mainView.backgroundColor = DEFAULT_BACKGROUND;
        
        /**
         工具栏
        */
        _toolBar          = [[UIView alloc] init];
        _toolBar.backgroundColor  = DEFAULT_TOOLBAR;
        [_toolBar setTranslatesAutoresizingMaskIntoConstraints:false];
        [_mainView addSubview:_toolBar];

        NSDictionary *views1 = NSDictionaryOfVariableBindings(_toolBar);
        NSString *tvfl = @"H:|-0-[_toolBar]-0-|";
        NSString *tvfl1 = @"V:|-0-[_toolBar]";
        NSString *tvfl2 = @"V:[_toolBar(44)]";
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tvfl options:NSLayoutFormatAlignAllCenterX metrics:nil views:views1]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tvfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views1]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tvfl2 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views1]];
//
        _close                = [UIButton buttonWithType:UIButtonTypeCustom];
        [_close setTitleColor:DEFAULT_TITLE forState:UIControlStateNormal];
        [_close setTitle:@"关闭" forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        
        _submmite             = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submmite setTitleColor:DEFAULT_TITLE forState:UIControlStateNormal];
        [_submmite setTitle:@"确定" forState:UIControlStateNormal];
        [_submmite addTarget:self action:@selector(submite:) forControlEvents:UIControlEventTouchUpInside];
        [_submmite setTranslatesAutoresizingMaskIntoConstraints:false];
        [_close setTranslatesAutoresizingMaskIntoConstraints:false];
        [_mainView addSubview:_submmite];
        [_mainView addSubview:_close];
        
        NSDictionary *views2 = NSDictionaryOfVariableBindings(_close);
        NSString *closeVfl = @"V:|-0-[_close]";
        NSString *closeVfl1 = @"H:|-10-[_close]";
        NSString *closeVfl2 = @"V:[_close(44)]";
        NSString *closeVfl3 = @"[_close(44)]";
        
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:closeVfl options:NSLayoutFormatAlignAllCenterX metrics:nil views:views2]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:closeVfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views2]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:closeVfl2 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views2]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:closeVfl3 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views2]];


        NSDictionary *views3 = NSDictionaryOfVariableBindings(_submmite);
        NSString *submmiteVfl = @"V:|-0-[_submmite]";
        NSString *submmiteVfl1 = @"H:[_submmite]-10-|";
        NSString *submmiteVfl2 = @"V:[_submmite(44)]";
        NSString *submmiteVfl3 = @"[_submmite(44)]";
        
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:submmiteVfl options:NSLayoutFormatAlignAllCenterX metrics:nil views:views3]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:submmiteVfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views3]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:submmiteVfl2 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views3]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:submmiteVfl3 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views3]];
        
        
        /**
         时间
         */
        _datePicker                    = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, DATEHIGHT)];
        _datePicker.datePickerMode     = UIDatePickerModeDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_datePicker setTranslatesAutoresizingMaskIntoConstraints:false];
        [_mainView addSubview:_datePicker];
        
        NSDictionary *views4 = NSDictionaryOfVariableBindings(_datePicker);
        NSString *pickerVfl = @"V:|-44-[_datePicker]-0-|";
        NSString *pickerVfl1 = @"H:|-0-[_datePicker]-0-|";
        
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:pickerVfl options:NSLayoutFormatAlignAllCenterX metrics:nil views:views4]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:pickerVfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views4]];
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
    NSDictionary *views = NSDictionaryOfVariableBindings(self);
    NSString *vfl1 = @"V:|-0-[self]-0-|";
    NSString *vfl2 = @"H:|-0-[self]-0-|";
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl2 options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self layoutIfNeeded];
    [self animatedIn];
}
/**
 *  弹出动画
 */
-(void)animatedIn{
    _bottomConstraint.constant = 0;
    [UIView animateWithDuration:.35 animations:^{
        [_mainView layoutIfNeeded];
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
    _bottomConstraint.constant = -260;
    [UIView animateWithDuration:.35 animations:^{
        [_mainView layoutIfNeeded];
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
