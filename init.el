(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-maths-menu-enable t)
 '(coq-unicode-tokens-enable nil)
 '(custom-enabled-themes '(manoj-dark))
 '(package-archives
   '(("melpa-stable" . "http://stable.melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
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
(setq inhibit-startup-screen t)
(setq visible-bell 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(workgroups-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-undo-tree-mode)
(global-set-key "\C-cy" '(lambda ()
                           (interactive)
                           (popup-menu 'yank-menu)))

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

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'tuareg 'company-coq 'browse-kill-ring 'company 'discover 'lsp-haskell 'haskell-mode 'lsp-ui 'lsp-mode 'ht 'f 'dash 'lv 'markdown-mode 'proof-general 'rust-mode 'slime 'macrostep 'spinner 'undo-tree 'yasnippet 'workgroups2 'tuareg 'magit 'restclient 'agda2-mode)

(package-initialize)

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

(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))
