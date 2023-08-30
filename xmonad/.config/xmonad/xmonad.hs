import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab



main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig

myConfig = def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "alacritty"
    , normalBorderColor = "#4f585e"
    , focusedBorderColor = "#a7c080"
    , focusFollowsMouse = False
    , clickJustFocuses = False
    }
    `additionalKeysP`
    [ ("M-s", unGrab *> spawn "scrot -s -F ~/Downloads/'Screen Shot %Y-%m-%d at %H.%M.%S.png'")
    , ("M-x", spawn "xset s activate")  -- Start screen saver (which is configured to lock screen)
    ]
