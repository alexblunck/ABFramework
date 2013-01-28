//
//  ABImagePickerViewController.m
//  ABFramework
//
//  Created by Alexander Blunck on 10/30/12.
//  Copyright (c) 2012 Ablfx. All rights reserved.
//

#import "ABImagePickerViewController.h"

@interface ABImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    void (^completionBlock) (UIImage *selectedImage);
}
@end

@implementation ABImagePickerViewController

-(id) initWithPhotoLibraryPickerWithCompletionBlock:( void (^) (UIImage *selectedImage) )block {
    self = [super init];
    if (self) {
        
        completionBlock = block;
        
        self.delegate = self;
        
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    return self;
}

+(id) photoLibraryPickerWithCompletionBlock:( void (^) (UIImage *selectedImage) )block {
    return [[self alloc] initWithPhotoLibraryPickerWithCompletionBlock:block];
}

-(void) show {
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:self animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    completionBlock(selectedImage);
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

@end
