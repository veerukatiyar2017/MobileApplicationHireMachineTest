//
//  MessageView.h
//  DBLive
//
//  Created by Samar Hussain on 16/02/16.
//  Copyright © 2016 Samar Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageRemoveDelegate <NSObject>

-(void)closeButtonPressed;

@end

@interface MessageView : UILabel

+ (void) showInView : (UIView *) view withMessage: (NSString *) message;

@property (strong, nonatomic) IBOutlet MessageView *messageHUD;

@end
