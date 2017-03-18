//
//  SWPSTwitterCell.h
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWPSTwitterCell.h"





@interface SWPSTwitterCell()
{
}

@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *primaryLabel;
@property (strong, nonatomic) UILabel *secondaryLabel;

@end





@implementation SWPSTwitterCell

- (instancetype)initWithStyle:(int)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:(int)UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		
		UIImage *profileImage = [UIImage imageWithContentsOfFile:specifier.properties[@"imagePath"]];
		self.profileImageView = [[UIImageView alloc] initWithImage:profileImage];
		if (!profileImage) {
			self.profileImageView.backgroundColor = [UIColor blackColor];
		}
		
		self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
		
		self.primaryLabel = [[UILabel alloc] init];
		self.primaryLabel.text = [NSString stringWithFormat:@"%@%@", @"@", specifier.properties[@"username"]];
		self.primaryLabel.textColor = [UIColor blackColor];
		self.primaryLabel.backgroundColor = [UIColor clearColor];
		self.secondaryLabel = [[UILabel alloc] init];
		self.secondaryLabel.text = specifier.properties[@"secondaryText"];
		self.secondaryLabel.textColor = [UIColor blackColor];
		self.secondaryLabel.backgroundColor = [UIColor clearColor];
		
		[self addSubview:self.profileImageView];
		[self addSubview:self.primaryLabel];
		[self addSubview:self.secondaryLabel];
		
		[self layoutSubviews];
	}

	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	CGFloat imageSize = self.frame.size.height * 0.80;
    
    CGRect newFrame = self.profileImageView.frame;
    newFrame.size = CGSizeMake(imageSize, imageSize);
    newFrame.origin.x = 15;
    self.profileImageView.frame = newFrame;
    self.profileImageView.center = CGPointMake(self.profileImageView.center.x, CGRectGetMidY(self.bounds));
	
	self.primaryLabel.font = [UIFont systemFontOfSize:self.frame.size.height / 5];
	[self.primaryLabel sizeToFit];
    newFrame = self.primaryLabel.frame;
    newFrame.origin =  CGPointMake(self.profileImageView.frame.origin.x + self.profileImageView.frame.size.width + 5,
                                   self.profileImageView.center.y - self.primaryLabel.frame.size.height - 5);
    self.primaryLabel.frame = newFrame;
	
	self.secondaryLabel.font = [UIFont systemFontOfSize:self.frame.size.height / 5];
	[self.secondaryLabel sizeToFit];
    newFrame = self.secondaryLabel.frame;
    newFrame.origin = CGPointMake(self.profileImageView.frame.origin.x + self.profileImageView.frame.size.width + 5,
                                  self.profileImageView.center.y + 5);
    self.secondaryLabel.frame = newFrame;
}

+ (void)performActionWithSpecifier:(PSSpecifier *)specifier
{
    if (!specifier.properties[@"username"]) {
        return;
    }
    
//    NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"tweetbot:///user_profile/", specifier.properties[@"username"]]];
//    NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"twitter://user?screen_name=", specifier.properties[@"username"]]];
    
//    if ([[UIApplication sharedApplication] canOpenURL:tweetbotURL]) {
//        [[UIApplication sharedApplication] openURL:tweetbotURL];
//        return;
//    } else if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
//        [[UIApplication sharedApplication] openURL:twitterURL];
//        return;
//    }
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
//                                                                     @"https://twitter.com/",
//                                                                     specifier.properties[@"username"]]]];
}

@end




