(setq evil-want-keybinding nil)

(use-package evil
  :straight t
  :commands (evil-mode evil-define-key)
  :config
  (evil-mode 1)

  (evil-select-search-module 'evil-search-module 'evil-search)
  ;;(defvar evil-want-C-u-scroll t)
  (setq evil-ex-search-vim-style-regexp t
        evil-ex-substitute-global t)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-insert-state-map (kbd "C-u")
    (lambda ()
      (interactive)
      (evil-delete (point-at-bol) (point))))
  (define-key evil-normal-state-map (kbd "C-c +") #'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") #'evil-numbers/dec-at-pt)
  (define-key evil-normal-state-map (kbd "<RET>") 'nil)
  (define-key evil-normal-state-map (kbd "<RET> <RET>") #'save-buffer)
  (define-key evil-motion-state-map (kbd ";") #'evil-ex)
  (define-key evil-motion-state-map (kbd ":") #'evil-repeat-find-char))

(use-package evil-leader
  :straight t
  :after evil
  :config
  (global-evil-leader-mode t)
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "e" 'find-file
    "b" 'switch-to-buffer))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(provide 'evil)
