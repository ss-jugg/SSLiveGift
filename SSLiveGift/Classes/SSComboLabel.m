//
//  SSComboLabel.m
//  SSLiveGift
//
//  Created by 沈伟航 on 2021/3/16.
//

#import "SSComboLabel.h"

@implementation SSComboLabel

- (void)startComboAnimation:(NSTimeInterval)duration {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = duration;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1.0];
    pulse.toValue= [NSNumber numberWithFloat:1.5];
    [[self layer] addAnimation:pulse forKey:nil];
}

//  重写 drawTextInRect 文字描边效果
- (void)drawTextInRect:(CGRect)rect {

    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);

    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor yellowColor];
    [super drawTextInRect:rect];

    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];

    self.shadowOffset = shadowOffset;

}

@end
