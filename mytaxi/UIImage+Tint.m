//
//  UIImage+Tint.m
//  mxtaxi
//
//  Created by Johann Werner on 25.06.17.
//  Copyright © 2017 Johann Werner. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)tintedImage:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
/*
 While the context created by this function is the current context, you can call the 
    UIGraphicsGetImageFromCurrentImageContext function to retrieve an
    image object based on the current contents of the context. 
 When you are done modifying the context, you must call the UIGraphicsEndImageContext function
 to clean up the bitmap drawing environment and remove the graphics context from the top of the 
 context stack. You should not use the UIGraphicsPopContext function
 to remove this type of context from the stack.
 */
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*Returns the current graphics context.
     
     The current graphics context is nil by default. Prior to calling its drawRect: method, view objects
     push a valid context onto the stack, making it current.
     If you are not using a UIView object to do your drawing, however, you must push a valid context onto the stack manually
     using the UIGraphicsPushContext function.

     
     */
    
    CGContextTranslateCTM(context, 0, self.size.height);//Image is not visible IR
    /*Changes the origin of the user coordinate system in a context.
     
     c
     A graphics context.
     tx
     The amount to displace the x-axis of the coordinate space, in units of the user space, of the specified context.
     ty
     The amount to displace the y-axis of the coordinate space, in units of the user space, of the specified context.
*/
    
    CGContextScaleCTM(context, 1.0, -1.0); //Image is not visible IR
/*
 Changes the scale of the user coordinate system in a context.
 Parameters
 c
 A graphics context.
 sx
 The factor by which to scale the x-axis of the coordinate space of the specified context.
 sy
 The factor by which to scale the y-axis of the coordinate space of the specified context.
*/
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // kCGBlendModeNormal Paints the source image samples over the background image samples.
    
    // draw black background to preserve color of transparent pixels
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
    //Sets how sample values are composited by a graphics context.
    
//    [[UIColor blackColor] setFill];
//    CGContextFillRect(context, rect);
    /*Paints the area contained within the provided rectangle, using the fill color in the current graphics state.
     The current path is cleared as a side effect of calling this function.
     */
    
    // draw original image
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);
    /*Draws an image into a graphics context.
     The image is scaled—disproportionately, if necessary—to fit the bounds specified by the rect parameter.
     */
    
    // color over image with tint color
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);// R = S*Da + D*(1 - Sa)
    [color setFill];
    CGContextFillRect(context, rect);//Image will be black if removed
    
    // mask by alpha values of original image
//    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
//    CGContextDrawImage(context, rect, self.CGImage);
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /*Returns an image based on the contents of the current bitmap-based graphics context.
     You should call this function only when a bitmap-based graphics context is the current graphics context. 
     If the current context is nil or was not created by a call to UIGraphicsBeginImageContext, this function returns nil.
     This function may be called from any thread of your app.
     Returns
     A image object containing the contents of the current bitmap graphics context.
     */
    UIGraphicsEndImageContext();
    /*
     you must call the UIGraphicsEndImageContext function to clean up the bitmap drawing environment 
     */
    
    return tintedImage;
}


@end
