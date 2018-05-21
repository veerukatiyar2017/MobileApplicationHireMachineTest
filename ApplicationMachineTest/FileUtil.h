//
//  FileUtil.h
//  ApplicationMachineTest
//
//  Created by VEERU KATIYAR on 5/20/18.
//  Copyright © 2018 Veeru Katiyar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileUtil : NSObject

+(BOOL) fileExistsInProject:(NSString *)fileName;

+(NSString*) saveImageTODocumentAndGetPath: (UIImage *) image;

@end
