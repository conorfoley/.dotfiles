(defun toggle-indent ()
  (if (equal js2-basic-offset 2)
      (setq-local js2-basic-offset 4)
    (setq-local js2-basic-offset 2)))
