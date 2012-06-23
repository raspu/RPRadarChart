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
    rc.colors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor orangeColor],[UIColor purpleColor], [UIColor greenColor],nil];
    [self RND:nil];
    
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
    rc.dotRadius = 3;
}
-(IBAction)V2:(id)sender
{
    rc.backLineWidth = 1.5f;
    rc.frontLineWidth = 2.0f;
    rc.dotRadius = 4.5;
}
-(IBAction)showValues:(id)sender
{
    rc.showValues = !rc.showValues;
}

-(IBAction)GuideNumbers:(id)sender
{
    rc.showGuideNumbers = !rc.showGuideNumbers;
}

-(IBAction)GuideLines:(id)sender
{
    rc.drawGuideLines = !rc.drawGuideLines;
}

-(IBAction)Delegate:(UIButton *)sender;
{
    sender.selected = !sender.selected;
}


-(IBAction)RND:(id)sender
{
    int size = arc4random()%7 + 3;
    int num = arc4random()%4 + 1;
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:size];
    for (int j = 0; j<num; j++) 
    {
        NSMutableDictionary *tData = [[NSMutableDictionary alloc] initWithCapacity:size];
        for (int i = 0; i<size; i++) 
        {
            [tData setObject:[NSNumber numberWithFloat:arc4random()%1000] forKey:[NSString stringWithFormat:@"RND%i",arc4random()%100]];
        }
        [data setValue:tData forKey:[NSString stringWithFormat:@"DataSet-%d",j]];
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
