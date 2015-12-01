//
//  ViewController.m
//  MagicalRecordExample
//
//  Created by Mindy on 15/12/1.
//  Copyright © 2015年 Mindy. All rights reserved.
//

#import "ViewController.h"
#import "TrackCell.h"
#import "CoreData+MagicalRecord.h"
#import "Track.h"
#import "SyncWithiPodService.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *frc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)syncWithiPod:(id)sender {
    [SyncWithiPodService syncWithiPod];
}

#pragma mark - FRC
- (NSFetchedResultsController *)frc{
    if(!_frc){
        //Setup FRC in MR_defaultContext.
        //FRC is always used as the data source of a table view, so it's always set up in MR_defaultContext, which is of NSMainQueueConcurrencyType.
        _frc = [Track MR_fetchAllSortedBy:@"trackName" ascending:YES withPredicate:nil groupBy:nil delegate:self inContext:[NSManagedObjectContext MR_defaultContext]];
    }
    
    return _frc;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.frc.fetchedObjects count];
}

- (TrackCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *identifier = @"track";
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    Track *track = [self.frc objectAtIndexPath:indexPath];
    cell.trackNameLabel.text = track.trackName;
    cell.artistNameLabel.text = track.artistName;
    
    return cell;
}

@end
