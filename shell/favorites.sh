# Logcat Orientation
wm -pe WM_DEBUG_ORIENTATION  WM_DEBUG_FORCED_ORIENTATION && adb logcat -s -T 100 -v tag "WindowManager:V"  | greph --line-buffered -i "ClientTransform|forced" "Orientation|Rotation" | less +F -S

# Kill launcher
adb shell kill 

# Kill launcher
adb shell kill 27624

