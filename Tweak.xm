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
@interface UminoControlCenterOriginalView : UIView @end



#define kDefaultBlurRadiusForBackdropStyleDark						20.0f
#define kDefaultBlurRadiusForBackdropStyleAdaptiveLight				30.0f



BOOL isFirmware8 = NO;
NSUserDefaults *userDefaults = nil;



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
	
	if (![userDefaults boolForKey:@"EnableBlurrr"] && !backdropView.blursBackground)
		[backdropView _setBlursBackground:YES];
}



%hook SBNotificationCenterViewController

- (void)_validateBackgroundViewIfNecessary {
	%orig;
	
	CGFloat newBlurRadius = [userDefaults boolForKey:@"EnableBlurrr"] ? [userDefaults floatForKey:@"NCBlurRadius"] : kDefaultBlurRadiusForBackdropStyleDark;
	
	changeBackdropViewBlurRadius(self.backdropView, newBlurRadius);
}

%end



%hook SBControlCenterContentContainerView

- (void)layoutSubviews {
	%orig;
	
	CGFloat newBlurRadius = [userDefaults boolForKey:@"EnableBlurrr"] ? [userDefaults floatForKey:@"CCBlurRadius"] : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
	
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
		
		CGFloat newBlurRadius = [userDefaults boolForKey:@"EnableBlurrr"] ? [userDefaults floatForKey:@"CCBlurRadius"] : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
		
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
		
		CGFloat newBlurRadius = [userDefaults boolForKey:@"EnableBlurrr"] ? [userDefaults floatForKey:@"CCBlurRadius"] : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
		
		changeBackdropViewBlurRadius(backgroundView, newBlurRadius);
	}
}

%end

%hook UminoControlCenterOriginalView

- (void)setHidden:(BOOL)hide {
	%orig;
	
	if (!hide) {
		_UIBackdropView *backgroundView = MSHookIvar<_UIBackdropView *>(self, "_backgroundView");
		
		if (!backgroundView || ![backgroundView isKindOfClass:%c(_UIBackdropView)]) return;
		
		CGFloat newBlurRadius = [userDefaults boolForKey:@"EnableBlurrr"] ? [userDefaults floatForKey:@"CCBlurRadius"] : kDefaultBlurRadiusForBackdropStyleAdaptiveLight;
		
		changeBackdropViewBlurRadius(backgroundView, newBlurRadius);
	}
}

%end

%end


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	
	if (%c(UminoControlCenterTopView))
		%init(Auxo2);
}

%end



void loadSettings() {
	if (!isFirmware8) {
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/me.devbug.SBCenterBlurrr.plist"];
		
		if (dict[@"EnableBlurrr"])
			[userDefaults setObject:dict[@"EnableBlurrr"] forKey:@"EnableBlurrr"];
		
		if (dict[@"CCBlurRadius"])
			[userDefaults setObject:dict[@"CCBlurRadius"] forKey:@"CCBlurRadius"];
		
		if (dict[@"NCBlurRadius"])
			[userDefaults setObject:dict[@"NCBlurRadius"] forKey:@"NCBlurRadius"];
	}
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
	// iOS 8.1 == 1141.14
	isFirmware8 = kCFCoreFoundationVersionNumber >= 900.00;
	
	#define kSettingsPListName @"me.devbug.SBCenterBlurrr"
	userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kSettingsPListName];
	[userDefaults registerDefaults:@{
		@"EnableBlurrr" : @YES,
		@"CCBlurRadius" : @kDefaultBlurRadiusForBackdropStyleAdaptiveLight,
		@"NCBlurRadius" : @kDefaultBlurRadiusForBackdropStyleDark
	}];
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &reloadPrefsNotification, CFSTR("me.devbug.SBCenterBlurrr.prefnoti"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadSettings();
	
	%init;
}


