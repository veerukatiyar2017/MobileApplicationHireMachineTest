//
//  UserListViewController.m
//  ApplicationMachineTest
//
//  Created by Veeru Katiyar on 17/05/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import "UserListViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UserDetailViewController.h"

@interface UserListViewController ()
{
    NSInteger indexNumber;
    UIImage *MyImage;
}
@property (nonatomic, strong)NSMutableArray *tableData;
@property (nonatomic, strong)NSMutableArray *nameArray;
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *idArray;

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    _idArray = [NSMutableArray array];
 
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
  
    [SVProgressHUD showWithStatus:@"Loading..."];

        NSString *Loginurl = [NSString stringWithFormat:@"https://reqres.in/api/users?page=2"];

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
    
        [manager GET:Loginurl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            // Here we can see response which is coming from server
            
            NSLog(@"Response from server 2 :  %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponce = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            _tableData = [jsonResponce valueForKey:@"data"];
            
            for (int i=0; i<_tableData.count; i++) {
            NSString *name = [NSString stringWithFormat:@"%@ %@",[[_tableData valueForKey:@"first_name"] objectAtIndex:i],[[_tableData valueForKey:@"last_name"] objectAtIndex:i]];
                
                NSString *imageURL = [NSString stringWithFormat:@"%@",[[_tableData valueForKey:@"avatar"] objectAtIndex:i]];
                
                NSString *idStr = [NSString stringWithFormat:@"%@",[[_tableData valueForKey:@"id"] objectAtIndex:i]];
                
                [_nameArray addObject:name];
                [_imageArray addObject:imageURL];
                [_idArray addObject:idStr];
            }
            NSLog(@"%@",_idArray);
            [_UserTableView reloadData];
            
            [SVProgressHUD dismiss];

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

# pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_idArray objectAtIndex:indexPath.row];

    NSURL *imageUrl =[NSURL URLWithString:[_imageArray objectAtIndex:indexPath.row]];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
     UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    return cell;
}


-(void)sendDataBack:(NSString *)string
{
    // data will come here inside of ViewControllerA
    NSLog(@"%@",string);
    NSURL *imageUrl =[NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    MyImage = [UIImage imageWithData:data];
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDetailViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailViewController"];
    details.delegate = self;
    [self.navigationController pushViewController:details animated:YES];

}



@end
