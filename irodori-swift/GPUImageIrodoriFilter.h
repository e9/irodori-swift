#import "GPUImage/GPUImageFilter.h"


extern NSString *const IrodoriShaderString;

@interface GPUImageIrodoriFilter : GPUImageFilter{
    
    GLint HueminUniform;
    GLint HuemaxUniform;
    
    //erica
    GLint SatminUniform;
    GLint SatmaxUniform;
    
    GLint BrminUniform;
    GLint BrmaxUniform;
    
    
    GLint HueminUniform2;
    GLint HuemaxUniform2;
    
    //erica
    GLint SatminUniform2;
    GLint SatmaxUniform2;
    
    GLint BrminUniform2;
    GLint BrmaxUniform2;
    
    GLint IntensityUniform;
}
@property(readwrite, nonatomic) CGFloat Huemin;
@property(readwrite, nonatomic) CGFloat Huemax;

//erica
@property(readwrite, nonatomic) CGFloat Satmin;
@property(readwrite, nonatomic) CGFloat Satmax;

@property(readwrite, nonatomic) CGFloat Brmin;
@property(readwrite, nonatomic) CGFloat Brmax;

@property(readwrite, nonatomic) CGFloat Huemin2;
@property(readwrite, nonatomic) CGFloat Huemax2;

//erica
@property(readwrite, nonatomic) CGFloat Satmin2;
@property(readwrite, nonatomic) CGFloat Satmax2;

@property(readwrite, nonatomic) CGFloat Brmin2;
@property(readwrite, nonatomic) CGFloat Brmax2;


@property(readwrite, nonatomic) CGFloat Intensity;

- (void)setHue:(CGFloat)HueminG max:(CGFloat)HuemaxG;
//erica
- (void)setSat:(CGFloat)Satmin max:(CGFloat)SatmaxG;
- (void)setBr:(CGFloat)Brmin max:(CGFloat)BrmaxG;
- (void)setIntensity:(CGFloat)newIntensity;
-(void)setSecondColorHuemin:(CGFloat)Huemin Huemax:(CGFloat)Huemax Satmin:(CGFloat)Satmin Satmax:(CGFloat)Satmax Brmin:(CGFloat)Brmin Brmax:(CGFloat)Brmax;
@end