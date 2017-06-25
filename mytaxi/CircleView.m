//
//  CircleView.m
//  mxtaxi
//
//  Created by Johann Werner on 25.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height/2;
}

@end
