//
//  ViewController.m
//  RadarChart
//
//  Created by Juan Pablo Illanes Sotta on 06-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    rc = [[RPRadarChart alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    rc.backgroundColor = [UIColor whiteColor];
    [rc setValues:[NSDictionary dictionaryWithObjectsAndKeys:
                   [NSNumber numberWithFloat:10.0f],@"FIRST",
                   [NSNumber numberWithFloat:20.0f],@"SECOND",
                   [NSNumber numberWithFloat:30.0f],@"THIRD",
                   [NSNumber numberWithFloat:40.0f],@"FOURTH",
                   [NSNumber numberWithFloat:50.0f],@"FIFTH",
                   [NSNumber numberWithFloat:60.0f],@"SIXTH",
                   [NSNumber numberWithFloat:70.0f],@"SEVENTH",
                   [NSNumber numberWithFloat:80.0f],@"EIGHT",
                   
                   nil]];
    [self.view addSubview:rc];
    
}

-(IBAction)blue:(UIButton *)sender
{
    if([sender.titleLabel.text  isEqualToString:@"BLUE"])
    {
        rc.lineColor = [UIColor blueColor];
        rc.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
        rc.dotColor = [UIColor blueColor];
        [sender setTitle:@"RED" forState:UIControlStateNormal];
    }else {
        rc.lineColor = [UIColor redColor];
        rc.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        rc.dotColor = [UIColor redColor];
        [sender setTitle:@"BLUE" forState:UIControlStateNormal];

    }
}
-(IBAction)V1:(id)sender
{
    rc.backLineWidth = 0.5f;
    rc.frontLineWidth = 1.5f;
    rc.drawGuideLines = YES;
    rc.showGuideNumbers = NO;
    rc.dotRadius = 3;
}
-(IBAction)V2:(id)sender
{
    rc.backLineWidth = 1.5f;
    rc.frontLineWidth = 2.0f;
    rc.drawGuideLines = NO;
    rc.showGuideNumbers = YES;
    rc.dotRadius = 4;
}

-(IBAction)RND:(id)sender
{
    int size = arc4random()%15 + 3;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:size];
    
    for (int i = 0; i<size; i++) 
    {
        [data setObject:[NSNumber numberWithFloat:arc4random()%1000] forKey:[NSString stringWithFormat:@"RND%i",arc4random()%100]];
    }
    
    rc.values = data;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
