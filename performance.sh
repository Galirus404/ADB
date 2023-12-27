echo "DEVICES INFORMATION										"
sleep 2
echo ""
   echo " build release   [🕗]•$(getprop ro.build.date)			"
   sleep 1
echo ""
   echo " device model    [📱]•$(getprop ro.product.model)		"
   sleep 1
echo ""
   echo " codename model  [📲]•$(getprop ro.build.product)		"
   sleep 1
echo ""
   echo " device brand    [🆔]•$(getprop ro.product.brand)		"
   sleep 1
echo ""
   echo " SDK build       [💽]•$(getprop ro.build.version.sdk)	"
   sleep 1
echo ""
   echo " kernel type     [📀]•$(cat /proc/version) "
   sleep 1
echo ""
echo "_____________________________________________	"
echo "WAITING ANDROID OPTIMIZER"
   sleep 1
####################################################
#// min max cached prosses for running apps.
   # Default value is 32kbps # pixel devices value is 64kbs
   # value of cached processes 16kbps - 64kbps
settings put global activity_manager_constants max_cached_processes 3023 
echo "Setup value cached to 3023"
sleep 1

####################################################
# ANIMATOR DURATION
	#this code for disable animator duration on ANDROID
	#for setup this, you can look code here:
		#0.0 > disable ANIMATOR
		#0.5 > balanced ANIMATOR
		#1.0 fully ANIMATOR
		settings put global animator_duration_scale 0.0
		settings put global transition_animation_scale 0.0
		echo "force 0 animation for better performance"
		sleep 1
		
		#Apps standby disable for better performance
		setting put global app_standby_enabled 0
		echo "disable standby apps on background"
		sleep 1
		
####################################################
     # GPU Perf system
     #Rendering Type For composition
        #// gpu : rendering with 100 GPU
        #// cpu : rendering with 100 CPU
        #// mdp : rendering with 75 GPU
        #// c2d : rendering with 50 GPU
	setprop debug.composition.type gpu
	setprop debug.composition.type c2d
	setprop debug.hwui.renderer skiagl
	setprop debug.gr.swapinterval 60
	setprop debug.gr.numframebuffers 3
	setprop debug.egl.buffcount 4
	setprop debug.egl.force_msaa 1
	setprop debug.cpurend.vsync false

	setprop debug.enabletr true
	setprop debug.overlayui.enable 1
	setprop debug.egl.hw 1
	setprop debug.gralloc.gfx_ubwc_disable 0
	setprop debug.mdpcomp.logs 0
echo "Enabled MUI GPU Turbo"
sleep 1

#* performance tuning mode with septrop mode.
	#// disable performance mode : 0;
	#// enable performance mode : 1;
setprop debug.performance.tuning 1
echo "Enabled PERFORMANCE MODE"
sleep 1

# SurfaceFlinger accepts buffers, composes buffers, and sends buffers to the display.
# WindowManager provides SurfaceFlinger with buffers and window metadata, which SurfaceFlinger uses to composite surfaces to the display.
	#//modify status bar/quick settings for reduce cpu usage, this code make freeze or error for some devices, enable if you need.
			setprop debug.sf.hw 1
#* use GPU for rendering, you can change code with>
	#// enable harware rendering { GPU  } : 1;
	#// disable hardware rendering { GPU } : 0;
		setprop hw3d.force 1
		echo "Enabled Hardware Accelerator"
		sleep 1
		
	#* disable logcat log for all running apps, make your phone fastest. use this value for mode>
		#// enable vsync <true>
		#// disable vsync <false>
			setprop hwui.disable_vsync true
			echo "Disabled VSYNC"
sleep 1

# eglSwapInterval — specifies the minimum number of video frame periods per buffer swap for the window associated with the current context.
	setprop debug.gr.swapinterval 1
# FPS STABILIZER
	#* value for interval>
		#// 1 > enable syncronize for swapinterval;
		#// 0 > disable syncronize for swapinterval;
		#// 1 > enable for swapinterval;
		#// 0 > default for swapinterval;
	setprop debug.egl.swapinterval 1
	echo "Setup Screen Frame Rate To 60"
	sleep 1

