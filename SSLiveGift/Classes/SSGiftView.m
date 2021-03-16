//
//  SSGiftView.m
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import "SSGiftView.h"
#import "SSGiftModel.h"
#import "SSComboLabel.h"

@interface SSGiftView ()

@property (nonatomic, strong) UIImageView *bgImgView;
/* 头像 */
@property (nonatomic, strong) UIImageView *headImgView;
/* 礼物 */
@property (nonatomic, strong) UIImageView *giftImgView;
/* 用户名称 */
@property (nonatomic, strong) UILabel *nameLbl;
/* 礼物名称 */
@property (nonatomic, strong) UILabel *giftLbl;
/* 连击 */
@property (nonatomic, strong) SSComboLabel *comboLbl;

@end
@implementation SSGiftView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.currentGiftCount = 0;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    [self addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.headImgView];
    [self.bgImgView addSubview:self.nameLbl];
    [self.bgImgView addSubview:self.giftLbl];
    [self.bgImgView addSubview:self.giftImgView];
    [self.bgImgView addSubview:self.comboLbl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImgView.frame = CGRectMake(6, 0, CGRectGetWidth(self.frame)-6, GiftView_H);
    self.headImgView.frame = CGRectMake(6, 6, GiftView_UserIcon_WH, GiftView_UserIcon_WH);
    self.nameLbl.frame = CGRectMake(CGRectGetMaxX(self.headImgView.frame)+6, CGRectGetMinY(self.headImgView.frame), GiftView_UserName_W, GiftView_UserName_H);
    self.giftLbl.frame = CGRectMake(CGRectGetMinX(self.nameLbl.frame), CGRectGetMaxY(self.nameLbl.frame)+2, GiftView_UserName_W, GiftView_GiftName_H);
    self.giftImgView.frame = CGRectMake(CGRectGetMaxX(self.nameLbl.frame), (GiftView_H - GiftView_GiftIcon_WH)/2, GiftView_GiftIcon_WH, GiftView_GiftIcon_WH);
    self.comboLbl.frame = CGRectMake(CGRectGetMaxX(self.giftImgView.frame)+12, 7, GiftView_XNum_W, 30);
}

- (void)animationWithGiftModel:(SSGiftModel *)giftModel completeBlock:(void (^)(BOOL finished, NSString *giftId))block {
        
    self.giftModel = giftModel;
    self.completeBlock = block;
    
//    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:giftModel.avater] placeholderImage:[UIImage wm_imageWithName:@"icon_head_placeholder"]];
    self.nameLbl.text = giftModel.nickName;
    self.giftLbl.text = [NSString stringWithFormat:@"送%@", giftModel.giftName];
//    self.giftImgView.image = [UIImage wm_imageWithName:giftModel.giftImageId];
    self.giftImgView.image = giftModel.giftImage;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, CGRectGetMinY(self.originFrame), CGRectGetWidth(self.originFrame), CGRectGetHeight(self.originFrame));
    } completion:^(BOOL finished) {
        self.currentGiftCount = 0;
        [self setGiftCount:giftModel.defaultCount];
    }];
}

- (void)setGiftCount:(NSInteger)giftCount {
    _giftCount = giftCount;
    self.currentGiftCount += giftCount;
    self.comboLbl.text = [NSString stringWithFormat:@"x%ld", self.currentGiftCount];
    if (self.currentGiftCount > 1) {
        [self.comboLbl startComboAnimation:0.3];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideGiftView) object:nil];
        [self performSelector:@selector(hideGiftView) withObject:nil afterDelay:3];
    }else {
        [self performSelector:@selector(hideGiftView) withObject:nil afterDelay:3];
    }
}

- (void)hideGiftView {
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self reset];
        self.finished = finished;
        [self removeFromSuperview];
        if (self.completeBlock) {
            self.completeBlock(finished, self.giftModel.giftId);
        }
    }];
}

- (void)reset {
    
    self.frame = self.originFrame;
    self.alpha = 1;
    self.currentGiftCount = 0;
    self.comboLbl.text = @"";
}


#pragma mark - getter
- (UIView *)bgImgView {
    
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgImgView.layer.cornerRadius = 22;
        _bgImgView.layer.masksToBounds = YES;
    }
    return _bgImgView;
}
- (UIImageView *)headImgView {
    
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.layer.borderWidth = 1;
        _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImgView.layer.cornerRadius = 16;
        _headImgView.layer.masksToBounds = YES;
    }
    return _headImgView;
}

- (UILabel *)nameLbl {
    
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.font = [UIFont systemFontOfSize:14];
        _nameLbl.textColor = [UIColor whiteColor];
    }
    return _nameLbl;
}
- (UILabel *)giftLbl {
    
    if (!_giftLbl) {
        _giftLbl = [[UILabel alloc] init];
        _giftLbl.font = [UIFont systemFontOfSize:12];
        _giftLbl.textColor = [UIColor whiteColor];
    }
    return _giftLbl;
}

- (UIImageView *)giftImgView {
    
    if (!_giftImgView) {
        _giftImgView = [[UIImageView alloc] init];
    }
    return _giftImgView;
}

- (SSComboLabel *)comboLbl {
    
    if (!_comboLbl) {
        _comboLbl = [[SSComboLabel alloc] init];
        _comboLbl.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:24];
        _comboLbl.textColor = [UIColor whiteColor];
    }
    return _comboLbl;
}

@end
