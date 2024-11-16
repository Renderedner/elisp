;; I want this function to find the file with the correct date, but it could also
;; have another metadata on the name, separated by ~. Like this: 04-11-2023~blah~bleh~bluh.org
;;  1. List files names.
;;  1. Find file name matching regexp.

(straight-use-package 'ts)
(require 'ts)
;; (ts-now)
;; (ts-format "%d-%m-%Y" (ts-now))
;; (ts-format "%d-%m-%Y" (ts-dec 'day 1 (ts-now)))

(defun daily-get-filename-date-string (filename)
  ()
  (substring filename 0
	       (if (string-match "~" filename)
		   (match-beginning 0)
		 (string-match "\.org" filename))))
(defun daily-gfds-year  (filename) () (substring (daily-get-filename-date-string filename) -4))
(defun daily-gfds-day   (filename) () (substring (daily-get-filename-date-string filename) 0 2))
(defun daily-gfds-month (filename) () (substring (daily-get-filename-date-string filename) 3 5))

(defun daily-get-filename-date (filename)
  ()
  (ts-parse
   (concat (daily-gfds-year filename)  "-"
	   (daily-gfds-month filename) "-"
	   (daily-gfds-day filename))))

(defun daily-get-current-filenames-date-string ()
  ()
  (let ((filename (f-filename (buffer-file-name))))
    (daily-get-filename-date-string filename)))
(defun daily-gcfds-year  () () (substring (daily-get-current-filenames-date-string) -4))
(defun daily-gcfds-day   () () (substring (daily-get-current-filenames-date-string) 0 2))
(defun daily-gcfds-month () () (substring (daily-get-current-filenames-date-string) 3 5))
;; (daily-get-current-filenames-date-string)
;; (daily-gcfds-year)
;; (daily-gcfds-day)
;; (daily-gcfds-month)

(defun daily-get-current-files-date ()
  ()
  (daily-get-filename-date (f-filename (buffer-file-name))))
;; (daily-get-current-files-date)
;; (ts-format "%d-%m-%Y" (daily-get-current-files-date))
;; (ts-format "%d-%m-%Y" (ts-dec 'day 1 (daily-get-current-files-date)))

(defvar my-daily-folder "~/notes/daily/" "Where is the folder where I store my jounals?")
(defun daily-find-file-name (date)
  ()
  "Uses the bash find command to find a file that matches a given date.
   Date must be in the format \"%Y-%m-%d\".
   Returns nil if no file was found"
  (shell-command (concat "find " my-daily-folder "/" date "* | grep \"\\.org$\""))
  (if (with-current-buffer shell-command-buffer-name
	(= (point-max) 1))
      nil
    (let ((file-name (with-current-buffer shell-command-buffer-name
		       (buffer-substring (point-min) (- (point-max) 1)))))
      (if (string= (car (s-split "\s" file-name)) "find:")
	  nil
	file-name))))

;; Todays file functionality
(setq brnm-daily-mode-map (make-sparse-keymap))
(with-eval-after-load 'evil
  (define-key brnm-daily-mode-map (kbd "M-n") #'daily-find-next-note)
  (define-key brnm-daily-mode-map (kbd "M-p") #'daily-find-previous-note))
(define-minor-mode brnm-daily-mode
  "Defines a keymap for interacting and modifying pdf hyperlinks with simple commands.")


(defun my-find-daily-file ()
  "Gets today's date using shell's date command,
     getting shell's output buffers content,
     and find a file with <todays-date>.org,
     in folder <my-daily-folder>"
  (interactive)
  (let*
      ((today-date (ts-format "%d-%m-%Y" (ts-now)))
       (file-name (daily-find-file-name today-date))
       new-file-flag)
    (if (not file-name) ;; Não encontrou arquivo nenhum
	(progn (setq file-name (concat my-daily-folder "/" today-date ".org"))
	       (setq new-file-flag t)))
    (find-file file-name)
    (if new-file-flag (my-insert-big (ts-format "%d %m %Y" (ts-now))))
    (brnm-daily-mode 1)))
(defalias 'mfdf 'my-find-daily-file)

;; movement
(defun daily-find-relative-note (pivot-date number)
  "Will return the filename for the PIVOT-DATE dislocated NUMBER, or nil, if it
   does not exist."
  ()
  (daily-find-file-name (ts-format "%d-%m-%Y" (ts-inc 'day number pivot-date))))

(defun daily-get-nth-relative-note (pivot-date number)
  "current-date -2 will return the second note found backwards
   current-date  4 will return the 4th not found forward"
  ()
  (let ((found-note           pivot-date)
	(count-notes-found    0)
	(notes-to-be-found    (abs number))
	(count-dates-searched 0)
	(current-search-date  nil)
	(displacement         (/ number (abs number)))) ;; 1 if positive -1 if negative
    (while (and found-note (< count-notes-found notes-to-be-found))
      (while (and (not current-search-date) (< count-dates-searched 100))
	(setq current-search-date (daily-find-relative-note (daily-get-filename-date found-note) (* displacement (+ 1 count-dates-searched))))
	(setq count-dates-searched (1+ count-dates-searched))
	)
      (setq found-note current-search-date)
      (if found-note (setq count-notes-found (1+ count-notes-found)))
      )
    found-note
    ))

(defun daily-find-previous-note ()
  (interactive)
  (let ((previous-note (daily-get-nth-relative-note (f-filename (buffer-file-name)) -1)))
    (if previous-note
	(find-file previous-note)))
    (brnm-daily-mode 1))

(defun daily-find-next-note ()
  (interactive)
  (let ((next-note (daily-get-nth-relative-note (f-filename (buffer-file-name)) 1)))
    (if next-note
	(find-file next-note)))
    (brnm-daily-mode 1))

(defun daily-get-date-span (pivot-date span)
  "PIVOT-DATE should be a date in ts format.
   SPAN should be an integer, indicating what other note file names should be returned.
   For example. (daily-get-date-span (current-date) -7) will get the past 7 note files"
  ()
  (let ((filenames (cons pivot-date nil))
	(dislocation (/ span (abs span)))
	(current-file pivot-date))
    (while (and (< (length filenames) (+ 1 (abs span))) current-file)
      (setq current-file (daily-get-nth-relative-note (car filenames) dislocation))
      (when current-file
	  (setq current-file (f-filename current-file))
	  (setq filenames (cons current-file filenames)))
    )
    filenames
  ))
;; (daily-get-date-span "19-03-2024.org" -200)
;; (length (daily-get-date-span "19-03-2024.org" -200))
;; (mapcar (lambda (x) (concat my-daily-folder x)) (daily-get-date-span "19-03-2024.org" -200))

(defun daily-get-todays-note-fname ()
  (f-filename (daily-find-file-name (ts-format "%d-%m-%Y" (ts-now)))))

;; (daily-get-date-span (daily-get-todays-note-fname) -200)
;; (daily-get-date-span (daily-get-todays-note-fname) -7)

