//
//  PageDataManager.m
//  PageContrlVCDemo
//
//  Created by lotus on 2019/12/26.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "PageDataManager.h"

@interface PageDataManager ()

@property (nonatomic, strong) NSArray <NSString*> *pageData;
@end
@implementation PageDataManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDatas];
    }
    return self;
}

- (void)initDatas
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    self.pageData = formatter.monthSymbols;
}

- (DataViewController *)viewContrllerAtIndex:(NSInteger)index stroyBoard:(UIStoryboard *)storyboard
{
    if (self.pageData.count == 0 || index >= self.pageData.count) {
        return nil;
    }

    DataViewController *dataVC = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataVC.month = self.pageData[index];
    return dataVC;
}
- (NSInteger)indexOfViewController:(DataViewController *)viewController
{
    NSInteger index = [self.pageData indexOfObject:viewController.month];
    return index;
}

#pragma mark - UIPageViewControllerDataSource
/// 向前翻页调用，返回nil不能再向前翻页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }

    index -= 1;

    return [self viewContrllerAtIndex:index stroyBoard:viewController.storyboard];
}
/// 向后翻页调用，返回nil不能再向后翻页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }

    index += 1;
    if (index >= self.pageData.count) {
        return nil;
    }

    return [self viewContrllerAtIndex:index stroyBoard:viewController.storyboard];
}

///设置页码数
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return self.pageData.count;
//}
/////设置初始选中的页码点
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)UIPageViewController
//{
//    return 0;
//}
@end
