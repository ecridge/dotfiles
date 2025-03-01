import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.Spacing

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import System.Exit



main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig

myConfig = def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "alacritty"
    , normalBorderColor = "#bec5b2"
    , focusedBorderColor = "#f57d26"
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , layoutHook = smartSpacingWithEdge 4 $ myLayout
    , manageHook = myManageHook
    }
    `additionalKeysP`
    [ ("M-s", unGrab *> spawn "scrot -s -F ~/Downloads/'Screen Shot %Y-%m-%d at %H.%M.%S.png'")
    , ("M-x", spawn "xset s activate")  -- Start screen saver (which is configured to lock screen)
    , ("M-A-S-q", io exitSuccess)
    ]
    `removeKeysP`
    [  "M-S-q"
    ]

myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Protonvpn-app" --> doFloat
    , isDialog --> doFloat
    ]
