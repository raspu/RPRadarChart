//
//  RPRadarChart.m
//  RadarChart
//
//                       Radar Chart
//
//
//  Created by Juan Pablo Illanes Sotta (@raspum) on 06-06-12.
//  Copyright (c) 2012 Juan Pablo Illanes Sotta. All rights reserved.

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

//----------------
//
//          Simple RadrChart that displays the data containded in
//  NSDictionary. Expects Keys to be the Var Name (Edge Label) and the 
//  Object to be an NSNumber with float values.
//
//--------------- 

#import <float.h>
#import "RPRadarChart.h"

@interface RPRadarChart ()

-(void) drawChartInContext:(CGContextRef) cx withKey: (NSString *)key;

@end

@implementation RPRadarChart
@synthesize values, backLineWidth, frontLineWidth, lineColor, fillColor, dotColor, dotRadius, drawGuideLines,showGuideNumbers, colors,showValues;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        values = nil;
        maxSize = (frame.size.width>frame.size.height)  ? frame.size.width/2 - 25 : frame.size.height/2 - 25;
        backLineWidth = 1.0f;
        frontLineWidth = 2.0f;
        dotRadius = 3;
        drawGuideLines = YES;
        showGuideNumbers = YES;
        showValues = YES;
        lineColor = [UIColor redColor];
        dotColor = [UIColor redColor];
        fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    if(values == nil) return;
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(cx, self.frame.size.width/2, self.frame.size.height/2);
    [self drawBackGroundInContext:cx];
    if(hasMultiDataSet)
    {
        for (NSString *key in values) {
            [self drawChartInContext:cx withKey:key];
        }
    }else
        [self drawChartInContext:cx withKey:nil];
}

-(void) drawChartInContext:(CGContextRef) cx withKey: (NSString *)key
{
    CGContextSetLineWidth(cx, frontLineWidth);
    
    NSDictionary *d = (key == nil) ? values : [values objectForKey:key] ;
    
    UIColor *flColor = fillColor;
    UIColor *stColor = lineColor;
    UIColor *dtColor = dotColor;
    
    if(colors != nil && key != nil)
    {
        int idx = [[values allKeys] indexOfObject:key];
        stColor = dtColor = [colors objectAtIndex:idx%[colors count]];
        flColor = [dtColor colorWithAlphaComponent:0.2];
    }
    
    float mvr = (2*M_PI) / [d count];
    float fx =0;
    float fy =0;
    int mi = 0;
    //DRAW LINES
    CGMutablePathRef path = CGPathCreateMutable();
    for (NSString *ky in d)
    {
        float v = ([[d objectForKey:ky] floatValue] / maxValue) * maxSize;
        float a = (mvr * mi) - M_PI_2;
        float x = v * cos(a);
        float y = v * sin(a);
        
        if(fx == 0 && fy == 0)
        {
            CGPathMoveToPoint(path, NULL, x, y);
            fx = x;
            fy = y;
        }else
            CGPathAddLineToPoint(path, NULL, x,  y);
        mi++;
    }    
    CGPathAddLineToPoint(path, NULL, fx, fy);
    CGContextAddPath(cx, path);
    CGContextSetFillColorWithColor(cx, flColor.CGColor);
    CGContextFillPath(cx);
    CGContextSetStrokeColorWithColor(cx, stColor.CGColor);
    CGContextAddPath(cx, path);
    CGContextStrokePath(cx);
    
    //DRAW VALUES
    
    mi= 0;
    for (NSString *ky in d)
    {
        float v = ([[d objectForKey:ky] floatValue] / maxValue) * maxSize;
        float a = (mvr * mi) - M_PI_2;
        float x = v * cos(a);
        float y = v * sin(a);
        
        CGContextSetFillColorWithColor(cx, dtColor.CGColor);
        CGContextFillEllipseInRect(cx, CGRectMake(x-dotRadius, y-dotRadius, dotRadius*2, dotRadius*2));
        if(showValues)
        {
            NSString *str = [NSString stringWithFormat:@"%1.0f",[[d objectForKey:ky] floatValue]];
            x += 5;
            y -= 7;     
            CGContextSetFillColorWithColor(cx, [UIColor blackColor].CGColor);
            [str drawAtPoint:CGPointMake(x, y) withFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        }
        mi++;
    }    
    
    
}

-(void) drawBackGroundInContext:(CGContextRef) cx
{
    CGContextSetLineWidth(cx, backLineWidth);
    
    NSDictionary *d = (!hasMultiDataSet) ? values : [[values allValues] objectAtIndex:0];

    float mvr = (2*M_PI) / [d count];
    float spcr = maxSize / 4;
    
    //Index Lines
    if(drawGuideLines)
    {
        CGContextSetStrokeColorWithColor(cx, [UIColor colorWithWhite:0.8 alpha:1].CGColor);
        
        for (int j = 0; j<=4; j++) 
        {
             float cur = j*spcr;
            CGContextStrokeEllipseInRect(cx, CGRectMake(-cur, -cur, cur*2, cur*2));
        }
        
//Straight Lines...
//        for (int j = 0; j<=4; j++) {
//            float cur = j*spcr;
//            float x = cur * cos(-mvr - M_PI_2);
//            float y = cur * sin(-mvr - M_PI_2);
//            CGContextMoveToPoint(cx, x, y);
//            for (int i = 0; i < [d count]; i++)
//            {
//                float a = (mvr * i) - M_PI_2;
//                float x = cur * cos(a);
//                float y = cur * sin(a);
//                CGContextAddLineToPoint(cx, x , y);            
//            }
//        }
//-------------------------------
            CGContextStrokePath(cx);
    }
    //Base lines
    CGContextSetStrokeColorWithColor(cx, [UIColor darkGrayColor].CGColor);
    for (int i = 0; i < [d count]; i++)
    {
        float a = (mvr * i) - M_PI_2;
        float x = maxSize * cos(a);
        float y = maxSize * sin(a);
        CGContextMoveToPoint(cx, 0, 0);
        CGContextAddLineToPoint(cx, x , y);
        
        CGContextStrokePath(cx);
        
        
        NSString *tx = [[d allKeys] objectAtIndex:i];
        CGSize s =[tx sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        x-= s.width/2;
        y += (y>0) ? 10 : -20;        
        
        [tx drawAtPoint:CGPointMake(x, y) withFont: [UIFont fontWithName:@"Helvetica-Bold" size:12]];
        
        //THIS DIDN'T WORK GOOD ENOUGH
        /*CGContextSaveGState(cx);
         CGContextTranslateCTM(cx, ct.x, ct.y);
         CGContextConcatCTM(cx, CGAffineTransformMakeRotation( a + M_PI_2 ));
         a = (mvr * i) - a  + 2*M_PI_2 ;
         x = (maxSize+20) * cos(a);
         y = (maxSize+20) * sin(a);
         [[[d allKeys] objectAtIndex:i] drawAtPoint:CGPointMake( x, y) withFont: [UIFont fontWithName:@"Helvetica" size:10]];
         CGContextRestoreGState(cx);*/
        
    }
    
    //Index Texts
    if(showGuideNumbers)
    {
        for(float i = spcr; i <= maxSize; i+=spcr)
        {        
            NSString *str = [NSString stringWithFormat:@"%1.0f",( i * maxValue) / maxSize];
            CGSize s = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12]];
            float x = i * cos(M_PI_2) + 5 + s.width;
            float y = i * sin(M_PI_2) + 5;
            CGContextSetFillColorWithColor(cx, [UIColor darkGrayColor].CGColor);
            [str drawAtPoint:CGPointMake(- x, - y) withFont: [UIFont fontWithName:@"Helvetica" size:12]];
        }
    }
    
}

