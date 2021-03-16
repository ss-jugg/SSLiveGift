//
//  SSGiftOperation.h
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SSGiftView;
@class SSGiftModel;
@class SSGiftOperation;

typedef void(^FinishedOperationBlock)(BOOL res, NSString *giftId, NSString *opId);

@interface SSGiftOperation : NSOperation


/* 任务id，礼物id_时间戳 */
@property (nonatomic, copy) NSString *operationId;
/* 礼物数据 */
@property (nonatomic, strong) SSGiftModel *giftModel;
/* 礼物视图 */
@property (nonatomic, strong) SSGiftView *giftView;
/* 礼物展示层 */
@property (nonatomic, weak) UIView *parentView;

@property (nonatomic, copy) FinishedOperationBlock finishedBlock;

+ (SSGiftOperation *)operationWithModel:(SSGiftModel *)giftModel giftView:(SSGiftView *)giftView finishedBlock:(FinishedOperationBlock)finishedBlock;

@end

NS_ASSUME_NONNULL_END
