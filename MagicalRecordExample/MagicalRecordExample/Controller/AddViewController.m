//
//  AddViewController.m
//  MagicalRecordExample
//
//  Created by Mindy on 15/12/1.
//  Copyright © 2015年 Mindy. All rights reserved.
//

#import "AddViewController.h"
#import "CoreData+MagicalRecord.h"
#import "Track.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *trackNameField;
@property (weak, nonatomic) IBOutlet UITextField *artistNameField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)add:(id)sender {
    if([self.trackNameField.text isEqualToString:@""]|| [self.artistNameField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Track name and artist name can neither be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    /**Perform background save task**/
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        //C(reate) in CURD
        Track *track = [Track MR_createInContext:localContext];
        track.trackName = self.trackNameField.text;
        track.artistName = self.artistNameField.text;
    } completion:^(BOOL success, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
