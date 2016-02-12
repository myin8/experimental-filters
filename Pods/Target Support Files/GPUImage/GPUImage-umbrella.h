#import <UIKit/UIKit.h>

#import "GLProgram.h"
#import "GPUImage.h"
#import "GPUImage3x3ConvolutionFilter.h"
#import "GPUImage3x3TextureSamplingFilter.h"
#import "GPUImageAdaptiveThresholdFilter.h"
#import "GPUImageAddBlendFilter.h"
#import "GPUImageAlphaBlendFilter.h"
#import "GPUImageAmatorkaFilter.h"
#import "GPUImageAverageColor.h"
#import "GPUImageAverageLuminanceThresholdFilter.h"
#import "GPUImageBilateralFilter.h"
#import "GPUImageBoxBlurFilter.h"
#import "GPUImageBrightnessFilter.h"
#import "GPUImageBuffer.h"
#import "GPUImageBulgeDistortionFilter.h"
#import "GPUImageCGAColorspaceFilter.h"
#import "GPUImageCannyEdgeDetectionFilter.h"
#import "GPUImageChromaKeyBlendFilter.h"
#import "GPUImageChromaKeyFilter.h"
#import "GPUImageClosingFilter.h"
#import "GPUImageColorBlendFilter.h"
#import "GPUImageColorBurnBlendFilter.h"
#import "GPUImageColorConversion.h"
#import "GPUImageColorDodgeBlendFilter.h"
#import "GPUImageColorInvertFilter.h"
#import "GPUImageColorLocalBinaryPatternFilter.h"
#import "GPUImageColorMatrixFilter.h"
#import "GPUImageColorPackingFilter.h"
#import "GPUImageColourFASTFeatureDetector.h"
#import "GPUImageColourFASTSamplingOperation.h"
#import "GPUImageContrastFilter.h"
#import "GPUImageCropFilter.h"
#import "GPUImageCrosshairGenerator.h"
#import "GPUImageCrosshatchFilter.h"
#import "GPUImageDarkenBlendFilter.h"
#import "GPUImageDifferenceBlendFilter.h"
#import "GPUImageDilationFilter.h"
#import "GPUImageDirectionalNonMaximumSuppressionFilter.h"
#import "GPUImageDirectionalSobelEdgeDetectionFilter.h"
#import "GPUImageDissolveBlendFilter.h"
#import "GPUImageDivideBlendFilter.h"
#import "GPUImageEmbossFilter.h"
#import "GPUImageErosionFilter.h"
#import "GPUImageExclusionBlendFilter.h"
#import "GPUImageExposureFilter.h"
#import "GPUImageFASTCornerDetectionFilter.h"
#import "GPUImageFalseColorFilter.h"
#import "GPUImageFilter.h"
#import "GPUImageFilterGroup.h"
#import "GPUImageFilterPipeline.h"
#import "GPUImageFourInputFilter.h"
#import "GPUImageFramebuffer.h"
#import "GPUImageFramebufferCache.h"
#import "GPUImageGammaFilter.h"
#import "GPUImageGaussianBlurFilter.h"
#import "GPUImageGaussianBlurPositionFilter.h"
#import "GPUImageGaussianSelectiveBlurFilter.h"
#import "GPUImageGlassSphereFilter.h"
#import "GPUImageGrayscaleFilter.h"
#import "GPUImageHSBFilter.h"
#import "GPUImageHalftoneFilter.h"
#import "GPUImageHardLightBlendFilter.h"
#import "GPUImageHarrisCornerDetectionFilter.h"
#import "GPUImageHazeFilter.h"
#import "GPUImageHighPassFilter.h"
#import "GPUImageHighlightShadowFilter.h"
#import "GPUImageHighlightShadowTintFilter.h"
#import "GPUImageHistogramEqualizationFilter.h"
#import "GPUImageHistogramFilter.h"
#import "GPUImageHistogramGenerator.h"
#import "GPUImageHoughTransformLineDetector.h"
#import "GPUImageHueBlendFilter.h"
#import "GPUImageHueFilter.h"
#import "GPUImageJFAVoronoiFilter.h"
#import "GPUImageKuwaharaFilter.h"
#import "GPUImageKuwaharaRadius3Filter.h"
#import "GPUImageLanczosResamplingFilter.h"
#import "GPUImageLaplacianFilter.h"
#import "GPUImageLevelsFilter.h"
#import "GPUImageLightenBlendFilter.h"
#import "GPUImageLineGenerator.h"
#import "GPUImageLinearBurnBlendFilter.h"
#import "GPUImageLocalBinaryPatternFilter.h"
#import "GPUImageLookupFilter.h"
#import "GPUImageLowPassFilter.h"
#import "GPUImageLuminanceRangeFilter.h"
#import "GPUImageLuminanceThresholdFilter.h"
#import "GPUImageLuminosity.h"
#import "GPUImageLuminosityBlendFilter.h"
#import "GPUImageMaskFilter.h"
#import "GPUImageMedianFilter.h"
#import "GPUImageMissEtikateFilter.h"
#import "GPUImageMonochromeFilter.h"
#import "GPUImageMosaicFilter.h"
#import "GPUImageMotionBlurFilter.h"
#import "GPUImageMotionDetector.h"
#import "GPUImageMovie.h"
#import "GPUImageMovieComposition.h"
#import "GPUImageMultiplyBlendFilter.h"
#import "GPUImageNobleCornerDetectionFilter.h"
#import "GPUImageNonMaximumSuppressionFilter.h"
#import "GPUImageNormalBlendFilter.h"
#import "GPUImageOpacityFilter.h"
#import "GPUImageOpeningFilter.h"
#import "GPUImageOutput.h"
#import "GPUImageOverlayBlendFilter.h"
#import "GPUImageParallelCoordinateLineTransformFilter.h"
#import "GPUImagePerlinNoiseFilter.h"
#import "GPUImagePinchDistortionFilter.h"
#import "GPUImagePixellateFilter.h"
#import "GPUImagePixellatePositionFilter.h"
#import "GPUImagePoissonBlendFilter.h"
#import "GPUImagePolarPixellateFilter.h"
#import "GPUImagePolkaDotFilter.h"
#import "GPUImagePosterizeFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"
#import "GPUImageRGBClosingFilter.h"
#import "GPUImageRGBDilationFilter.h"
#import "GPUImageRGBErosionFilter.h"
#import "GPUImageRGBFilter.h"
#import "GPUImageRGBOpeningFilter.h"
#import "GPUImageRawDataInput.h"
#import "GPUImageRawDataOutput.h"
#import "GPUImageSaturationBlendFilter.h"
#import "GPUImageSaturationFilter.h"
#import "GPUImageScreenBlendFilter.h"
#import "GPUImageSepiaFilter.h"
#import "GPUImageSharpenFilter.h"
#import "GPUImageShiTomasiFeatureDetectionFilter.h"
#import "GPUImageSingleComponentGaussianBlurFilter.h"
#import "GPUImageSketchFilter.h"
#import "GPUImageSkinToneFilter.h"
#import "GPUImageSmoothToonFilter.h"
#import "GPUImageSobelEdgeDetectionFilter.h"
#import "GPUImageSoftEleganceFilter.h"
#import "GPUImageSoftLightBlendFilter.h"
#import "GPUImageSolidColorGenerator.h"
#import "GPUImageSourceOverBlendFilter.h"
#import "GPUImageSphereRefractionFilter.h"
#import "GPUImageStillCamera.h"
#import "GPUImageStretchDistortionFilter.h"
#import "GPUImageSubtractBlendFilter.h"
#import "GPUImageSwirlFilter.h"
#import "GPUImageTextureInput.h"
#import "GPUImageTextureOutput.h"
#import "GPUImageThreeInputFilter.h"
#import "GPUImageThresholdEdgeDetectionFilter.h"
#import "GPUImageThresholdSketchFilter.h"
#import "GPUImageThresholdedNonMaximumSuppressionFilter.h"
#import "GPUImageTiltShiftFilter.h"
#import "GPUImageToneCurveFilter.h"
#import "GPUImageToonFilter.h"
#import "GPUImageTransformFilter.h"
#import "GPUImageTwoInputCrossTextureSamplingFilter.h"
#import "GPUImageTwoInputFilter.h"
#import "GPUImageTwoPassFilter.h"
#import "GPUImageTwoPassTextureSamplingFilter.h"
#import "GPUImageUIElement.h"
#import "GPUImageUnsharpMaskFilter.h"
#import "GPUImageVibranceFilter.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageVignetteFilter.h"
#import "GPUImageVoronoiConsumerFilter.h"
#import "GPUImageWeakPixelInclusionFilter.h"
#import "GPUImageWhiteBalanceFilter.h"
#import "GPUImageXYDerivativeFilter.h"
#import "GPUImageZoomBlurFilter.h"
#import "GPUImageiOSBlurFilter.h"
#import "GPUImageFramework.h"
#import "GPUImageContext.h"
#import "GPUImageMovieWriter.h"
#import "GPUImagePicture+TextureSubimage.h"
#import "GPUImagePicture.h"
#import "GPUImageView.h"

FOUNDATION_EXPORT double GPUImageVersionNumber;
FOUNDATION_EXPORT const unsigned char GPUImageVersionString[];
