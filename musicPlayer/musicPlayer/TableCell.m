//
//  TableCell.m
//  musicPlayer
//
//  Created by king on 15/12/3.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "TableCell.h"
#import "Models.h"
#import "ViewController.h"

@interface TableCell ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) ViewController *palyController;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,strong) Models *frontMoedl;

@end

@implementation TableCell

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    self.navigationController.delegate = self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.title = @"歌曲列表";
    
       //self.navigationController.navigationBar.translucent = NO;
               // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    ViewController *viewController1 = [[ViewController alloc] init];
    viewController1.model = _frontMoedl;
    void (^changeValue) (Models *modelValue) = ^(Models *modelValue)
    {
        _frontMoedl = modelValue;
    };
}

- (NSMutableArray *)mutableArray
{
    if (_mutableArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"musicRecource" ofType:@"plist"];
        NSArray *arrar = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *musicMutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arrar) {
            Models *model = [[Models alloc] initWithMusics:dict];
            [musicMutableArray addObject:model];
        }
        _mutableArray = musicMutableArray;
    }
    
    return _mutableArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.mutableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    _frontMoedl = [[Models alloc] init];
    _frontMoedl = _mutableArray[indexPath.row];
    
    cell.textLabel.text = _frontMoedl.musicName;
       return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
        _palyController = [[ViewController alloc] init];
    
    [self.navigationController pushViewController:_palyController animated:YES];
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
