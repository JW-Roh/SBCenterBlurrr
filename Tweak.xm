#import <UIKit/UIKit.h>




@class _UIBackdropView, CABackdropLayer;
@interface _UIBackdropViewSettings : NSObject
+ (id)darkeningTintColor;
+ (id)settingsForPrivateStyle:(NSInteger)arg1;
+ (id)settingsForStyle:(NSInteger)arg1;
+ (id)settingsForPrivateStyle:(NSInteger)arg1 graphicsQuality:(NSInteger)arg2;
+ (id)settingsForStyle:(NSInteger)arg1 graphicsQuality:(NSInteger)arg2;
@property(nonatomic) struct __CFRunLoopObserver *runLoopObserver;
@property(nonatomic) NSInteger suppressSettingsDidChange;
@property(nonatomic) BOOL appliesTintAndBlurSettings;
@property(nonatomic) BOOL usesContentView;
@property(nonatomic) BOOL usesColorTintView;
@property(nonatomic) BOOL usesGrayscaleTintView;
@property(nonatomic) BOOL usesBackdropEffectView;
@property(nonatomic, setter=setDesignMode:) BOOL designMode;
@property(nonatomic) NSUInteger version;
@property(nonatomic) CGFloat statisticsInterval;
@property(nonatomic) CGFloat scale;
@property(retain, nonatomic) UIColor *legibleColor;
@property(retain, nonatomic) UIImage *filterMaskImage;
@property(nonatomic) CGFloat filterMaskAlpha;
@property(nonatomic) CGFloat saturationDeltaFactor;
@property(nonatomic) NSInteger blurHardEdges;
@property(copy, nonatomic) NSString *blurQuality;
@property(nonatomic) CGFloat blurRadius;
@property(retain, nonatomic) UIImage *colorTintMaskImage;
@property(nonatomic) CGFloat colorTintMaskAlpha;
@property(nonatomic) CGFloat colorTintAlpha;
@property(retain, nonatomic) UIColor *colorTint;
@property(retain, nonatomic) UIImage *grayscaleTintMaskImage;
@property(nonatomic) CGFloat grayscaleTintMaskAlpha;
@property(nonatomic) CGFloat grayscaleTintAlpha;
@property(nonatomic) CGFloat grayscaleTintLevel;
@property(nonatomic) BOOL zoomsBack;
@property(nonatomic, getter=isBackdropVisible) BOOL backdropVisible;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, getter=isSelected) BOOL selected;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;
@property(nonatomic) NSInteger stackingLevel;
@property(nonatomic) NSInteger renderingHint;
//@property(retain, nonatomic) _UIBackdropColorSettings *colorSettings;
@property(nonatomic) BOOL requiresColorStatistics;
@property(nonatomic) BOOL explicitlySetGraphicsQuality;
@property(nonatomic) NSInteger graphicsQuality;
@property(nonatomic) NSInteger style;
@property(nonatomic, assign) _UIBackdropView *backdrop;
- (id)description;
@property(retain, nonatomic) UIColor *combinedTintColor;
- (void)computeOutputSettingsUsingModel:(id)arg1;
@property(nonatomic) BOOL blursWithHardEdges;
- (void)scheduleSettingsDidChangeIfNeeded;
- (void)clearRunLoopObserver;
- (void)decrementSuppressSettingsDidChange;
- (void)incrementSuppressSettingsDidChange;
- (void)setStackinglevel:(NSInteger)arg1;
- (void)setValuesFromModel:(id)arg1;
- (void)removeKeyPathObserver:(id)arg1;
- (void)addKeyPathObserver:(id)arg1;
- (void)dealloc;
- (void)restoreDefaultValues;
- (void)setDefaultValues;
- (id)initWithDefaultValuesForGraphicsQuality:(NSInteger)arg1;
- (id)initWithDefaultValues;
- (id)init;
@end
@interface _UIBackdropEffectView : UIView
@property(retain, nonatomic) CABackdropLayer *backdropLayer;
@end
@interface _UIBackdropView : UIView
@property(nonatomic) BOOL _backdropVisible;
@property(nonatomic) CGFloat _blurRadius;
@property(copy, nonatomic) NSString *_blurQuality;
@property(nonatomic) CGFloat previousBackdropStatisticsContrast;
@property(nonatomic) CGFloat previousBackdropStatisticsBlue;
@property(nonatomic) CGFloat previousBackdropStatisticsGreen;
@property(nonatomic) CGFloat previousBackdropStatisticsRed;
@property(nonatomic) BOOL blurRadiusSetOnce;
@property(nonatomic) BOOL backdropVisibilitySetOnce;
@property(nonatomic) CGFloat colorMatrixColorTintAlpha;
@property(retain, nonatomic) UIColor *colorMatrixColorTint;
@property(nonatomic) CGFloat colorMatrixGrayscaleTintAlpha;
@property(nonatomic) CGFloat colorMatrixGrayscaleTintLevel;
@property(retain, nonatomic) NSMutableDictionary *filterMaskViewMap;
@property(retain, nonatomic) UIView *filterMaskViewContainer;
@property(retain, nonatomic) NSMutableDictionary *colorTintMaskViewMap;
@property(retain, nonatomic) UIView *colorTintMaskViewContainer;
@property(retain, nonatomic) NSMutableDictionary *grayscaleTintMaskViewMap;
@property(retain, nonatomic) UIView *grayscaleTintMaskViewContainer;
@property(nonatomic) NSInteger maskMode;
@property(retain, nonatomic) UIView *contentView;
//@property(retain, nonatomic) CAFilter *tintFilter;
//@property(retain, nonatomic) CAFilter *colorSaturateFilter;
//@property(retain, nonatomic) CAFilter *gaussianBlurFilter;
@property(retain, nonatomic) UIImage *colorTintMaskImage;
@property(retain, nonatomic) UIView *colorTintView;
@property(retain, nonatomic) UIImage *grayscaleTintMaskImage;
@property(retain, nonatomic) UIView *grayscaleTintView;
@property(retain, nonatomic) UIImage *filterMaskImage;
@property(copy, nonatomic) NSString *groupName;
@property(retain, nonatomic) _UIBackdropEffectView *backdropEffectView;
@property(nonatomic) BOOL allowsColorSettingsSuppression;
@property(nonatomic) BOOL blursBackground;
@property(nonatomic) BOOL wantsColorSettings;
@property(nonatomic) BOOL requiresTintViews;
@property(nonatomic) BOOL applyingTransition;
@property(nonatomic) BOOL applyingBackdropChanges;
@property(nonatomic) BOOL appliesOutputSettingsAutomaticallyEnabledComputesColorSettings;
@property(nonatomic) NSInteger configuration;
@property(retain, nonatomic) _UIBackdropViewSettings *savedInputSettingsDuringRenderInContext;
@property(retain, nonatomic) _UIBackdropViewSettings *outputSettings;
@property(retain, nonatomic) _UIBackdropViewSettings *inputSettings;
@property(nonatomic) CGFloat appliesOutputSettingsAnimationDuration;
@property(nonatomic) BOOL appliesOutputSettingsAutomatically;
@property(nonatomic) BOOL computesColorSettings;
@property(nonatomic) BOOL autosizesToFitSuperview;
@property(nonatomic) NSInteger style;
@property(readonly, nonatomic) UIView *effectView;
- (void)transitionToSettings:(id)arg1;
- (void)transitionToColor:(id)arg1;
- (void)transitionToPrivateStyle:(NSInteger)arg1;
- (void)transitionToStyle:(NSInteger)arg1;
- (void)_setBlursBackground:(BOOL)arg1;
- (void)setBackdropVisible:(BOOL)arg1;
- (BOOL)isBackdropVisible;
- (void)setSaturationDeltaFactor:(CGFloat)arg1;
- (CGFloat)saturationDeltaFactor;
- (void)setBlurFilterWithRadius:(CGFloat)arg1 blurQuality:(id)arg2 blurHardEdges:(NSInteger)arg3;
- (void)setBlurFilterWithRadius:(CGFloat)arg1 blurQuality:(id)arg2;
- (void)setBlursWithHardEdges:(BOOL)arg1;
- (BOOL)blursWithHardEdges;
- (void)setBlurQuality:(id)arg1;
- (id)blurQuality;
- (void)setBlurRadius:(CGFloat)arg1;
- (CGFloat)blurRadius;
- (id)filters;
- (void)_updateFilters;
- (void)removeOverlayBlendModeFromView:(id)arg1;
- (void)applyOverlayBlendModeToView:(id)arg1;
- (void)applyOverlayBlendMode:(NSInteger)arg1 toView:(id)arg2;
- (void)removeMaskViews;
- (void)updateMaskViewsForView:(id)arg1;
- (void)updateMaskViewForView:(id)arg1 flag:(NSInteger)arg2;
- (void)setMaskImage:(id)arg1 onLayer:(id)arg2;
- (id)backdropViewLayer;
- (void)setShouldRasterizeEffectsView:(BOOL)arg1;
- (id)initWithFrame:(CGRect)arg1;
- (id)initWithFrame:(CGRect)arg1 privateStyle:(NSInteger)arg2;
- (id)initWithFrame:(CGRect)arg1 style:(NSInteger)arg2;
- (id)initWithPrivateStyle:(NSInteger)arg1;
- (id)initWithStyle:(NSInteger)arg1;
- (id)initWithSettings:(id)arg1;
- (id)initWithFrame:(CGRect)arg1 settings:(id)arg2;
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end



