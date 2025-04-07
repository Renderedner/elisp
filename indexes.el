;; <find-index0-links>
;; Skel: (find-find-links-links-new "index0" "" "other-links")
;; Test: (find-index0-links)
;;
(defun find-index0-links (&rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for index0."
  (interactive)
  (let* ((other-links "{other-links}"))
    (apply
     'find-elinks
     `((find-index0-links ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-index0-links)
       ""
       ,(ee-template0 "\
")
       
       )
     pos-spec-list)))