####################################################
# rendering tweaks
	setprop debug.renderengine.backend skiagl
	setprop debug.renderengine.backend skiaglthreaded
	setprop debug.angle.overlay FPS:skiagl*PipelineCache*
	setprop debug.javafx.animation.framerate 120
	setprop debug.systemuicompilerfilter speed
	setprop debug.app.performance_restricted false
	setprop debug.gr.numframebuffers 3
	setprop debug.egl.buffcount 4
	settings put system pointer_speed 7
	echo "Enabled Render Engine"
sleep 1

##################################################
# surfaceflinger tweaks
setprop debug.sf.set_idle_timer_ms 30
setprop debug.sf.disable_backpressure 1
setprop debug.sf.latch_unsignaled 1
setprop debug.sf.enable_hwc_vds 1
setprop debug.sf.early_phase_offset_ns 500000
setprop debug.sf.early_app_phase_offset_ns 500000
setprop debug.sf.early_gl_phase_offset_ns 3000000
setprop debug.sf.early_gl_app_phase_offset_ns 15000000
setprop debug.sf.high_fps_early_phase_offset_ns 6100000
setprop debug.sf.high_fps_late_sf_phase_offset_ns 8000000
setprop debug.sf.high_fps_early_gl_phase_offset_ns 9000000
setprop debug.sf.high_fps_late_app_phase_offset_ns 1000000
setprop debug.sf.high_fps_late_sf_phase_offset_ns 8000000
setprop debug.sf.high_fps_early_gl_phase_offset_ns 9000000
setprop debug.sf.phase_offset_threshold_for_next_vsync_ns 6100000
echo "Enabled SurfaceFlinger Highest FPS"
sleep 1

# Those debug props lets you to disable the limit of 3d settings.
# So therefore, you get higher fps scores.
	#// value 1 > disable;
	#// value 0 > enable;
setprop debug.sf.showfps 0
setprop debug.sf.showcpu 0
setprop debug.sf.showbackground 0
setprop debug.sf.shoupdates 0
echo "Disabled FPS Sync"
sleep 1

cmd thermalservice override-status 0
echo "Disabled Thermal"
sleep 1

cmd power set-fixed-performance-mode-enabled true
echo "Enabled performance mode"
sleep 1

# Starting with Android 6.0 (API level 23),
# Android introduced two power-saving features that extend battery life for users by managing how apps behave when the device is not connected to a power source.
     #// you can see the code below to change it.
     #// use this main code <dumpsys deviceidle> and then use this mode to change doze.
     #// <force-idle> <unfofce> <battery reset>
     #// for checked status, use this command <am get-inactive <packageName>
dumpsys deviceidle force-idle
settings put global battery_tip_constans app_restriction_enabled false
echo "Disabled Blocked APPS"
sleep 1

# allows limiting high CPU usage so as not to drain battery usage
	#// The value used are 1 to 100, using value that suit your device usage.
      settings put global power_check_max_cpu_1 75
      settings put global power_check_max_cpu_2 75
      settings put global power_check_max_cpu_3 50
      settings put global power_check_max_cpu_4 50
	  echo " Power Check Max CPU"
sleep 1

# Cached Apps Freezer
# The cached apps freezer leverages the kernel cgroup v2 freezer.
# Devices shipping with a compatible kernel can (optionally) enable it.
# To do so, enable the developer option "Suspend execution for cached apps" or set the device config flag activity_manager_native_boot use_freezer to true.
device_config put activity_manager_native_boot use_freezer true
echo "Cachce Apps Freezer 11+"
sleep 1
settings put global cached_apps_freezer 1
echo "Enabled Cahce Apps Freezer"
sleep 1

# Peak Refresh rate System Settings For 60HZ and Up.
# this code make Your devices got 60FPS in Games.
settings put system peak_refresh_rate 120.0
settings put system min_refresh_rate 60.0
echo "Enabled 120FPS For 60Hz+ Screen Refresh Rate"
sleep 1

##################################################
echo ""
echo ""
echo "ALL MAGIC TWEAK ACTIVED"
sleep 1
echo "CAUTION ❗ = | ERROR | BLACK SCREEN | FREEZE | FORCE STOPED | REVERT"
sleep 1
echo "Reboot Your Phone & Clear Cache/Dalvik"
sleep 1
echo "Closed"
am force-stop me.piebridge.brevent
# Powered by bang levv
