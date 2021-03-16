//
//  SSGiftManager.m
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import "SSGiftManager.h"
#import "SSGiftView.h"
#import "SSGiftOperation.h"

//最大连击数
static NSInteger maxComboCount = 99;

@interface SSGiftManager ()

/* 礼物1 */
@property (nonatomic, strong) SSGiftView *topGiftView;
/* 礼物2 */
@property (nonatomic, strong) SSGiftView *bottomGiftView;

/* 礼物队列1 */
@property (nonatomic, strong) NSOperationQueue *topQueue;
/* 礼物队列2 */
@property (nonatomic, strong) NSOperationQueue *bottomQueue;

/* 任务缓存 */
@property (nonatomic, strong) NSCache *operationCache;

@end

@implementation SSGiftManager

+ (instancetype)manager {
    
    SSGiftManager *manager = [[SSGiftManager alloc] init];
    
    return manager;
}

- (void)dealloc {
    
    if (self.topQueue.operationCount > 0) {
        [self.topQueue cancelAllOperations];
    }
    if (self.bottomQueue.operationCount > 0) {
        [self.bottomQueue cancelAllOperations];
    }
    [self.operationCache removeAllObjects];
}

- (void)animationWithModel:(SSGiftModel *)giftModel finishBlock:(nullable void(^)(BOOL finished))finishBlock {
    
    SSGiftOperation *op = [self.operationCache objectForKey:giftModel.giftId];
    if (op) {
        if (!op.isFinished && op.isExecuting) {
            //当前正在展示的礼物
            op.giftView.giftCount = giftModel.sendCount;
            //限制礼物最大连击数
            if (op.giftView.currentGiftCount >= maxComboCount) {
                [self.operationCache removeObjectForKey:giftModel.giftId];
            }
        }else {
            //队列中未展示的礼物
            op.giftModel.defaultCount += giftModel.sendCount;
            if (op.giftModel.defaultCount >= maxComboCount) {
                //限制礼物最大连击数
                [self.operationCache removeObjectForKey:giftModel.giftId];
            }
        }
    }else {
        
        NSOperationQueue *queue;
        SSGiftView *giftView;
        if (self.topQueue.operationCount <= self.bottomQueue.operationCount) {
            queue = self.topQueue;
            giftView = self.topGiftView;
        }else {
            queue = self.bottomQueue;
            giftView = self.bottomGiftView;
        }
        
        //创建礼物动画任务
        __weak typeof(SSGiftManager *) weakSelf = self;
        op = [SSGiftOperation operationWithModel:giftModel giftView:giftView finishedBlock:^(BOOL res, NSString * _Nonnull giftId, NSString * _Nonnull opId) {
            //任务结束
            if (finishBlock) {
                finishBlock(res);
            }
            SSGiftOperation *operation = [weakSelf.operationCache objectForKey:giftId];
            //根据任务id匹配
            if ([operation.operationId isEqualToString:opId]) {
                [weakSelf.operationCache removeObjectForKey:giftId];
            }
        }];
        op.parentView = self.displayView;
        op.giftModel.defaultCount += giftModel.sendCount;
        
        [self.operationCache setObject:op forKey:giftModel.giftId];
        [queue addOperation:op];
    }
}

#pragma mark - getter
- (NSOperationQueue *)topQueue {
    
    if (!_topQueue) {
        _topQueue = [[NSOperationQueue alloc] init];
        _topQueue.maxConcurrentOperationCount = 1;
    }
    return _topQueue;
}

- (NSOperationQueue *)bottomQueue {
    
    if (!_bottomQueue) {
        _bottomQueue = [[NSOperationQueue alloc] init];
        _bottomQueue.maxConcurrentOperationCount = 1;
    }
    return _bottomQueue;
}

- (NSCache *)operationCache {
    
    if (!_operationCache) {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

- (SSGiftView *)topGiftView {
    
    if (!_topGiftView) {
        CGFloat viewW = 10 + 6 + GiftView_UserIcon_WH + 6 + GiftView_UserName_W + GiftView_UserIcon_WH + 12 + GiftView_XNum_W + 16;
        _topGiftView = [[SSGiftView alloc] initWithFrame:CGRectMake(-viewW, self.startPoint.y, viewW, GiftView_H)];
        _topGiftView.originFrame = _topGiftView.frame;
    }
    return _topGiftView;
}

- (SSGiftView *)bottomGiftView {
    
    if (!_bottomGiftView) {
        CGFloat viewW = 10 + 6 + GiftView_UserIcon_WH + 6 + GiftView_UserName_W + GiftView_UserIcon_WH + 12 + GiftView_XNum_W + 16;
        _bottomGiftView = [[SSGiftView alloc] initWithFrame:CGRectMake(-viewW, self.startPoint.y+GiftView_H+10, viewW, GiftView_H)];
        _bottomGiftView.originFrame = _bottomGiftView.frame;
    }
    return _bottomGiftView;
}

@end
