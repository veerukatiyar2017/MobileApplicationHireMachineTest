//
//  UserDetailViewController.h
//  ApplicationMachineTest
//
//  Created by VEERU KATIYAR on 5/20/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendImageBack <NSObject>
    
-(void)sendDataBack:(NSString *)urlString;

@end

@interface UserDetailViewController : UIViewController<UIImagePickerControllerDelegate>
@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)UploadImage:(id)sender;
- (IBAction)selectImage:(id)sender;
@property (strong, nonatomic)NSString *urlString;
@end
