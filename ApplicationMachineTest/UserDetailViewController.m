//
//  UserDetailViewController.m
//  ApplicationMachineTest
//
//  Created by VEERU KATIYAR on 5/20/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import "UserDetailViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MessageView.h"
#import "FileUtil.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillDisappear:(BOOL)animated
{
    [delegate sendDataBack:_urlString];
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

- (IBAction)UploadImage:(id)sender {
    
    if (self.imageView.image == nil) {
        [MessageView showInView:self.view withMessage:@"Please select an image or Capture image using camera."];
        return;
    } else {
        NSString *urlString=@"https://api.pixhost.to/images";
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        // file
        float low_bound = 0;
        float high_bound =5000;
        float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);//image1
        int intRndValue = (int)(rndValue + 0.5);
        NSString *str_image1 = [@(intRndValue) stringValue];
        NSString *path = [FileUtil saveImageTODocumentAndGetPath:self.imageView.image];
        UIImage *chosenImage1=[UIImage imageNamed:path];
        
        NSData *imageData = UIImageJPEGRepresentation(chosenImage1, 90);
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img\"; filename=\"%@.png\"\r\n",str_image1] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"0" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"max_th_size\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"420" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        // close form
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // set request body
        [request setHTTPBody:body];
        
        //return and test
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", returnString);
        NSData *data = [returnString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponce = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _urlString = [jsonResponce valueForKey:@"th_url"];
        NSLog(@"%@",_urlString);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)selectImage:(id)sender {
    
    NSLog(@"profile pic button is clicked");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Chose Media" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Choose Photo From Gallary" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                  picker.delegate = self;
                                  picker.allowsEditing = YES;
                                  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  [self presentViewController:picker animated:YES completion:NULL];                              }];
    
    UIAlertAction *camer = [UIAlertAction actionWithTitle:@"Use Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                                {
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;
                                    picker.allowsEditing = YES;
                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    [self presentViewController:picker animated:YES completion:NULL];
                                }
                                else
                                {
                                    
                                    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Camera Not Available"
                                                                                                  message:@"" preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction* yesButton = [UIAlertAction                                                      actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                {
                                                                    //Handel your yes please button action here
                                                                }];
                                    [alert addAction:yesButton];
                                    [self presentViewController:alert animated:YES completion:nil];
                                }
                            }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                                 //Handel your yes please button action here
                             }];
    
    [alert addAction:gallery];
    [alert addAction:camer];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end

