//
//  UserListViewController.h
//  ApplicationMachineTest
//
//  Created by Veeru Katiyar on 17/05/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *UserTableView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
