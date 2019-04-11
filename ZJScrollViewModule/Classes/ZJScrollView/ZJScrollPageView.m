//
//  ZJScrollPageView.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJScrollPageView.h"

@interface ZJScrollPageView ()
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;

@property (weak, nonatomic) UIViewController *parentViewController;


/**
 当前保存title 数组
 */
@property (strong, nonatomic) NSArray *titlesArray;
@end

@implementation ZJScrollPageView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(ZJSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<ZJScrollPageViewDelegate>) delegate {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.delegate = delegate;
        self.parentViewController = parentViewController;
        self.titlesArray = titles.copy;
        self.backgroundColor = [UIColor whiteColor];
        [self segmentView];
        [self contentView];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ZJScrollPageView--销毁");
}

#pragma mark - public helper

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    [self.segmentView setSelectedIndex:selectedIndex animated:animated];
}

/**  给外界重新设置视图内容的标题的方法 */
- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles {
    
    self.titlesArray = nil;
    self.titlesArray = newTitles.copy;
    
    [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];
    [self.contentView reload];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.bounds;
    CGRect rectSegment = CGRectMake(0, 0, rect.size.width, self.segmentStyle.segmentHeight);
    CGRect rectContent = CGRectMake(0, CGRectGetMaxY(rectSegment), rect.size.width, rect.size.height - CGRectGetMaxY(rectSegment));
    self.segmentView.frame = rectSegment;
    self.contentView.frame = rectContent;
}

#pragma mark - getter ---- setter

- (ZJContentView *)contentView {
    if (!_contentView) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectZero segmentView:self.segmentView parentViewController:self.parentViewController delegate:self.delegate];
        [self addSubview:content];
        _contentView = content;
    }
    
    return  _contentView;
}


- (ZJScrollSegmentView *)segmentView {
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectZero segmentStyle:self.segmentStyle delegate:self.delegate titles:self.titlesArray titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            __strong __typeof(self) self = weakSelf;
            [self.contentView setContentOffSet:CGPointMake(self.contentView.bounds.size.width * index, 0.0) animated:self.segmentStyle.isAnimatedContentViewWhenTitleClicked];
        }];
        [self addSubview:segment];
        _segmentView = segment;
    }
    return _segmentView;
}


- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (void)setExtraBtnOnClick:(ExtraBtnOnClick)extraBtnOnClick {
    _extraBtnOnClick = extraBtnOnClick;
    self.segmentView.extraBtnOnClick = extraBtnOnClick;
}

@end
