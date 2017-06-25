//
//  UIStoryboard+StoryboardManager.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UIStoryboard+StoryboardManager.h"

@implementation UIStoryboard (StoryboardManager)

+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

@end
