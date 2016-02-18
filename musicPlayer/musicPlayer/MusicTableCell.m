//
//  TableCell.m
//  musicPlayer
//
//  Created by king on 15/12/3.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "MusicTableCell.h"
#import "ViewController.h"


@interface MusicTableCell ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UISearchBarDelegate>

@property (nonatomic,strong) ViewController *palyController;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSArray *resultArray;//存放搜索结果的数组
@property (nonatomic) BOOL isSearching;//搜索状态
@property (nonatomic,strong) UITableView *tableView;
@end

static NSString *identifier = @"cell";

@implementation MusicTableCell


//懒加载数据
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    //self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.title = @"歌曲列表";
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
    
    self.tableView.tableHeaderView = _searchBar;
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索本地歌曲";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearching) {
        return self.resultArray.count;
    } else {
        return self.mutableArray.count;
    }
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isSearching) {
        Models *model1 = self.resultArray[indexPath.row];
        cell.model = model1;
    }else{
        Models *model2 = self.mutableArray[indexPath.row];
        cell.model = model2;
    }
   
    
           return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    _palyController = [[ViewController alloc] init];
    if (_isSearching) {
        _palyController.model = self.resultArray[indexPath.row];
        [_palyController setValue:_palyController.model forKeyPath:@"model"];

    }else{
    _palyController.model = self.mutableArray[indexPath.row];
    [_palyController setValue:_palyController.model forKeyPath:@"model"];
    [_palyController setValue:@(indexPath.row) forKeyPath:@"integer"];
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;

    [self.navigationController pushViewController:_palyController animated:YES];
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    searchBar.text =nil;
    _isSearching = NO;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        _isSearching = NO;
        [self.tableView reloadData];
        return;
    }
    _isSearching = YES;
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"SELF.musicName CONTAINS[cd] %@",searchText];
    _resultArray = [self.mutableArray filteredArrayUsingPredicate:predict];
    [self.tableView reloadData];
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
