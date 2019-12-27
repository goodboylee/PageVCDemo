//
//  ViewController.m
//  PageVCDemo
//
//  Created by lotus on 2019/12/26.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "ViewController.h"
#import "PageDataManager.h"


@interface ViewController ()<UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageManagerVC;
@property (nonatomic, strong) PageDataManager *modelVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)setup
{
    self.pageManagerVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageManagerVC.delegate = self;
    DataViewController *startingVC = [self.modelVC viewContrllerAtIndex:0 stroyBoard:self.storyboard];
    [self.pageManagerVC setViewControllers:@[startingVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageManagerVC.dataSource = self.modelVC;

    [self addChildViewController:self.pageManagerVC];
    [self.view addSubview:self.pageManagerVC.view];
    CGRect pageViewRect = self.view.bounds;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40, 40);
    }

    self.pageManagerVC.view.frame = pageViewRect;
    [self.pageManagerVC didMoveToParentViewController:self];

}

#pragma mark - UIPageViewControllerDelegate
///设置不同屏幕方向的书脊位置
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    //如果当前设备是iphone，屏幕方向为垂直方向，返回书籍为左侧或上侧
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        DataViewController *currentVC = self.pageManagerVC.viewControllers[0];
        [self.pageManagerVC setViewControllers:@[currentVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {

        }];

        self.pageManagerVC.doubleSided = NO;

        return UIPageViewControllerSpineLocationMin;
    }

    //如果不是iphone且设备的方向为水平方向
    DataViewController *currentVC = self.pageManagerVC.viewControllers[0];
    //获取当前所在的页号
    NSInteger indexOfCurrentVC = [self.modelVC indexOfViewController:currentVC];
    NSArray <DataViewController *>*vcs = @[currentVC];
    //如果为偶数
    if (indexOfCurrentVC == 0 || indexOfCurrentVC % 2 == 0) {
        DataViewController *nextVC = (DataViewController *)[self.modelVC pageViewController:self.pageManagerVC viewControllerAfterViewController:currentVC];
        //添加下一个视图控制器
        vcs = @[currentVC , nextVC];
    }
    //如果为奇数
    else {
        //添加上一个视图控制器
        DataViewController *preVC = (DataViewController *)[self.modelVC pageViewController:self.pageManagerVC viewControllerBeforeViewController:currentVC];
        vcs = @[preVC, currentVC];
    }


    [self.pageManagerVC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {

    }];
    self.pageManagerVC.doubleSided = YES;

    //返回书脊在中间
    return UIPageViewControllerSpineLocationMid;

}

#pragma mark - getter
- (PageDataManager *)modelVC
{
    if (!_modelVC) {
        _modelVC = [[PageDataManager alloc] init];
    }

    return _modelVC;
}

@end
