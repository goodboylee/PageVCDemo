//
//  DataViewController.m
//  PageContrlVCDemo
//
//  Created by lotus on 2019/12/26.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@end

@implementation DataViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setupSubviews
{
    self.titleLb.text = self.month;

}


@end
