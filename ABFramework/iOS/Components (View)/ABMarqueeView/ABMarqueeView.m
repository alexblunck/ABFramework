//
//  ABMarqueeView.m
//  
//
//  Created by Alexander Blunck on 21/04/14.
//
//

#import "ABMarqueeView.h"

@interface ABMarqueeView ()
{
    UILabel *_label;
}
@end



@implementation ABMarqueeView

#pragma mark - Initializer
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


#pragma mark - LifeCycle
-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.backgroundColor = [UIColor greenColor];
    
    _label = [[UILabel alloc] initWithFrame:cgr(0, 0, 0, self.height)];
    [self addSubview:_label];
}



#pragma mark - Accessors
#pragma mark - Accessors - UILabel Interface
-(void) setText:(NSString *)text
{
    _text = text;
}

@end














