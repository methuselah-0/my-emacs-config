(org-export-define-derived-backend 'mymd 'md
  :menu-entry
  '(?y "Export to My Markdown"
       ((?M "To temporary buffer"
            (lambda (a s v b) (org-mymd-export-as-markdown a s v)))
        (?m "To file" (lambda (a s v b) (org-mymd-export-to-markdown a s v)))
        (?o "To file and open"
            (lambda (a s v b)
              (if a (org-mymd-export-to-markdown t s v)
                (org-open-file (org-mymd-export-to-markdown nil s v)))))))
  :translate-alist '((example-block . org-mymd-example-block)
                     (fixed-width . org-mymd-example-block)
                     (src-block . org-mymd-example-block)))

(defun org-mymd-example-block (example-block _content info)
  "Transcode element EXAMPLE-BLOCK as ```lang ...```."
  (format "```%s\n%s\n```"
          (org-element-property :language example-block)
          (org-remove-indentation
           (org-export-format-code-default example-block info))))

;;;###autoload
(defun org-mymd-export-as-markdown (&optional async subtreep visible-only)
  "See `org-md-export-as-markdown'."
  (interactive)
  (org-export-to-buffer 'mymd "*Org My MD Export*"
    async subtreep visible-only nil nil (lambda () (text-mode))))

;;;###autoload
(defun org-mymd-convert-region-to-md ()
  "See `org-md-convert-region-to-md'."
  (interactive)
  (org-export-replace-region-by 'mymd))

;;;###autoload
(defun org-mymd-export-to-markdown (&optional async subtreep visible-only)
  "See `org-md-export-to-markdown'."
  (interactive)
  (let ((outfile (org-export-output-file-name ".md" subtreep)))
    (org-export-to-file 'mymd outfile async subtreep visible-only)))

;;;###autoload
(defun org-mymd-publish-to-md (plist filename pub-dir)
  "Analogous to `org-md-publish-to-md'."
  (org-publish-org-to 'mymd filename ".md" plist pub-dir))
