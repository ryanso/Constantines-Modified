//
//  SearchViewController.m
//  Foursquare2
//
//  Created by Constantine Fry on 16/02/14.
//
//

#import "SearchViewController.h"
#import "FSVenue.h"
#import "Foursquare2.h"
#import "FSConverter.h"
#import "TableViewCell.h"

@interface SearchViewController ()
<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, weak) NSOperation *lastSearchOperation;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *category = @"4d4b7104d754a06370d81259";
    [self startSearchWithString:category];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self startSearchWithString:searchText];
}

- (void)startSearchWithString:(NSString *)string {
    [self.lastSearchOperation cancel];
    self.lastSearchOperation = [Foursquare2
        venueSearchNearLocation:@"Chicago" query:nil limit:nil intent:intentCheckin radius:nil categoryId:string
                                     callback:^(BOOL success, id result){
            if (success) {
                NSDictionary *dic = result;
                NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                FSConverter *converter = [[FSConverter alloc] init];
                self.venues = [converter convertToObjects:venues];
                [self.tableView reloadData];
            } else {
                NSLog(@"%@",result);
            }
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.venues[indexPath.row] name];
    return cell;
}

- (IBAction)doneButtonTapped:(id)sender {
    [self.lastSearchOperation cancel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