#pragma mark - Setters


-(void) setValues:(NSDictionary *)val
{
    values = val;
    maxValue = -1;
    minValue = FLT_MAX; 
    for (NSString *ky in values) {
        if([[[values objectForKey:ky] class] isSubclassOfClass:[NSDictionary class]])
        {
            hasMultiDataSet = YES;
            for (NSString *k in [values objectForKey:ky])
            {
                float v = [[[values objectForKey:ky] objectForKey:k] floatValue];
                if(maxValue < v)
                    maxValue = v;
                if(minValue > v)
                    minValue = v;
            }
        }else
        {
            float v = [[values objectForKey:ky] floatValue];
            if(maxValue < v)
                maxValue = v;
            if(minValue > v)
                minValue = v;
        }
    }
    maxValue += (maxValue - minValue)/10;
    [self setNeedsDisplay];
}

-(void) setLineColor:(UIColor *)v
{ 
    lineColor = v;
    [self setNeedsDisplay];
    
}

-(void) setFillColor:(UIColor *)v
{ 
    fillColor = v;
    [self setNeedsDisplay];
    
}
-(void) setBackLineWidth:(float)v
{ 
    backLineWidth = v;
    [self setNeedsDisplay];    
}

-(void) setFrontLineWidth:(float)v
{ 
    frontLineWidth = v;
    [self setNeedsDisplay];    
}

-(void) setDotColor:(UIColor *)v
{ 
    dotColor = v;
    [self setNeedsDisplay];    
}

-(void) setDotRadius:(float) v
{ 
    dotRadius = v;
    [self setNeedsDisplay];    
}

-(void) setShowValues:(BOOL)v
{
    showValues = v;
    [self setNeedsDisplay];
}

-(void) setDrawGuideLines:(BOOL)v
{
    drawGuideLines = v;
    [self setNeedsDisplay];
}

-(void) setShowGuideNumbers:(BOOL)v
{
    showGuideNumbers = v;
    [self setNeedsDisplay];
}

@end
