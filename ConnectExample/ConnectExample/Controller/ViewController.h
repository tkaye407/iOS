//
//  ViewController.h
//  ConnectExample
//
//  Created by Sharma, Akhilesh on 6/16/16.
//  Copyright © 2016 Sharma, Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

