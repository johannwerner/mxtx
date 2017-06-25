//
//  CarTableViewCell.m
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "CarTableViewCell.h"
#import "Constants.h"

#import "UIColor+ColorManager.h"

@interface CarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *licensePlateView;

@end

@implementation CarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.licensePlateView.layer.cornerRadius = CornerRadius;
    
    self.exteriorLabel.textColor = [UIColor textColor];
    self.engineTypeLabel.textColor = [UIColor textColor];
    self.addressLabel.textColor = [UIColor textColor];
    self.interiorLabel.textColor = [UIColor textColor];
    self.licensePlateLabel.textColor = [UIColor mainThemeColor];
}

@end
