#import "GPUImageIrodoriFilter.h"

@implementation GPUImageIrodoriFilter

@synthesize Huemin = _Huemin;
@synthesize Huemax = _Huemax;
@synthesize Satmin = _Satmin;
@synthesize Satmax = _Satmax;
@synthesize Brmin = _Brmin;
@synthesize Brmax = _Brmax;
@synthesize Huemin2 = _Huemin2;
@synthesize Huemax2 = _Huemax2;
@synthesize Satmin2 = _Satmin2;
@synthesize Satmax2 = _Satmax2;
@synthesize Brmin2 = _Brmin2;
@synthesize Brmax2 = _Brmax2;
@synthesize Intensity = _Intensity;


NSString *const IrodoriShaderString = SHADER_STRING
(
 precision highp float;
 
 varying vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform highp float Huemin;
 uniform highp float Huemax;
 
 //erica
 uniform highp float Satmin;
 uniform highp float Satmax;
 
 uniform highp float Brmin;
 uniform highp float Brmax;
 
 uniform highp float Huemin2;
 uniform highp float Huemax2;
 
 //erica
 uniform highp float Satmin2;
 uniform highp float Satmax2;
 
 uniform highp float Brmin2;
 uniform highp float Brmax2;
 
 uniform highp float Intensity;
 
 const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
     //以下、GLSLという言語
     //vecは配列 vec3は３個の配列（３次元）
     //vec4に色データが入っている（RGBA)
     float luminance = dot(texture2D(inputImageTexture, textureCoordinate).rgb, W);
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     highp float s;
     highp float v;
     highp float h;
     highp float c;
     highp float cmin;
     highp float cmax;
     
     if (textureColor.r >= textureColor.g)  cmax = textureColor.r; else cmax = textureColor.g;
     if (textureColor.b >= cmax) cmax = textureColor.b;
     
     if (textureColor.r <= textureColor.g) cmin = textureColor.r; else cmin = textureColor.g;
     if (textureColor.b <= cmin) cmin = textureColor.b;
     
     v  = cmax;
     c = cmax - cmin;
     
     if(cmax == 0.0){
         s = 0.0;
     }else{
         s  =  c/cmax;
     }
     
     if (s != 0.0)
     {
         if (textureColor.r == cmax)
         {
             h  = 60.0 * ((textureColor.g - textureColor.b)/c);
         }
         else if (textureColor.g == cmax)
         {
             h  = 60.0 * ((textureColor.b - textureColor.r)/c) + 120.0;
         }
         else if (textureColor.b == cmax)
         {
             h  = 60.0 * ((textureColor.r - textureColor.g)/c) + 240.0;
         }
         if (h  < 0.0)
             h  = h + 360.0;
     }
     
     
     
     
     
     
     if(((Huemin*(1.0-Intensity*0.2)<=h && h<=Huemax*(1.0+Intensity*0.2) ||
          (Huemax*(1.0+Intensity*0.2)>360.0 && h<=Huemax*(1.0+Intensity*0.2)-360.0)) &&
         (Satmin*(1.0-(Intensity))<=s && s<=Satmax) &&
         (Brmin*(1.0-(Intensity))<=v && v<=Brmax)) ||
        
        ((Huemin2*(1.0-Intensity*0.2)<=h && h<=Huemax2*(1.0+Intensity*0.2) ||
          (Huemax2*(1.0+Intensity*0.2)>360.0 && h<=Huemax2*(1.0+Intensity*0.2)-360.0)) &&
         (Satmin2*(1.0-(Intensity))<=s && s<=Satmax2) &&
         (Brmin2*(1.0-(Intensity))<=v && v<=Brmax2)))
     {
         gl_FragColor =vec4(textureColor);
     }else{
         gl_FragColor = vec4(vec3(luminance), 1.0);//RGBでグレーを表現（luminanceをもう一度vec3に展開）（※アルファは1.0）
         
         
     }
     
     
     
 }
 );

