//
//  tableViewCell.h
//  StackOverFlow
//
//  Created by Aman Jain on 31/08/15.
//  Copyright (c) 2015 Aman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *postview;
@property (nonatomic, weak) IBOutlet UILabel *answercount;

@end
