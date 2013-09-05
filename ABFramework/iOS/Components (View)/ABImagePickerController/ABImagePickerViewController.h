//
//  ABImagePickerViewController.h
//  ABFramework
//
//  Created by Alexander Blunck on 10/30/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABImagePickerViewController : UIImagePickerController

//Utility
+(id) photoLibraryPickerWithCompletionBlock:( void (^) (UIImage *selectedImage) )block;

//Tigger
-(void) show;

@property (nonatomic, copy) ABBlockVoid wantsToDismissHandler;

@end
