//
//  ABImagePickerViewController.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/30/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABImagePickerViewController.h"

@interface ABImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
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
    if (self) {
        
        _completionBlock = block;
        
        self.delegate = self;
        
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    return self;
}



#pragma mark - Trigger
-(void) show {
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:self animated:YES];
}



#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _completionBlock(selectedImage);
    
    [picker dismissModalViewControllerAnimated:YES];
}

@end
