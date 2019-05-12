(use-package evil
  :straight t
  :commands (evil-mode evil-define-key)
  :config
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search)
  (defvar evil-want-C-u-scroll t)
  (setq evil-ex-search-vim-style-regexp t
        evil-ex-substitute-global t)
  (define-key evil-normal-state-map (kbd "C-c +") #'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") #'evil-numbers/dec-at-pt)
  (define-key evil-motion-state-map (kbd ";") #'evil-ex)
  (define-key evil-motion-state-map (kbd ":") #'evil-repeat-find-char)
  (use-package evil-leader
    :straight t
    :commands (evil-mode evil-define-key)
    :config
    (evli-leader/set-leader ",")
    (evli-leader/set-key
    "e" #'find-file
    "b" #'switch-to-buffer)))


(provide 'evil)
