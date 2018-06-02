//
//  Circle.m
//  wag-demo
//
//  Created by Zhan Peng Pan on 6/1/18.
//  Copyright © 2018 alex_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Circle.h"

@implementation Circle

- (void) drawRect: (CGRect) rect{
    static CAShapeLayer *circleLayer = nil;
    if(circleLayer == nil){
        CGFloat radius = rect.size.height < rect.size.width ? rect.size.width : rect.size.height;
        circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * radius, 2.0 * radius) cornerRadius: radius].CGPath;
        circleLayer.position = CGPointMake(0.5 * self.frame.size.width - radius, 0.5 * self.frame.size.height - radius);
        circleLayer.fillColor = _color == nil? [UIColor blackColor].CGColor : _color.CGColor;
        [self.layer addSublayer: circleLayer];
    }
    
}

@end
