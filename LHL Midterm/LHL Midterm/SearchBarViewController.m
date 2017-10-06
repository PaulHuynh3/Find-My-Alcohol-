//
//  SearchBarViewController.m
//  LHL Midterm
//
//  Created by Paul on 2017-10-05.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "SearchBarViewController.h"
#import "SearchViewCell.h"
#import "DetailedViewController.h"
#import "NetworkRequest.h"
#import "AllProducts.h"

@interface SearchBarViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *productsArray;

@property (nonatomic) NSArray *filteredData;

@property (nonatomic) UISearchController *searchController;

@end


@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NetworkRequest queryForAllProducts:^(NSArray<AllProducts *>* results) {
            self.productsArray = results;
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
    }];
    
    [self setupSearchController];
}
//programmatically setting up search controller.
- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    
    // adds search bar to tableView header area
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.searchController.active){
    return self.filteredData.count;
    }
    return self.productsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchViewCell *SVC = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (self.searchController.active) {
        // setup cell when searching
        SVC.allProducts = self.filteredData[indexPath.row];
        return SVC;
    }
    
    SVC.allProducts = self.productsArray[indexPath.row];

    return SVC;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   if (self.searchController.active){
      if ([segue.identifier isEqualToString:@"DetailedView"]){
        DetailedViewController *dvc = segue.destinationViewController;
        dvc.allProducts = self.filteredData[self.tableView.indexPathsForSelectedRows[0].row];
    }
    } else if ([segue.identifier isEqualToString:@"DetailedView"]){
        DetailedViewController *dvc = segue.destinationViewController;
        dvc.allProducts = self.productsArray[self.tableView.indexPathsForSelectedRows[0].row];
    }
    
}

#pragma mark - UISearchResultUpdating Protocol method

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchText = searchController.searchBar.text;
    //predicate can use self.name, self.origin, self.productID to sort the search bar.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@", searchText];
    self.filteredData = [self.productsArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
    
}




@end
