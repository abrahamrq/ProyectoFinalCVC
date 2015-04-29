//
//  InfoViewController.m
//  ProyectoFinalCVC
//
//  Created by Michelle Juárez  on 29/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = @"http://cvc.mty.itesm.mx";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
