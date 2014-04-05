#import <UIKit/UIKit.h>




@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForPrivateStyle:(NSInteger)arg1;
+ (id)settingsForStyle:(NSInteger)arg1;
+ (id)settingsForPrivateStyle:(NSInteger)arg1 graphicsQuality:(NSInteger)arg2;
+ (id)settingsForStyle:(NSInteger)arg1 graphicsQuality:(NSInteger)arg2;
@property(nonatomic) CGFloat blurRadius;
@property(copy, nonatomic) NSString *blurQuality;
@property(nonatomic) CGFloat colorTintAlpha;
@property(retain, nonatomic) UIColor *colorTint;
@property(nonatomic) CGFloat grayscaleTintAlpha;
@property(nonatomic) CGFloat grayscaleTintLevel;
@property(nonatomic) NSInteger style;
@end
@interface _UIBackdropView : UIView
@property(nonatomic) BOOL blursBackground;
@property(retain, nonatomic) _UIBackdropViewSettings *inputSettings;
@property(nonatomic) NSTimeInterval appliesOutputSettingsAnimationDuration;
@property(nonatomic) BOOL appliesOutputSettingsAutomatically;
- (void)transitionToSettings:(id)arg1;
- (void)_setBlursBackground:(BOOL)arg1;
- (CGFloat)blurRadius;
@end



@interface SBControlCenterContentContainerView : UIView
- (_UIBackdropView *)backdropView;
@end

@interface SBNotificationCenterViewController : UIViewController
- (_UIBackdropView *)backdropView;
@end


// Auxo 2
@interface UminoControlCenterBottomView : UIView @end
@interface UminoControlCenterTopView : UIView @end



#define kDefaultBlurRadiusForBackdropStyleDark						20.0f
#define kDefaultBlurRadiusForBackdropStyleAdaptiveLight				30.0f



BOOL enabled = YES;
CGFloat _NCBlurRadius = kDefaultBlurRadiusForBackdropStyleDark;
CGFloat _CCBlurRadius = kDefaultBlurRadiusForBackdropStyleAdaptiveLight;




void changeBackdropViewBlurRadius(_UIBackdropView *backdropView, CGFloat newBlurRadius) {
	if (backdropView == nil) return;
	
	if (backdropView.blurRadius != newBlurRadius) {
		_UIBackdropViewSettings *settings = backdropView.inputSettings;
		
		[settings retain];
		settings.blurRadius = newBlurRadius;
		
		[backdropView transitionToSettings:settings];
		[settings release];
		
		if (newBlurRadius == 0.0f) {
			if (backdropView.appliesOutputSettingsAutomatically) {
				[backdropView _setBlursBackground:YES];
				
				dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(backdropView.appliesOutputSettingsAnimationDuration * 0.5 * NSEC_PER_SEC));
				dispatch_after(time, dispatch_get_main_queue(), ^(void){
					[backdropView _setBlursBackground:NO];
				});
			}
			else
				[backdropView _setBlursBackground:NO];
		}
		else 
			[backdropView _setBlursBackground:YES];
	}
	
	if (!enabled && !backdropView.blursBackground)
		[backdropView _setBlursBackground:YES];
}



%hook SBNotificationCenterViewController

- (void)viewWillAppear:(BOOL)animated {
	%orig;
	
	CGFloat newBlurRadius = enabled ? _NCBlurRadius : kDefaultBlurRadiusForBackdropStyleDark;
	
	changeBackdropViewBlurRadius(self.backdropView, newBlurRadius);
}

%end



%hook SBControlCenterContentContainerView

- (void)layoutSubviews {
	%orig;
	
	CGFloat newBlurRadius = enabled ? _CCBlurRadius : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
	
	changeBackdropViewBlurRadius(self.backdropView, newBlurRadius);
}

%end


%group Auxo2

%hook UminoControlCenterTopView

- (void)setHidden:(BOOL)hide {
	%orig;
	
	if (!hide) {
		_UIBackdropView *backgroundView = MSHookIvar<_UIBackdropView *>(self, "_backgroundView");
		
		if (!backgroundView || ![backgroundView isKindOfClass:%c(_UIBackdropView)]) return;
		
		CGFloat newBlurRadius = enabled ? _CCBlurRadius : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
		
		changeBackdropViewBlurRadius(backgroundView, newBlurRadius);
	}
}

%end

%hook UminoControlCenterBottomView

- (void)setHidden:(BOOL)hide {
	%orig;
	
	if (!hide) {
		_UIBackdropView *backgroundView = MSHookIvar<_UIBackdropView *>(self, "_backgroundView");
		
		if (!backgroundView || ![backgroundView isKindOfClass:%c(_UIBackdropView)]) return;
		
		CGFloat newBlurRadius = enabled ? _CCBlurRadius : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
		
		changeBackdropViewBlurRadius(backgroundView, newBlurRadius);
	}
}

%end

%end


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	
	%init(Auxo2);
}

%end



void loadSettings() {
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/me.devbug.SBCenterBlurrr.plist"];
	
	enabled = [dict[@"EnableBlurrr"] boolValue];
	if (dict[@"EnableBlurrr"] == nil)
		enabled = YES;
	
	_CCBlurRadius = [dict[@"CCBlurRadius"] floatValue];
	if (dict[@"CCBlurRadius"] == nil)
		_CCBlurRadius = kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
	
	_NCBlurRadius = [dict[@"NCBlurRadius"] floatValue];
	if (dict[@"NCBlurRadius"] == nil)
		_NCBlurRadius = kDefaultBlurRadiusForBackdropStyleDark;
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


