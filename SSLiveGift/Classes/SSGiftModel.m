//
//  SSGiftModel.m
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import "SSGiftModel.h"

@implementation SSGiftModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sendCount = 1;
        self.defaultCount = 0;
    }
    return self;
}


- (NSString *)giftId {
    
    if (!_giftId) {
        _giftId = [NSString stringWithFormat:@"%@_%@", self.userId, self.giftImageId];
    }
    return _giftId;
}

@end
