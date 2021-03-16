//
//  SSViewController.m
//  SSLiveGift
//
//  Created by 沈伟航 on 03/16/2021.
//  Copyright (c) 2021 沈伟航. All rights reserved.
//

#import "SSViewController.h"
#import "SSGiftManager.h"

@interface SSViewController ()

@property (nonatomic, strong) NSMutableArray *gifts;

@property (nonatomic, strong) SSGiftManager *manager;
@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    int r  = arc4random_uniform(4);
    SSGiftModel *giftModel = self.gifts[r];

    SSGiftModel *m = [[SSGiftModel alloc] init];
    m.userId = @"123131231";
    m.nickName = @"嘻嘻嘻嘻嘻嘻嘻";
    m.giftImage = [UIImage imageNamed:giftModel.giftImageId];
    m.giftName = giftModel.giftName;
    m.giftImageId = giftModel.giftImageId;
    [self.manager animationWithModel:m finishBlock:nil];
    NSLog(@"送了礼物");
}


- (SSGiftManager *)manager {
    
    if (!_manager) {
        _manager = [SSGiftManager manager];
        _manager.displayView = self.view;
        _manager.startPoint = CGPointMake(0, 200);
    }
    return _manager;
}


- (NSMutableArray *)gifts {
    
    if (!_gifts) {
        _gifts = [[NSMutableArray alloc] init];
        SSGiftModel *giftModel = [[SSGiftModel alloc] init];
        giftModel.giftName = @"";
        
        SSGiftModel *gift1 = [[SSGiftModel alloc] init];
        gift1.giftName = @"仙女棒";
        gift1.giftImageId = @"gift_1";
        [_gifts addObject:gift1];
        
        SSGiftModel *gift2 = [[SSGiftModel alloc] init];
        gift2.giftName = @"胶原蛋白";
        gift2.giftImageId = @"gift_2";
        [_gifts addObject:gift2];
        
        SSGiftModel *gift3 = [[SSGiftModel alloc] init];
        gift3.giftName = @"玫瑰";
        gift3.giftImageId = @"gift_3";
        [_gifts addObject:gift3];
        
        SSGiftModel *gift4 = [[SSGiftModel alloc] init];
        gift4.giftName = @"为你打CALL";
        gift4.giftImageId = @"gift_4";
        
        [_gifts addObject:gift4];
    }
    return _gifts;
}




@end
