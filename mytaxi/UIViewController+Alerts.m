//
//  UIViewController+Alerts.m
//  mxtaxi
//
//  Created by Johann Werner on 25.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)displayAlertWithMessage:(NSString *)message {
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:NSLocalizedString(@"app_name", nil)
                                              message:message
                                              preferredStyle:UIAlertControllerStyleAlert];
        [alertController
         addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK")
                                            style:UIAlertActionStyleCancel
                                          handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
