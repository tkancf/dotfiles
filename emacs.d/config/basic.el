;;スタート画面を開かない
(setq inhibit-startup-screen t)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;;Tab周り
(setq indent-line-function 'indent-to-left-margin)
(setq-default indent-tabs-mode nil tab-width 4)

;;バッファ自動読み込み
(global-auto-revert-mode 1)

;;; 文字コーディング設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; ベルを鳴らさないように
(setq ring-bell-function 'ignore)

;; メニューバーを非表示
(menu-bar-mode 0)
;; ツールバーを非表示
(tool-bar-mode 0)

;; highlight
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; doom themes
(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :custom-face
  (doom-modeline-bar ((t (:background "#6272a4"))))
  :config
  (load-theme 'tango-dark t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; font
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty Diminished"))
(set-face-font 'default "Ricty Diminished-18")

(use-package ucs-normalize
  :if (eq system-type 'darwin)
  :config
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  :straight nil
  )

(provide 'basic)
