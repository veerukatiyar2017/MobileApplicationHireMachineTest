//
//  RegisViewController.h
//  ApplicationMachineTest
//
//  Created by Veeru Katiyar on 17/05/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
- (IBAction)SignUp:(id)sender;

@end
