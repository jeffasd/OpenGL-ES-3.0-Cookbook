//
//  ViewController.m
//  GLPIFramework
//
//  Created by macbook on 9/8/13.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import "ViewController.h"
#import "NativeTemplate.h"


@interface ViewController () {
}
@property (strong, nonatomic) EAGLContext *context;

- (void)initializeGL;
//- (void)tearDownGL;

@end

@implementation ViewController

/*- (void)dealloc
 {
 [self tearDownGL];
 
 if ([EAGLContext currentContext] == self.context) {
 [EAGLContext setCurrentContext:nil];
 }
 
 [_context release];
 [super dealloc];
 }*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3] autorelease];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void) shouldAutorotate
{
    [EAGLContext setCurrentContext:self.context];

    GraphicsResize(self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self.view ];

		TouchEventDown( pos.x, pos.y );
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self.view ];
		TouchEventMove( pos.x, pos.y );
		
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self.view ];
		
		TouchEventRelease( pos.x, pos.y );
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    [((GLKView *) self.view) bindDrawable];
    //Optional code to demonstrate how can you bind frame buffer and render buffer.
    GLint defaultFBO;
    GLint defaultRBO;
    
    glGetIntegerv(GL_FRAMEBUFFER_BINDING_OES, &defaultFBO);
    glGetIntegerv(GL_RENDERBUFFER_BINDING_OES, &defaultRBO);
    
    glBindFramebuffer( GL_FRAMEBUFFER, defaultFBO );
    glBindRenderbuffer( GL_RENDERBUFFER, defaultRBO );
    //GraphicsResize(self.view.bounds.size.width, self.view.bounds.size.height);
    GraphicsInit();
    
    //setupGraphics(self.view.bounds.size.width, self.view.bounds.size.height);
    
}

/*- (void)tearDownGL
 {
 [EAGLContext setCurrentContext:self.context];
 }*/

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    GraphicsRender();
    //renderFrame();
}


@end
