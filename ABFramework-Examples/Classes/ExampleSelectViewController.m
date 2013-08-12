//
//  ExampleSelectViewController.m
//  ABFramework-Examples
//
//  Created by Alexander Blunck on 1/31/13.
//  Copyright (c) 2013 Ablfx. All rights reserved.
//

#import "ExampleSelectViewController.h"

//Data Model
#import "ExampleSection.h"
#import "ExampleObject.h"

//Example ViewControllers
#import "ABSwitchExample.h"
#import "ABSaveSystemExample.h"
#import "ABLabelExample.h"
#import "ABHudExample.h"
#import "ABNetworkingExample.h"
#import "ABViewExample.h"
#import "ABInfiniteViewExample.h"
#import "ABQuadMenuExample.h"
#import "ABRevealControllerExample.h"
#import "ABEntypoExample.h"
#import "ABWebControllerExample.h"

@interface ExampleSelectViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_sectionArray;
}
@end

@implementation ExampleSelectViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"ABFramework Examples";
    
    //Data Model
    _sectionArray = [NSMutableArray new];
    [self compileData];
    
    //TableView
    CGRect tableViewFrame = CGRectOffsetSizeHeight(self.view.bounds, (IS_MIN_IOS7) ? 0 : -44.0f);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}



#pragma mark - Helper
-(void) compileData
{
    //Components (Views)
    NSArray *componentsViewObjects = @[
                                  [ExampleObject objectWithName:@"ABSwitch" viewControllerClass:[ABSwitchExample class]],
                                  [ExampleObject objectWithName:@"ABLabel" viewControllerClass:[ABLabelExample class]],
                                  [ExampleObject objectWithName:@"ABHud" viewControllerClass:[ABHudExample class]],
                                  [ExampleObject objectWithName:@"ABInfiniteView" viewControllerClass:[ABInfiniteViewExample class]],
                                  [ExampleObject objectWithName:@"ABQuadMenu" viewControllerClass:[ABQuadMenuExample class]],
                                  [ExampleObject objectWithName:@"ABRevealController" viewControllerClass:[ABRevealControllerExample class]],
                                  [ExampleObject objectWithName:@"ABEntypoView /-Button" viewControllerClass:[ABEntypoExample class]],
                                  [ExampleObject objectWithName:@"ABWebController" viewControllerClass:[ABWebControllerExample class]]
                                  ];
    ExampleSection *componentsViewSection = [ExampleSection sectionWithName:@"Components (Views)" exampleObjectArray:componentsViewObjects];
    [_sectionArray addObject:componentsViewSection];
    
    
    //Components (Functional)
    NSArray *componentsFunctionalObjects = @[
                                       [ExampleObject objectWithName:@"ABSaveSystem" viewControllerClass:[ABSaveSystemExample class]],
                                       [ExampleObject objectWithName:@"ABNetworking" viewControllerClass:[ABNetworkingExample class]]
                                       ];
    ExampleSection *componentsFunctionalSection = [ExampleSection sectionWithName:@"Components (Funtional)" exampleObjectArray:componentsFunctionalObjects];
    [_sectionArray addObject:componentsFunctionalSection];
    
    
    //Subclasses
    NSArray *subclassesObjects = @[
                            [ExampleObject objectWithName:@"ABView" viewControllerClass:[ABViewExample class]]
                            ];
    ExampleSection *subclassesSection = [ExampleSection sectionWithName:@"Subclasses" exampleObjectArray:subclassesObjects];
    [_sectionArray addObject:subclassesSection];
}

-(ExampleObject*) exampleObjectForIndexPath:(NSIndexPath*)indexPath
{
    ExampleSection *exampleSection = [_sectionArray objectAtIndex:indexPath.section];
    return [exampleSection.exampleObjectArray objectAtIndex:indexPath.row];
}



#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[(ExampleSection*)[_sectionArray objectAtIndex:section] exampleObjectArray] count];
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ExampleSection *exampleSection = [_sectionArray objectAtIndex:section];
    return exampleSection.name;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ExampleObject *exampleObject = [self exampleObjectForIndexPath:indexPath];
    
    cell.textLabel.text = exampleObject.name;
    
    return cell;
}



#pragma mark - UITableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExampleObject *exampleObject = [self exampleObjectForIndexPath:indexPath];
    id viewController = [[exampleObject.viewControllerClass class] new];
    [(UIViewController*)viewController setTitle:exampleObject.name];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
