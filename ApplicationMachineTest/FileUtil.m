//
//  FileUtil.m
//  ApplicationMachineTest
//
//  Created by VEERU KATIYAR on 5/20/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+(BOOL) fileExistsInProject:(NSString *)fileName

{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *fileInResourcesFolder = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    return [fileManager fileExistsAtPath:fileInResourcesFolder];
    
}

+(NSString*) saveImageTODocumentAndGetPath: (UIImage *) image {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         
                                                         NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      
                      @"test.png" ];
    
    NSData* data = UIImagePNGRepresentation(image);
    
    [data writeToFile:path atomically:YES];
    
    
    
    return path;
    
}

@end
