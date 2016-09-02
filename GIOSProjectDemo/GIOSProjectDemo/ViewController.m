//
//  ViewController.m
//  GIOSProjectDemo
//
//  Created by liufuyin on 15/8/21.
//  Copyright (c) 2015年 liufuyin. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "CommonDefine.h"
#import "HTTPSTest.h"
#import "WebVideoTest.h"

@interface ViewController ()

@property NSArray *styleTitles;

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.title = @"样式列表";
    
    self.tableView.rowHeight = 60.0f;
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.styleTitles = [[NSArray alloc] initWithObjects:@"HTTPS测试", @"WebVideo测试", nil];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.styleTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.styleTitles objectAtIndex:indexPath.section];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"HTTPS测试";
            
        case 1:
            return @"WebVideo测试"; ;
            
        default:
            return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            HTTPSTest *httpsTest = [[HTTPSTest alloc] init];
            [self.navigationController pushViewController:httpsTest animated:YES];
        }
            break;
        case 1:
        {
            WebVideoTest *videoTest = [[WebVideoTest alloc] init];
            [self.navigationController pushViewController:videoTest animated:YES];
        }
            break; 
    }
}

@end

