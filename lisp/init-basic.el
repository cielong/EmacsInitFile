;; Check system-type, and if its mac
(setq is-mac (equal system-type 'darwin))
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize)
  ;; Set Back-up directory & version control
  (setq
   backup-by-copying t
   backup-directory-alist
    '(("." . ".~"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t))

;; Using company mode for all the mode
(setq ispell-program-name "/usr/local/bin/ispell")
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'ido-mode)

;; Automatically save compilation
(setq compilation-ask-about-save nil)

;; Turn on set goal column mode
(put 'set-goal-column 'disabled nil)

;; Turn on yasnippet
(add-hook 'after-init-hook 'yas-global-mode)

;; Turn on dired-omit-mode
(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files "^\\.[^.]+$")

;; load extra file-pattern that wants to be ignored
(defvar dired-omit-files-config "~/.emacs.d/.dired-omit-files")

(when (file-exists-p dired-omit-files-config)
  (progn
    (with-temp-buffer
      (insert-file-contents dired-omit-files-config)
      (mapcar (lambda (file-pattern)
		(setq dired-omit-files (concat dired-omit-files "\\|"))
		(setq dired-omit-files (concat dired-omit-files file-pattern)))
	      (split-string (buffer-string) "\n" t)))))

;; sort dir first in dired
(require 'ls-lisp)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)

;; toggle dired-sidebar by default
(use-package dired-sidebar
  :bind (("C-c f" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'ascii)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; toggle ibuffer-sidebar by default
(use-package ibuffer-sidebar
  :bind (("C-c b" . ibuffer-sidebar-toggle-sidebar))
  :ensure t
  :commands (ibuffer-sidebar-toggle-sidebar)
  :config
  (setq ibuffer-sidebar-use-custom-font t)
  (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))

(provide 'init-basic)
