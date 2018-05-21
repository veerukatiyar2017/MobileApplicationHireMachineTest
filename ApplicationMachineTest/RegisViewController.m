//
//  RegisViewController.m
//  ApplicationMachineTest
//
//  Created by Veeru Katiyar on 17/05/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import "RegisViewController.h"
#import "MessageView.h"
#import "AFNetworking.h"
#import "UserListViewController.h"
#import "SVProgressHUD.h"

@interface RegisViewController ()

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_emailTxtField resignFirstResponder];
    [_passwordTxtField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

- (BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)isValidPassword:(NSString *)passwordString
{
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

- (IBAction)SignUp:(id)sender {
    BOOL emailStr = [self validateEmailWithString:_emailTxtField.text];
    BOOL passStr = [self isValidPassword:_passwordTxtField.text];
    if(!emailStr) {
        [MessageView showInView:self.view withMessage:@"Please enter correct email id"];
        return;
    }
    else if(!passStr) {
        [MessageView showInView:self.view withMessage:@"Password must have atleast 10 character, one lower case letter, one uppaer case letter, one digit and one special character."];
        return;
    }
    else if([_emailTxtField.text isEqualToString:@""] && [_passwordTxtField.text isEqualToString:@""]) {
        [MessageView showInView:self.view withMessage:@"Empty fiels are not allow"];
        return;
    }
    else {
        
//        [SVProgressHUD showWithStatus:@"Sending...."];
        
NSString *Loginurl = [NSString stringWithFormat:@"https://reqres.in/api/register"];
        
        NSDictionary *params = @{@"email":_emailTxtField.text,
                                 @"password":_passwordTxtField.text
                                 };
        
        //here we can see parameters which is sent to server
        
        NSLog(@"Sent parameter to server 2 : %@",params);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        
        [policy setValidatesDomainName:NO];
        
        [policy setAllowInvalidCertificates:YES];
        
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",nil];
        
        [manager POST:Loginurl parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            // Here we can see response which is coming from server
          
            NSLog(@"Response from server 2 :  %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
           
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponce = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            if ([[jsonResponce valueForKey:@"token"] isEqualToString:@"QpwL5tke4Pnpja7X"]) {
                UserListViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"UserListViewController"];
                [self.navigationController pushViewController:details animated:YES];
                
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error)
         
         {
             // If Error occur, then this is AlertController Appear
             
             NSLog(@"Error: %@", error);
             
             UIAlertController *Erroralert=   [UIAlertController alertControllerWithTitle:@"Network Connection Failed!!" message:@"Please try again" preferredStyle:UIAlertControllerStyleAlert];
             
             [self presentViewController:Erroralert animated:YES completion:nil];
             
             UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                         {
                                             [self resignFirstResponder];
                                             [Erroralert dismissViewControllerAnimated:YES completion:nil];
                                         }];
             [Erroralert addAction: yesButton];
         }];
    }
}

@end
