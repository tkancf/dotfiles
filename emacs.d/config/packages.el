(use-package neotree
  :straight t
  :config
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-show-hidden-files t))

(use-package which-key
  :straight t
  :config
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

(use-package whitespace
  :config
  ;; 空白
  (set-face-foreground 'whitespace-space nil)
  (set-face-background 'whitespace-space "gray33")
  ;; ファイル先頭と末尾の空行
  (set-face-background 'whitespace-empty "gray33")
  ;; タブ
  (set-face-foreground 'whitespace-tab nil)
  (set-face-background 'whitespace-tab "gray33")
  ;; ???
  (set-face-background 'whitespace-trailing "gray33")
  (set-face-background 'whitespace-hspace "gray33")

  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           empty          ; 先頭/末尾の空行
                           spaces         ; 空白
                           ;; space-mark     ; 表示のマッピング
                           tab-mark))

  ;; スペースは全角のみを可視化
  (setq whitespace-space-regexp "\\(\u3000+\\)")

  ;; タブの表示を変更
  (setq whitespace-display-mappings
        '((tab-mark ?\t [?\xBB ?\t])))

  ;; 発動
  (global-whitespace-mode 1))


(provide 'packages)
