//
//  SWPSListControllerHeaderView.m
//  libsw
//
//  Created by Pat Sluth on 2015-05-02.
//
//

#import "SWPSListControllerHeaderView.h"





@interface SWPSListControllerHeaderView()
{
}

@property (readwrite, strong, nonatomic) UIImageView *icon;
@property (readwrite, strong, nonatomic) UILabel *label;

@end





@implementation SWPSListControllerHeaderView

#pragma mark - Init

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        self.contentMode = UIViewContentModeScaleToFill;
        
        self.backgroundColor = [UIColor clearColor];
        
        if (self.icon) {}
        if (self.label) {}
        
    }
    
    return self;
}

- (UIImageView *)icon
{
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _icon.clipsToBounds = YES;
        _icon.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_icon];
        
    }
    
    return _icon;
}

- (UILabel *)label
{
    if (!_label) {
        
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        
        [self addSubview:_label];
        
    }
    
    return _label;
}

#pragma mark - Override

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
    
    //icon
    CGRect newFrame = self.icon.frame;
    newFrame.size = CGSizeMake(self.bounds.size.height / 2.5, self.bounds.size.height / 2.5);
    self.icon.frame = newFrame;
    self.icon.center = CGPointMake(CGRectGetMidX(self.bounds), self.icon.center.y);

    //label
    self.label.font = [UIFont systemFontOfSize:self.frame.size.height / 5];
    [self.label sizeToFit];
    newFrame = self.label.frame;
    newFrame.origin.y = self.bounds.size.height - self.label.bounds.size.height - 10; //10 padding
    self.label.frame = newFrame;
    self.label.center = CGPointMake(CGRectGetMidX(self.bounds), self.label.center.y);
    
    //icon again
    newFrame = self.icon.frame;
    newFrame.origin.y = self.label.frame.origin.y - self.icon.bounds.size.height;
    self.icon.frame = newFrame;
}

@end




