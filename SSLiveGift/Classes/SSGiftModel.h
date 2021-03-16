//
//  SSGiftModel.h
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSGiftModel : NSObject

/* 礼物id,用户id+图片id */
@property (nonatomic, copy) NSString *giftId;
/* 礼物图片id */
@property (nonatomic, copy) NSString *giftImageId;
/* 礼物图片 */
@property (nonatomic, strong) UIImage *giftImage;
/* 用户头像url */
@property (nonatomic, copy) NSString *avater;
/* 用户id */
@property (nonatomic, copy) NSString *userId;
/* 用户昵称 */
@property (nonatomic,copy) NSString *nickName;
/* 礼物名称 */
@property (nonatomic,copy) NSString *giftName;
/* 送的礼物数 */
@property (nonatomic,assign) NSInteger sendCount;
/* 礼物数，默认0 */
@property (nonatomic, assign) NSInteger defaultCount;
/* 是否选中 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
