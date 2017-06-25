//
//  UIColor+ColorManager.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UIColor+ColorManager.h"

@implementation UIColor (ColorManager)

+ (UIColor *)mainThemeColor {
    return [UIColor colorWithRed:254.0f / 255.0f
                           green:203.0f / 255.0f
                            blue:47.0f / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)textColor {
    return [UIColor colorWithRed:74.0f / 255.0f
                           green:74.0f / 255.0f
                            blue:74.0f / 255.0f
                           alpha:1.0f];
}

@end
