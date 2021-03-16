//
//  SSGiftView.h
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static const CGFloat GiftView_H = 44; //高度
static const CGFloat GiftView_UserIcon_WH = 32; //头像宽高
static const CGFloat GiftView_UserName_W = 98;//名字宽 -
static const CGFloat GiftView_UserName_H = 16;//名字高 -
static const CGFloat GiftView_GiftName_H = 14;//礼物名称高 -
static const CGFloat GiftView_GiftIcon_WH = 40;//礼物图片宽高
static const CGFloat GiftView_XNum_W = 50;//礼物数宽

@class SSGiftModel;
@interface SSGiftView : UIView

/* 礼物数据 */
@property (nonatomic, strong) SSGiftModel *giftModel;
/* 初始位置 */
@property (nonatomic, assign) CGRect originFrame;
/** 礼物数 */
@property(nonatomic,assign) NSInteger giftCount;
/** 当前礼物总数 */
@property(nonatomic,assign) NSInteger currentGiftCount;
/* 是否已完成 */
@property (nonatomic, assign, getter=isFinished) BOOL finished;
/* 完成回调 */
@property (nonatomic, copy) void(^completeBlock)(BOOL finished, NSString *giftKey);

- (void)animationWithGiftModel:(SSGiftModel *)giftModel completeBlock:(void (^)(BOOL finished, NSString *giftId))block;

@end

NS_ASSUME_NONNULL_END