@interface SBControlCenterContentContainerView : UIView
- (_UIBackdropView *)backdropView;
@end

@interface SBNotificationCenterViewController : UIViewController
- (_UIBackdropView *)backdropView;
@end




BOOL enabled = YES;
CGFloat _NCBlurRadius = 20.0f;
CGFloat _CCBlurRadius = 30.0f;




%hook SBNotificationCenterViewController

- (void)viewWillAppear:(BOOL)animated {
	%orig;
	
	CGFloat newBlurRadius = enabled ? _NCBlurRadius : 20.0f;
	_UIBackdropView *backdropView = self.backdropView;
	
	if (backdropView.blurRadius != newBlurRadius) {
		_UIBackdropViewSettings *settings = backdropView.inputSettings;
		
		[settings retain];
		settings.blurRadius = newBlurRadius;
		
		[backdropView transitionToSettings:settings];
		[settings release];
	}
}

%end



%hook SBControlCenterContentContainerView

- (void)layoutSubviews {
	%orig;
	
	CGFloat newBlurRadius = enabled ? _CCBlurRadius : 30.0f;
	_UIBackdropView *backdropView = self.backdropView;
	
	if (backdropView.blurRadius != newBlurRadius) {
		_UIBackdropViewSettings *settings = backdropView.inputSettings;
		
		[settings retain];
		settings.blurRadius = newBlurRadius;
		
		[backdropView transitionToSettings:settings];
		[settings release];
	}
}

%end



void loadSettings() {
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/me.devbug.SBCenterBlurrr.plist"];
	
	enabled = [dict[@"EnableBlurrr"] boolValue];
	if (dict[@"EnableBlurrr"] == nil)
		enabled = YES;
	
	_CCBlurRadius = [dict[@"CCBlurRadius"] floatValue];
	if (dict[@"CCBlurRadius"] == nil)
		_CCBlurRadius = 30.0f;
	
	_NCBlurRadius = [dict[@"NCBlurRadius"] floatValue];
	if (dict[@"NCBlurRadius"] == nil)
		_NCBlurRadius = 20.0f;
}

static void reloadPrefsNotification(CFNotificationCenterRef center,
									void *observer,
									CFStringRef name,
									const void *object,
									CFDictionaryRef userInfo) {
	loadSettings();
}



%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &reloadPrefsNotification, CFSTR("me.devbug.SBCenterBlurrr.prefnoti"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadSettings();
	
	%init;
}


