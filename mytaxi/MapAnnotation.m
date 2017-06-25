//
//  MapAnnotation.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "MapAnnotation.h"

@interface MapAnnotation ()

@property NSString *image;

@end


@implementation MapAnnotation

- (id)initWithImage:(NSString *)image
{
    if ( self = [super init]) {
        self.image = image;
    }
    
    return self;    
}

- (MKAnnotationView *)annotationView
{
    
    MKAnnotationView *annView = [[MKAnnotationView alloc] initWithAnnotation: self reuseIdentifier: NSStringFromClass([self class])];
    annView.canShowCallout = NO;
    annView.image = [UIImage imageNamed: self.image];
    return annView;
    
}

@end
