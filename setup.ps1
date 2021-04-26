# --------------------------------------------------
# -- Windows/System settings
# --------------------------------------------------
    # Settings:
        # System:
            # Notifications & actions:
                # Show me the Windows welcome experience...: Uncheck
                # Get tips, tricks, and suggestions...: Uncheck
            # Multitasking:
                # Timeline:
                    # Show suggestions in your timeline: Off
        # Ease of Access:
            # Keyboard:
                # Use Sticky Keys: Off/Uncheck shortcut
                # Use Toggle Keys: Off/Uncheck shortcut
                # Use Filter Keys: Off/Uncheck shortcut
                # Print Screen Shortcut: On
        # Cortana:
            # Lock Screen: Off
        # Personalization:
            # Colors:
                # Windows Mode: Dark
                # App Mode: Dark
            # Lock screen:
                # Background: Picture
                # Get fun facts: Off
                # Remove all app mappings
            # Start:
                # Show recently added apps: Off
                # Show suggestions occasionaly in Start: Off
                # Show recently opened items...: Off
                # Choose which folders appear on Start: File Explorer, Settings, Downloads
            # Taskbar:
                # Notification area:
                    # Select which icons appear on the taskbar: Show all (On)
                # Multiple displays:
                    # Show taskbar buttons on: Taskbar where window is open
        # Privacy:
            # General:
                # Change privacy options: Disable All
            # Activity History:
                # Story my activity history on this device: Disable all
        # Update & Security:
            # For developers:
                # File Explorer: Apply
                # Remote Desktop: Apply
                # PowerShell: Apply
            # Windows Insider Program: Set up Slow Ring
    # Power Standby/Monitor Settings
        powercfg /X /monitor-timeout-ac 10;
        powercfg /X /standby-timeout-ac 0;
        powercfg /H off;
        # Power Schemes - Pick one
            powercfg /S e9a42b02-d5df-448d-aa00-03f14749eb61; # Ultimate Performance; # Preferred for high end desktop; # Not supported on all versions of Win10;
            powercfg /S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c; # High Performance; # Preferred for desktop;
            powercfg /S 381b4222-f694-41f0-9685-ff5bb260df2e; # Balanced;
            powercfg /S a1841308-3541-4fab-bc81-f71556f20b4a; # Power Saver; # Preferred for laptop;
    # Disable UAC
		# Not doing this anymore
        # sp -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name ConsentPromptBehaviorAdmin -Value 0;
    # Remove Shortcuts from "This PC" (Documents, 3D Objects, Videos, etc)
        $shortcutList = 'B4BFCC3A-DB2C-424C-B029-7FE99A87C641','A8CDFF1C-4878-43be-B5FD-F8091C1C60D0','d3162b92-9365-467a-956b-92703aca08af','374DE290-123F-4565-9164-39C4925E467B','088e3905-0323-4b02-9826-5d99428e115f','1CF1260C-4DD0-4ebb-811F-33C572699FDE','3dfdf296-dbec-4fb4-81d1-6a3438bcf4de','3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA','24ad3ad4-a569-4530-98e1-ab02f9417aa8','A0953C92-50DC-43bf-BE83-3742FED03C9C','f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a','0DB7E03F-FC29-4DC6-9020-FF41B59E513A';
        $shortcutList | % {
            rm -Path ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{$_}") -ErrorAction SilentlyContinue;
            rm -Path ("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{$_}") -ErrorAction SilentlyContinue;
        };
	# Disable Bing search in Start menu
		sp -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Value 0x1 -Type DWord -Force
	# Show seconds in the task bar clock
		sp -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSecondsInSystemClock -Value 0x1 -Type DWord -Force
	# Start menu open delay
		sp -Path 'HKCU:\Control Panel\Desktop' -Name MenuShowDelay -Value 100;
    
    ## Hardware specific ##
    # Disable Surface Adaptive Contrast
    #   sp -path 'HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001' -Name FeatureTestControl -Value 0x00009250;
# --------------------------------------------------
#
# --------------------------------------------------
    # Remove Extra Appx Packages
        Get-AppxPackage |
            ? {!$_.NonRemovable} |
            ? Name -NotLike 'CanonicalGroupLimited.UbuntuonWindows' |
            ? Name -NotLike 'Microsoft.*Extension*' |
            ? Name -NotLike 'Microsoft.DesktopAppInstaller' |
            ? Name -NotLike 'Microsoft.NET.Native.*' |
            ? Name -NotLike 'Microsoft.MicrosoftOfficeHub' |
            ? Name -NotLike 'Microsoft.UI.Xaml.*' |
            ? Name -NotLike 'Microsoft.VCLibs.*' |
            ? Name -NotLike 'Microsoft.ScreenSketch' |
            ? Name -NotLike 'Microsoft.Services.Store.Engagement' |
            ? Name -NotLike 'Microsoft.StorePurchaseApp' |
            ? Name -NotLike 'Microsoft.Windows.Photos' |
            ? Name -NotLike 'Microsoft.WindowsCalculator' |
            ? Name -NotLike 'microsoft.windowscommunicationsapps' |
            ? Name -NotLike 'Microsoft.WindowsNotepad' |
            ? Name -NotLike 'Microsoft.WindowsStore' |
            ? Name -NotLike 'Microsoft.WindowsTerminal' |
            ? Name -NotLike 'Microsoft.MicrosoftEdge.Stable' |
            # % { $_ | Remove-AppxPackage -Verbose };
            select Name | sort -Property Name;
