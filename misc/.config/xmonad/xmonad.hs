import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab


main :: IO ()
main = xmonad $ def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "alacritty"
    }
    `additionalKeysP`
    [ ("M-s", unGrab *> spawn "scrot -s -F ~/Downloads/'Screen Shot %Y-%m-%d at %H.%M.%S.png'")
    ]
