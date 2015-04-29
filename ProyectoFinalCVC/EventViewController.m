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
    self.summary=p;
    
    if([[self.summary substringWithRange:NSMakeRange(0, 17)] isEqualToString:@"Evento recurrente"])
        self.addbutton.enabled = NO;
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
                          initWithTitle:@"Agregar Evento"
                          message:@"Estas seguro de que quieres agregarlo a tu calendario?"
                          delegate: self
                          cancelButtonTitle:@"NO"
                          otherButtonTitles:@"SI", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0)
    {
    }else if(buttonIndex == 1)
    {
        NSString *isNUM=[self.summary substringWithRange:NSMakeRange(22, 5)];;
        
         if( ![[NSScanner scannerWithString: isNUM] scanFloat:NULL] ){
             NSString *eventI;
             NSString *helper;
             if ([[self.summary substringWithRange:NSMakeRange(8,3)] isEqualToString:@" "]){
                 eventI=[self.summary substringWithRange:NSMakeRange(7, 16)];
                 
                 helper=[eventI substringWithRange:NSMakeRange(5, 11)];
             }
             else{
                 eventI=[self.summary substringWithRange:NSMakeRange(7, 15)];
                 
                 helper=[eventI substringWithRange:NSMakeRange(5, 10)];
             }
                 
             helper =[helper stringByReplacingOccurrencesOfString:@" "
                                                       withString:@"-"];
             
             
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
             [dateFormatter setLocale:locale];
             [dateFormatter setDateFormat:@"d-MMM-yyyy"];
             
             NSDate *myDate = [dateFormatter dateFromString:helper];
             EKEventStore *store = [EKEventStore new];
             [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                 if (!granted) { return; }
                 EKEvent *event = [EKEvent eventWithEventStore:store];
                 event.title = self.event;
                 event.startDate = myDate;
                 event.endDate = [event.startDate dateByAddingTimeInterval:60*60];
                 event.calendar = [store defaultCalendarForNewEvents];
                 NSError *err = nil;
                 [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                 
             }];
             
         }else{
        NSString *eventI=[self.summary substringWithRange:NSMakeRange(7, 22)];
        NSString *eventA;
        if( [[NSScanner scannerWithString:[self.summary substringWithRange:NSMakeRange(32, 5)]] scanFloat:NULL] ){
            eventA=[self.summary substringWithRange:NSMakeRange(32, 5)];
            NSString *eventH=[eventI substringWithRange:NSMakeRange(0, 17)];
            eventA=[NSString stringWithFormat:@"%@ %@", eventH, eventA];
        }else{
            eventA=[self.summary substringWithRange:NSMakeRange(31, 22)];
        }
        NSString *helper=[eventI substringWithRange:NSMakeRange(5, 11)];
        helper =[helper stringByReplacingOccurrencesOfString:@" "
                                        withString:@"-"];
        
        NSString *helper2=[eventI substringWithRange:NSMakeRange(16,6)];
        eventI=[NSString stringWithFormat:@"%@ %@", helper, helper2];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
        [dateFormatter setLocale:locale];
        [dateFormatter setDateFormat:@"d-MMM-yyyy HH:mm"];
        
        helper=[eventA substringWithRange:NSMakeRange(5, 11)];
        helper =[helper stringByReplacingOccurrencesOfString:@" "
                                                  withString:@"-"];
        
        helper2=[eventA substringWithRange:NSMakeRange(16,6)];
        eventA=[NSString stringWithFormat:@"%@ %@", helper, helper2];
        
        NSDate *myDate = [dateFormatter dateFromString:eventI];
        NSDate *myDate2 = [dateFormatter dateFromString:eventA];

       // NSDate *dateI = [dateFormat dateFromString:eventI];
        //NSDate *dateA = [dateFormat dateFromString:eventA];
        
        EKEventStore *store = [EKEventStore new];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = self.event;
            event.startDate = myDate;
            event.endDate = myDate2;
            event.calendar = [store defaultCalendarForNewEvents];
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            
        }];
    }
    }
    
}
@end
