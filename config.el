(add-to-list 'load-path "~/.emacs.d/loadpath")

(when window-system (global-hl-line-mode t))
(when window-system (global-prettify-symbols-mode t))

(setq scroll-conservatively 100)
(setq ring-bell-fufnction 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-start-up-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>") 'ansi-term)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x". smex))

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-x b") 'ibuffer)
(setq ibuffer-expert t)

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") `config-visit)

(defun config-reload ()
  (interactive)
  (save-buffer "config.org")
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun my-split-window-vertically()
  (interactive)
  (split-window-vertically)
  (other-window 1))

(defun my-split-window-horizontally()
  (interactive)
  (split-window-horizontally)
  (other-window 1))

(keymap-global-unset "C-x 3")
(keymap-global-unset "C-x 2")

(keymap-global-set "C-x 2" 'my-split-window-vertically)
(keymap-global-set "C-x 3" 'my-split-window-horizontally)

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-edit-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts '("a" "s" "d" "f" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

(setq org-src-window-setup 'current-window)

(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

(use-package flycheck
  :config
  (global-flycheck-mode))

(line-number-mode 1)
(column-number-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package lsp-mode
  :ensure t
  :init    ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
	 (c-mode . lsp)
	 (c++-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package hungry-delete
  :ensure t
  :bind (("C-c DEL" . hungry-delete-backward))
)

(use-package lsp-ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

(use-package counsel
  :ensure t)



(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'org-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package dap-mode
  :ensure t)

(with-eval-after-load 'lsp-mode
  (require 'dap-cpptools))

(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package dashboard     
  :ensure t     
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-item '((recents . 10)))
  (setq dashboard-banner-logo-title "Gru"))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))
