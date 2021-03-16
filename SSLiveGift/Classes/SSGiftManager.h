//
//  SSGiftManager.h
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import "SSGiftModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSGiftManager : NSObject

/* 动画展示层 */
@property (nonatomic, weak) UIView *displayView;
/* 礼物视图显示的起始位置 */
@property (nonatomic, assign) CGPoint startPoint;

+ (instancetype)manager;

- (void)animationWithModel:(SSGiftModel *)giftModel finishBlock:(nullable void(^)(BOOL finished))finishBlock;

@end

NS_ASSUME_NONNULL_END
