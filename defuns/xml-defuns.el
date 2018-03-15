(defun indent-xml ()
  (interactive)
  (goto-char (point-min))
  (replace-regexp ">" ">\n" nil (point-min) (point-max) t)
  (goto-char (point-min))
  (replace-regexp "\\([a-z0-9A-Z]\\)</" "\\1\n</" nil (point-min) (point-max) t)
  (cleanup-buffer))