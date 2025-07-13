(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-vc-prefer-newest t)
(setq package-archive-priorities '(("gnu" . 10)
                                   ("melpa" . 5))
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(use-package no-littering
  :vc (:url "https://github.com/emacscollective/no-littering")
  :config
  (no-littering-theme-backups)
  (setq custom-file (no-littering-expand-etc-file-name "custom.el")))

(use-package ef-themes
  :init
  (set-face-attribute 'default nil :height 95)
  (set-frame-font "SauceCodePro Nerd Font" nil t)
  (setq ef-themes-mixed-fonts t)
  (setq ef-themes-variable-pitch-ui t)
  (mapc #'disable-theme custom-enabled-themes)
  :config
  (load-theme 'ef-elea-dark :no-confirm))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
