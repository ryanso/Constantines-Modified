//
//  TableViewCell.h
//  Foursquare2
//
//  Created by Ryan Sohlden on 11/20/14.
//
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *likesLbl;

@end
