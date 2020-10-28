;;; rope-read-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rope-read-mode" "rope-read-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from rope-read-mode.el

(autoload 'rope-read-mode "rope-read-mode" "\
Rope Reading mode.

If called interactively, enable Rope-Read mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

In rope-read-mode every other line gets reversed.  rope-read-mode is a
view only mode.

\\{rope-read-mode-map}

This mode can help to save eye movements.

By reversing every other line the reader often just can dip the
gaze at the end of a line to read on instead of doing the
annoying search for the next line at the other side of the text.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rope-read-mode" '("rope-read-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rope-read-mode-autoloads.el ends here
