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
 '(org-re-reveal-script-files '("js/reveal.js"))
 '(package-selected-packages
   '(flymake-python-pyflakes rope-read-mode ob-ipython ein guix flycheck-pycheckers jedi spacemacs-theme flycheck-pyflakes jupyter anaconda-mode ag ox-reveal ox-hugo ox-gfm org-alert syslog-mode nlinum rainbow-delimiters ac-geiser auto-complete-pcmp auto-complete paredit geiser))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(python-indent-guess-indent-offset-verbose nil)
 '(safe-local-variable-values
   '((org-repo-nbs-root . /home/user1/src/nbdev-org-babel-example/nbs)
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
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
