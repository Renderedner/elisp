;; (find-dailyfile "18-03-2024.org")
(setq prompt-for-resuming-daily-file "User: Resume the text, using category words, on a single sentence. Explaining the contents of each category.")
;; (setq prompt-for-resuming-daily-file "User: Classify the text with with a score from 1 to 10. 1 meaning that the autor is absolutely mentally ill, and 10 meaning that he is happy and clear minded. Also provide fragments of the text that justify the score. Be brief. The answer should be in the following format: <score> '(\"fragment1\" ... \"fragmentN\")")
;; (setq prompt-for-resuming-daily-file "Score the text from 1 to 10 based on apparent good mood of the writer. Present the answer inline in the following format \"<score> <comma separated list of relevant text fragments>\"")
(setq file-to-accumulate-resumes     (concat my-daily-folder ".gpt-resume"))

(defun my-gpt-set-process-sentinel (process timer prompt-file next-func)
  "Based on (find-emxgptfile "gpt.el" "defun gpt-set-process-sentinel")
  "
  (set-process-sentinel process
                        (lambda (proc status)
                          (when (memq (process-status proc) '(exit signal))
                            (cancel-timer timer)
                            (if (zerop (process-exit-status proc))
                                (progn
                                  (delete-file prompt-file)
                                  (message "GPT: Finished successfully.")
				  )
                              (message "GPT: Failed: %s" status))
			    (funcall next-func)))))

;; (find-emxgptfile "gpt.el" "defun gpt-run-buffer")
(eval
 '(defun get-gpt-resume-from-file-list (filelist)
  ()
  (if filelist
      (with-temp-buffer 
	(message (car filelist))
	(insert (concat "User:\n\n```\n" (save-window-excursion (find-file (car filelist)) (buffer-string)) "```"))
	(let* ((prompt-buffer (current-buffer))
	       (output-buffer (save-window-excursion
				(find-file file-to-accumulate-resumes)
				(goto-char (point-max))
				(insert (concat "\n" (car filelist) ":"))
				(current-buffer)))
	       (prompt-file (save-window-excursion
			      (find-file (gpt-create-prompt-file prompt-buffer))
			      (goto-char (point-max))
			      (insert "\n\n\n" prompt-for-resuming-daily-file)
			      (save-buffer)
			      (buffer-file-name)))
	       (process (gpt-start-process prompt-file output-buffer))
	       (timer (gpt-start-timer process)))
	  (set-process-sentinel process
				(lambda (proc status)
				  (when (memq (process-status proc) '(exit signal))
				    (cancel-timer timer) ;; This needs lexical binding
				    (if (zerop (process-exit-status proc))
					(progn
					  (delete-file prompt-file)
					  (message "GPT: Finished successfully.")
					  )
				      (message "GPT: Failed: %s" status))
				    (funcall #'get-gpt-resume-from-file-list (cdr filelist)))))))
    nil)) t )

;; (debug-on-entry 'get-gpt-resume-from-file-list)
;; (cancel-debug-on-entry 'get-gpt-resume-from-file-list)
;; (get-gpt-resume-from-file-list `(,(buffer-file-name) "/home/odecam/notes/daily/02-01-2024.org"))
;; (get-gpt-resume-from-file-list `(,(buffer-file-name) "02-01-2024.org" "02-02-2024.org" "02-03-2024.org" "02-09-2023.org" "03-02-2024.org" "03-03-2024.org" "03-12-2023.org" "04-01-2024.org" "04-02-2024.org" "04-03-2024.org" "04-09-2023.org"))
;; (find-file file-to-accumulate-resumes)
;; (get-gpt-resume-from-file-list (mapcar (lambda (x) (concat my-daily-folder x)) (daily-get-date-span "04-04-2024.org" -7)))
;; (get-gpt-resume-from-file-list (mapcar (lambda (x) (concat my-daily-folder x)) (daily-get-date-span "19-03-2024.org" -200)))
