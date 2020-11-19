//
//  AppTableViewCell.h
//  ObjectiveCApp
//
//  Created by DebianArch on 11/18/20.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *appName;
@property (strong, nonatomic) IBOutlet UIImageView *appImage;
@property (strong, nonatomic) NSString *appURL;
- (IBAction)Action:(id)sender;


@end

NS_ASSUME_NONNULL_END
