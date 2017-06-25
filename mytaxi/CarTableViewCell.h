//
//  CarTableViewCell.h
//  mxtaxi
//
//  Created by Johann Werner on 24.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *exteriorLabel;
@property (weak, nonatomic) IBOutlet UILabel *engineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *interiorLabel;
@property (weak, nonatomic) IBOutlet UILabel *licensePlateLabel;
@end
