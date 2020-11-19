//
//  NewViewController.m
//  ObjectiveCApp
//
//  Created by DebianArch on 11/17/20.
//

#import "NewViewController.h"
#import "JSON.h"
#import "AppTableViewCell.h"
#import <SDWebImage/SDWebImage.h>


@interface NewViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (strong, nonatomic) NSString *appURL;

@property (strong, nonatomic) NSMutableArray <JSON *> *datas;

@end

@implementation NewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
    [self.loadingIndicator startAnimating];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.loadingView.hidden = NO;

   
    
    
    // Do any additional setup after loading the view.
}

-(void)stopLoading {
    [self.loadingIndicator stopAnimating];
    self.loadingView.hidden = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    
    
   
    
    JSON *data = self.datas[indexPath.row];
   
    cell.appURL = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=https://eonhubapp.com/plists/%@.plist", data.plist];
    cell.appName.text = data.name;
    [cell.appImage sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://app.eonhubapp.com/images/icons/%@", data.icon]]];
    
  
    tableView.separatorStyle = 0;
    cell.selectionStyle = 0;
   
    return cell;
}



- (void) fetchData {
    
    NSURL *url = [NSURL URLWithString:@"https://eonhubapp.com/all.json"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        
        NSError *err;
       NSArray *jsonDATA = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Error: %@", err);
            return;
        }
        
        NSMutableArray<JSON *> *datas = NSMutableArray.new;
        for (NSDictionary *jsonDict in jsonDATA) {
            
            NSString *name = jsonDict[@"name"];
            NSString *icon = jsonDict[@"icon"];
            NSString *plist = jsonDict[@"plist"];
            JSON *data = JSON.new;
            data.name = name;
            data.icon = icon;
            data.plist = plist;
            
            [datas addObject:data];
            
        }
        
        self.datas = datas;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self stopLoading];
        });
        
        }] resume];
}


@end
