//
//  EventViewController.m
//  ProyectoFinalCVC
//
//  Created by Michelle Juárez  on 26/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "EventViewController.h"
#import <EventKit/EventKit.h>

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *p= self.summary;
    p =[p stringByReplacingOccurrencesOfString:@"&eacute;"
                                    withString:@"é"];
    p =[p stringByReplacingOccurrencesOfString:@"<br>"
                                    withString:@""];
    p =[p stringByReplacingOccurrencesOfString:@"&aacute;"
                                    withString:@"á"];
    p =[p stringByReplacingOccurrencesOfString:@"&iacute;"
                                    withString:@"í"];
    p =[p stringByReplacingOccurrencesOfString:@"&oacute;"
                                    withString:@"ó"];
    p =[p stringByReplacingOccurrencesOfString:@"&uacute;"
                                    withString:@"ú"];
    
    p =[p stringByReplacingOccurrencesOfString:@"&nbsp;"
                                    withString:@""];
    
    self.eventlbl.text = self.event;
    self.summarytextview.text = p;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToCalendar:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Confirm!"
                          message:@"Estas seguro de agregar?"
                          delegate: self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0)
    {
    }else if(buttonIndex == 1)
    {
        EKEventStore *store = [EKEventStore new];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = self.event;
            event.startDate = [NSDate date]; //today
            event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
            event.calendar = [store defaultCalendarForNewEvents];
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            
        }];
    }
    
}
@end
