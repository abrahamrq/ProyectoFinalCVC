//
//  EventViewController.h
//  ProyectoFinalCVC
//
//  Created by Michelle Juárez  on 26/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController

@property(strong, nonatomic) NSString *event;
@property(strong, nonatomic) NSString *summary;
@property (strong, nonatomic) IBOutlet UILabel *eventlbl;
@property (strong, nonatomic) IBOutlet UITextView *summarytextview;
- (IBAction)addToCalendar:(id)sender;

@end
