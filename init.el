;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
;; (setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; (let* ((org-dir (expand-file-name
;;                  "lisp" (expand-file-name
;;                          "org" (expand-file-name
;;                                 "src" dotfiles-dir))))
;;        (org-contrib-dir (expand-file-name
;;                          "lisp" (expand-file-name
;;                                  "contrib" (expand-file-name
;;                                             ".." org-dir))))
;;        (load-path (append (list org-dir org-contrib-dir)
;;                           (or load-path nil))))
;;   ;; load up Org-mode and Org-babel
;;   (require 'org-install)
;;   (require 'ob-tangle))

;; ;; load up all literate org-mode files in this directory
;; (mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

;;; init.el ends here

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)

;; optional. makes unpure packages archives unavailable
(setf package-archives nil)

(setf package-enable-at-startup nil)
(package-initialize)

(org-babel-load-file "~/.emacs.d/config.org")

;; (require 'org-install)
;; (require 'ob-tangle)
;; (org-babel-load-file (concat user-emacs-directory "config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-agenda-files
   '("~/VirtualHome/src/ical2org/events.org" "/home/user1/org/work.org" "/home/user1/org/notes.org" "/home/user1/org/home.org" "/home/user1/org/fromhome.org"))
 '(org-re-reveal-script-files '("js/reveal.js"))
 '(package-selected-packages
   '(pyvenv-auto auto-virtualenv pyenv-mode sql-indent xref-js2 jedi-direx jedi flymake-python-pyflakes ein rope-read-mode guix flycheck-pycheckers jupyter ob-ipython spacemacs-theme flycheck-pyflakes anaconda-mode ag ox-reveal ox-hugo ox-gfm org-alert syslog-mode nlinum rainbow-delimiters ac-geiser auto-complete-pcmp auto-complete paredit geiser))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(python-indent-guess-indent-offset-verbose nil)
 '(safe-local-variable-values
   '((flycheck-pycheckers-venv-root . "~/.pyenv/versions")
     (python-environment-virtualenv quote
				    ("pyenv" "activate" "3.12.1/envs/venv"))
     (python-environment-directory . "~/.pyenv/versions")
     (geiser-repl-per-project-p . t)
     (eval add-hook 'before-save-hook 'time-stamp)
     (eval when
	   (locate-library "rainbow-mode")
	   (require 'rainbow-mode)
	   (rainbow-mode))
     (org-babel-noweb-wrap-end . &ldquo)
     (org-babel-noweb-wrap-start . &ldquo)
     (eval let
	   ((root-dir-unexpanded
	     (locate-dominating-file default-directory ".dir-locals.el")))
	   (when root-dir-unexpanded
	     (let*
		 ((root-dir
		   (file-local-name
		    (expand-file-name root-dir-unexpanded)))
		  (root-dir*
		   (directory-file-name root-dir)))
	       (unless
		   (boundp 'geiser-guile-load-path)
		 (defvar geiser-guile-load-path 'nil))
	       (make-local-variable 'geiser-guile-load-path)
	       (require 'cl-lib)
	       (cl-pushnew root-dir* geiser-guile-load-path :test #'string-equal))))
     (eval progn
	   (require 'lisp-mode)
	   (defun emacs27-lisp-fill-paragraph
	       (&optional justify)
	     (interactive "P")
	     (or
	      (fill-comment-paragraph justify)
	      (let
		  ((paragraph-start
		    (concat paragraph-start "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
		   (paragraph-separate
		    (concat paragraph-separate "\\|\\s-*\".*[,\\.]$"))
		   (fill-column
		    (if
			(and
			 (integerp emacs-lisp-docstring-fill-column)
			 (derived-mode-p 'emacs-lisp-mode))
			emacs-lisp-docstring-fill-column fill-column)))
		(fill-paragraph justify))
	      t))
	   (setq-local fill-paragraph-function #'emacs27-lisp-fill-paragraph))
     (eval with-eval-after-load 'yasnippet
	   (let
	       ((guix-yasnippets
		 (expand-file-name "etc/snippets/yas"
				   (locate-dominating-file default-directory ".dir-locals.el"))))
	     (unless
		 (member guix-yasnippets yas-snippet-dirs)
	       (add-to-list 'yas-snippet-dirs guix-yasnippets)
	       (yas-reload-all))))
     (eval add-to-list 'completion-ignored-extensions ".go")
     (magit-todos-exclude-globs "elisp-files*" "elpa*")
     (magit-todos-exclude-globs "elpa*")
     (eval let
	   ((root-dir-unexpanded
	     (locate-dominating-file default-directory ".dir-locals.el")))
	   (when root-dir-unexpanded
	     (let*
		 ((root-dir
		   (expand-file-name root-dir-unexpanded))
		  (root-dir*
		   (directory-file-name root-dir)))
	       (unless
		   (boundp 'geiser-guile-load-path)
		 (defvar geiser-guile-load-path 'nil))
	       (make-local-variable 'geiser-guile-load-path)
	       (require 'cl-lib)
	       (cl-pushnew root-dir* geiser-guile-load-path :test #'string-equal))))
     (eval setq-local guix-directory
	   (locate-dominating-file default-directory ".dir-locals.el"))
     (org-babel-noweb-wrap-end . "&gt;&gt;#")
     (org-babel-noweb-wrap-start . "#&lt;&lt;")
     (org-repo-nbs-root . /home/user1/src/nbdev-org-babel-example/nbs)
     (org-repo-root . /home/user1/src/nbdev-org-babel-example)
     (org-repo-root . /home/user1/src/nbdev-projects/awesomelib)
     (org-repo-root . "../../")
     (geiser-scheme-implementation . guile)
     (org-babel-noweb-wrap-end . ">>;;")
     (org-babel-noweb-wrap-start . ";;<<")
     (org-src-preserve-indentation . t)
     (org-my-aNumber . 32)
     (org-my-foo . bar)
     (org-babel-noweb-wrap-end . \">>)
     (org-babel-noweb-wrap-start . \")
     (org-confirm-babel-evaluate)
     (org-babel-noweb-wrap-end . ">>#")
     (org-babel-noweb-wrap-start . "#<<")
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")))
 '(smtpmail-smtp-server "mail.selfhosted.xyz")
 '(smtpmail-smtp-service 25)
 '(vc-follow-symlinks nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(popup-face ((t (:foreground "cyan"))))
 '(popup-tip-face ((t (:foreground "cyan")))))
