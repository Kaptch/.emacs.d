(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-indent-box-style t)
 '(coq-maths-menu-enable t)
 '(coq-smie-monadic-tokens
   '((";;" . ";; monadic")
     ("do" . "let monadic")
     ("<-" . "<- monadic")
     (";" . "in monadic")
     (";;;" . ";; monadic")))
 '(coq-smie-user-tokens '(("∗" . "*")
			  ("-∗" . "->")
			  ("∗-∗" . "<->")
			  ("==∗" . "->")
			  ("⊢" . "->")
			  ("⊣⊢" . "<->")
			  ("⋅" . "*")
			  (":>" . ":=")
			  ("by" . "now")
			  ("forall" . "now")))
 '(coq-unicode-tokens-enable nil)
 '(custom-enabled-themes '(manoj-dark))
 '(org-agenda-files nil)
 '(package-archives
   '(("melpa-stable" . "http://stable.melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(excorporate workgroups2 undo-tree tuareg slime rust-mode restclient proof-general magit lsp-ui lsp-haskell git discover company-coq browse-kill-ring agda2-mode))
 '(proof-delete-empty-windows t)
 '(proof-disappearing-proofs nil)
 '(proof-shell-eager-annotation-end
   "\377\\|done\\]\\|</infomsg>\\|</warning>\\|\\*\\*\\*\\*\\*\\*\\|) >")
 '(proof-shell-eager-annotation-start
   "\376\\|\\[Reinterning\\|Warning:\\|TcDebug \\|<infomsg>\\|<warning>")
 '(proof-shell-init-cmd
   '("Add Search Blacklist \"Private_\" \"_subproof\". " "Set Suggest Proof Using. "))
 '(proof-splash-enable nil)
 '(proof-three-window-enable t))

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(defun ensure-package-installed (&rest packages)
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
	   (progn
	     (package-refresh-contents)
             (package-install package))
         package)))
   packages))

(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'manoj-dark)
(display-time-mode 1)
(setq column-number-mode t)
; proof general cursor
(setq overlay-arrow-string "")
(setq coq-compile-before-require t)
(setq inhibit-startup-screen t)
(setq visible-bell 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(workgroups-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-undo-tree-mode)
(epa-file-enable)
(global-set-key "\C-cy" '(lambda ()
                           (interactive)
                           (popup-menu 'yank-menu)))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)
(global-company-mode)
(if (file-readable-p (expand-file-name "aux.el" user-init-dir))
    (load-user-file "aux.el")
  )
(if (boundp 'outlook_email)
    (setq excorporate-configuration (quote (outlook_email . "https://outlook.office365.com/EWS/Exchange.asmx")))
  )

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
                    :height 0.7)
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'calendar-iso-week-face))

(ensure-package-installed 'tuareg 'company-coq 'browse-kill-ring 'company 'discover 'lsp-haskell 'haskell-mode 'lsp-ui 'lsp-mode 'ht 'f 'dash 'lv 'markdown-mode 'proof-general 'rust-mode 'slime 'macrostep 'spinner 'undo-tree 'yasnippet 'workgroups2 'tuareg 'magit 'restclient 'agda2-mode 'excorporate)

(package-initialize)

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (push 'company-elisp company-backends)))
(add-hook 'coq-mode-hook
	  (lambda () (progn
		       (undo-tree-mode 1)
		       (global-set-key "\C-cy" '(lambda ()
						  (interactive)
						  (popup-menu 'yank-menu))))))
(add-hook 'coq-mode-hook #'company-coq-mode)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
    (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
    (autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
      "Configuration of imenu for tuareg" t)        
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist 
        (append '(("\\.ml[ily]?$" . tuareg-mode)
	          ("\\.topml$" . tuareg-mode))
                  auto-mode-alist))

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
