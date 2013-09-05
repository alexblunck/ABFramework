//
//  ABImagePickerViewController.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/30/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABImagePickerViewController.h"

@interface ABImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIStatusBarStyle _previousStatusBarStyle;
    void (^_completionBlock) (UIImage *selectedImage);
}
@end

@implementation ABImagePickerViewController

#pragma mark - Utility
+(id) photoLibraryPickerWithCompletionBlock:( void (^) (UIImage *selectedImage) )block
{
    return [[self alloc] initWithPhotoLibraryPickerWithCompletionBlock:block];
}



#pragma mark - Initializer
-(id) initWithPhotoLibraryPickerWithCompletionBlock:( void (^) (UIImage *selectedImage) )block
{
    self = [super init];
    if (self)
    {
        _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
        
        _completionBlock = block;
        
        self.delegate = self;
        
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return self;
}



#pragma mark - Trigger
-(void) show
{
    [[UIViewController topViewController] presentViewController:self animated:YES completion:^{
        
        
        
    }];
}



#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _completionBlock(selectedImage);
    
    if (self.wantsToDismissHandler)
    {
        self.wantsToDismissHandler();
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:YES];
            
        }];
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.wantsToDismissHandler)
    {
        self.wantsToDismissHandler();
    }
    else
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:YES];
            
        }];
    }
}

@end
