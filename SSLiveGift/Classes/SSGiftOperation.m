//
//  SSGiftOperation.m
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import "SSGiftOperation.h"
#import "SSGiftModel.h"
#import "SSGiftView.h"

@interface SSGiftOperation ()

@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic, getter = isExecuting) BOOL executing;

@end

@implementation SSGiftOperation
@synthesize finished = _finished;
@synthesize executing = _executing;

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.executing = NO;
        self.finished = NO;
    }
    return self;
}

+ (SSGiftOperation *)operationWithModel:(SSGiftModel *)giftModel giftView:(SSGiftView *)giftView finishedBlock:(FinishedOperationBlock)finishedBlock {
    
    SSGiftOperation *op = [[SSGiftOperation alloc] init];
    op.operationId = [NSString stringWithFormat:@"%@_%ld",giftModel.giftId, (long)[[NSDate date] timeIntervalSince1970]*1000];
    op.giftModel = giftModel;
    op.giftView = giftView;
    op.finishedBlock = finishedBlock;
    return op;
}

- (void)start {
    
    if (self.isCancelled) {
        self.executing = NO;
        self.finished = YES;
        return;
    }
    self.executing = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
       //回到主线程刷新UI
        [self.parentView addSubview:self.giftView];
        __weak typeof(SSGiftOperation *) weakSelf = self;
        [self.giftView animationWithGiftModel:self.giftModel completeBlock:^(BOOL finished, NSString * _Nonnull giftId) {
            __strong typeof(SSGiftOperation *) strongSelf = weakSelf;
            if (strongSelf.finishedBlock) {
                strongSelf.finishedBlock(finished, giftId, strongSelf.operationId);
            }
            strongSelf.finished = YES;
            strongSelf.executing = NO;
        }];
    });
}

#pragma mark - 收到触发kvo
- (void)setExecuting:(BOOL)executing {
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
    
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
