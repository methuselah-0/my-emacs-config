(require 'cl-lib)

(defun my--get-venv-names-for-completion ()
  (list (completing-read "project-name: "
			 (directory-files (expand-file-name "~/src")
					  nil
					  "^[^._]")
			 nil
			 t)))

(defvar my-jupyter-kernels-dir
  (expand-file-name "~/.pyenv/versions/jupyter_only/share/jupyter/kernels")
  "Location of kernels that can be run via `jupyter-run-repl'")

(defun my-jupyter-add-kernel (project-path)
  "Create a kernelspec for KERNEL and add it for use with `emacs-jupyter'.

The list of kernels available for adding is constructed from
virtual environments found in `~/envs/`."
  (interactive (my--get-venv-names-for-completion))
  (when (member project-path (cl-map 'list 'car (jupyter-available-kernelspecs)))
    (error (format "Kernel \"%s\" is already added" project-path)))
  ;; (let* ((argv (vector (expand-file-name (format "~/.pyenv/versions/%s/bin/python3" kernel))
  (let* ((argv (vector (expand-file-name (concat "~/src/" project-path "/pybin"))
		       "-m"
		       "ipykernel_launcher"
		       "-f"
		       "{connection_file}"))
	 (content (json-serialize
		   `(:argv ,argv :display_name ,project-path :language "python")))
	 (kernel-dir (format "%s/%s" my-jupyter-kernels-dir project-path)))
    (make-directory kernel-dir)
    (let ((save-silently t))
      (append-to-file content nil (format "%s/kernel.json" kernel-dir))))
  (jupyter-available-kernelspecs t))

(defun my-jupyter-delete-kernel (kernel)
  "Remove KERNEL from available kernelspecs and delete its files."
  (interactive (list (completing-read "kernel to delete: "
				      (cl-map 'list 'car (jupyter-available-kernelspecs))
				      nil
				      t)))
  (when (equal kernel "") (error "No kernel selected"))
  (delete-directory (format "%s/%s" my-jupyter-kernels-dir kernel) t)
  (jupyter-available-kernelspecs t))
