;;; nic's crystal stuff  -*- lexical-binding: t -*-

(defun nic-crystal-compile-setup ()
  "Add this to `crystal-mode' hook.

It sets up your compile function to a build for the current
file."
  (let* ((bf (buffer-file-name))
	 (abs-bf (expand-file-name bf))
	 (dir (locate-dominating-file bf "shard.yml"))
	 (abs-dir (expand-file-name dir))
	 (sub-file (prog2
		     (string-match (format "%s\\(.*\\)" abs-dir) abs-bf)
		     (match-string 1 abs-bf)))
	 (command (format "cd %s ; crystal build %s" dir sub-file)))
    (make-local-variable 'compile-command)
    (setq compile-command command)))


;; Init the hook connectivity unless prevented from doing so
(unless (and (fboundp 'nic-crystal-compile-setup-stop)
	     (eval 'nic-crystal-compile-setup-stop))
  (add-hook 'crystal-mode-hook
	    'nic-crystal-compile-setup))

;;; nic-crystal.el ends here
