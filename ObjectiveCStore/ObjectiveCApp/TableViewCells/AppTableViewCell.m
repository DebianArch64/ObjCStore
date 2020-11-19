//
//  AppTableViewCell.m
//  ObjectiveCApp
//
//  Created by DebianArch on 11/18/20.
//

#import "AppTableViewCell.h"
#import "NewViewController.h"
@implementation AppTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)Action:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appURL]];
}
@end