#pragma mark -
#pragma mark Initialization and teardown

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:IrodoriShaderString]))
    {
		return nil;
    }
    HuemaxUniform = [filterProgram uniformIndex:@"Huemax"];
    HueminUniform = [filterProgram uniformIndex:@"Huemin"];
    SatmaxUniform = [filterProgram uniformIndex:@"Satmax"];
    SatminUniform = [filterProgram uniformIndex:@"Satmin"];
    BrmaxUniform = [filterProgram uniformIndex:@"Brmax"];
    BrminUniform = [filterProgram uniformIndex:@"Brmin"];
    IntensityUniform = [filterProgram uniformIndex:@"Intensity"];
    HuemaxUniform2 = [filterProgram uniformIndex:@"Huemax2"];
    HueminUniform2 = [filterProgram uniformIndex:@"Huemin2"];
    SatmaxUniform2 = [filterProgram uniformIndex:@"Satmax2"];
    SatminUniform2 = [filterProgram uniformIndex:@"Satmin2"];
    BrmaxUniform2 = [filterProgram uniformIndex:@"Brmax2"];
    BrminUniform2 = [filterProgram uniformIndex:@"Brmin2"];
    //printf("%d",IntensityUniform);
    self.Intensity=0.0;
    glUniform1f(IntensityUniform, self.Intensity);
    return self;
}

- (void)setHue:(CGFloat)Huemin max:(CGFloat)Huemax;
{
    _Huemin = Huemin;
    _Huemax=Huemax;/*
                    [GPUImageOpenGLESContext useImageProcessingContext];
                    [filterProgram use];
                    glUniform1f(HueminUniform, _Huemin);
                    glUniform1f(HuemaxUniform, _Huemax);
                    // printf("%f",_Huemin);
                    */
    [self setFloat:_Huemin forUniform:HueminUniform program:filterProgram];
    [self setFloat:_Huemax forUniform:HuemaxUniform program:filterProgram];
    
}

//erica
- (void)setSat:(CGFloat)Satmin max:(CGFloat)Satmax;
{
    _Satmin = Satmin;
    _Satmax=Satmax;
    
    /*[GPUImageOpenGLESContext useImageProcessingContext];
     [filterProgram use];
     glUniform1f(SatminUniform, _Satmin);
     glUniform1f(SatmaxUniform, _Satmax);
     */
    [self setFloat:_Satmin forUniform:SatminUniform program:filterProgram];
    [self setFloat:_Satmax forUniform:SatmaxUniform program:filterProgram];
    
    
    
    //printf("%f",_Satmin);
}

- (void)setBr:(CGFloat)Brmin max:(CGFloat)Brmax;
{
    _Brmin = Brmin;
    _Brmax=Brmax;
    /*
     [GPUImageOpenGLESContext useImageProcessingContext];
     [filterProgram use];
     glUniform1f(BrminUniform, _Brmin);
     glUniform1f(BrmaxUniform, _Brmax);
     */
    [self setFloat:_Brmin forUniform:BrminUniform program:filterProgram];
    [self setFloat:_Brmax forUniform:BrmaxUniform program:filterProgram];
    
    
    
}


-(void)setSecondColorHuemin:(CGFloat)Huemin Huemax:(CGFloat)Huemax Satmin:(CGFloat)Satmin Satmax:(CGFloat)Satmax Brmin:(CGFloat)Brmin Brmax:(CGFloat)Brmax{
    
    _Satmin2 = Satmin;
    _Satmax2=Satmax;
    _Huemin2 = Huemin;
    _Huemax2=Huemax;
    _Brmin2 = Brmin;
    _Brmax2=Brmax;
    
    
    [self setFloat:_Satmin2 forUniform:SatminUniform2 program:filterProgram];
    [self setFloat:_Satmax2 forUniform:SatmaxUniform2 program:filterProgram];
    [self setFloat:_Huemin2 forUniform:HueminUniform2 program:filterProgram];
    [self setFloat:_Huemax2 forUniform:HuemaxUniform2 program:filterProgram];
    [self setFloat:_Brmin2 forUniform:BrminUniform2 program:filterProgram];
    [self setFloat:_Brmax2 forUniform:BrmaxUniform2 program:filterProgram];
}

- (void)setIntensity:(CGFloat)newIntensity;
{
    _Intensity = newIntensity;
    // [GPUImageOpenGLESContext useImageProcessingContext];
    //[filterProgram use];
    // glUniform1f(IntensityUniform, _Intensity);
    [self setFloat:_Intensity forUniform:IntensityUniform program:filterProgram];
    printf("/%f/",_Intensity);
}

@end