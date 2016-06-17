//
//  ViewController.m
//  ConnectExample
//
//  Created by Sharma, Akhilesh on 6/16/16.
//  Copyright © 2016 Sharma, Akhilesh. All rights reserved.
//

#import "ViewController.h"
#import "ConnectExampleBaseModel.h"
#import "ConnectExampleFacade.h"
#import "ConnectExampleConstants.h"

@interface ViewController ()

@property (nonatomic,strong) ConnectExampleFacade *facade;
@property (nonatomic,strong) ConnectExampleBaseModel *baseModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeController];
}

//Basic Initialization
-(void) initializeController{
    
    //Tableview configuration
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.facade = (ConnectExampleFacade *)[ConnectExampleFacade sharedManager];
    
    __weak typeof(self) weakself = self;
    
    NSURL *urlObject = [NSURL URLWithString:BASE_URL];
    self.baseModel = [[ConnectExampleBaseModel alloc]init];
    
    [self.facade connectToService: urlObject
                        withBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            
                            if(error != nil) {
                                NSLog(@"%@",error.description);
                                NSLog(@"Error occured: Cannot get the data to display");
                            } else {
                                if (data != nil){
                                    
                                    NSArray *dataArray = (NSArray*)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    if (weakself.baseModel != nil) {
                                        weakself.baseModel.dataArray = dataArray;
                                        dispatch_sync(dispatch_get_main_queue(), ^{
                                            [weakself.tableView reloadData];
                                            [weakself.tableView setNeedsDisplay];
                                        });
                                    }
                                }
                            }
                            
                        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Tableview Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.baseModel.dataArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"TABLECELLID";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSInteger row = [indexPath row];
    
    if(self.baseModel.dataArray != nil){
        
        NSDictionary *dictionary = (NSDictionary *)[self.baseModel.dataArray objectAtIndex:row];
        
        NSString *titleValue = [dictionary objectForKey:RESPONSE_TITLE_KEY];
        NSString *bodyValue = [dictionary objectForKey:RESPONSE_BODY_KEY];
        
        UILabel *titleLabel = (UILabel *)[tableViewCell viewWithTag:TITLE_LABEL_TAG];
        UILabel *bodyLabel = (UILabel *) [tableViewCell viewWithTag:BODY_LABEL_TAG];
        
        titleLabel.text = titleValue;
        bodyLabel.text = bodyValue;
    }
    
    return tableViewCell;
}

@end
