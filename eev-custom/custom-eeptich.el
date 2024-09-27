;; Tests: (string-match "^[•] (eepitch-" "Blah")
;;        (string-match "^[•] (eepitch-" " (eepitch-<foo>)")
;;
;; (find-eepitch-intro "3.3. `eepitch-preprocess-line'")
;; (defun eepitch-this-line-killing (&optional debug)
;; "Pitch this line to the target buffer, or eval it as lisp if it starts with `'.
;; This is a variant of `eepitch-this-line': if the line starts with
;; ` (eepitch-<foo>)' then run `(eepitch-<foo>)', `(eepitch-kill)',
;; and `(eepitch-<foo>)'.
;; If the line starts with `', treat it as a comment."
;;   (interactive "P")
;;   (if debug
;;       (find-eepitch-debug-links)
;;     (let ((line (buffer-substring (ee-bol) (ee-eol))))  ; get line contents
;;       (setq line (eepitch-preprocess-line line))        ;   and preprocess it

;;       (cond ((string-match eepitch-comment-regexp line) ; comment lines
;;              (message "Comment: %s" line))

;; 	    ((string-match "^[•] (eepitch-" line)      ; red star eepitch lines:
;; 	     (let ((rest (substring line 2)))		; rest is "(eepitch-<foo>)",
;; 	       (eval (read rest))	                ; run (eepitch-<foo>),
;; 	       (eepitch-kill)				; run (eepitch-kill),
;; 	       (eval (read rest))))	                ; run (eepitch-<foo>)

;;             ((string-match eepitch-regexp line)         ; red star lines
;;              (ee-eval-string-print                      ;  are eval'ed and the
;;               (match-string 1 line)))                   ;  result is printed,

;;             (t (eepitch-prepare)                        ; normal lines
;;                (eepitch-line line))))                   ;  are sent
;;     (ee-next-line 1)))

;; ;; (find-esetkey-links   (kbd "<f7>") 'eepitch-this-line-killing)
;; (define-key eev-mode-map (kbd "<f7>") 'eepitch-this-line-killing)

;; Previous version
;; ================
;; This source code is going to be an e-mail.

;;
;; (find-efunction-links 'eepitch-comint)
;; (find-efunction-links 'eepitch-this-line)

;; (find-evariable-links 'eepitch-regexp)

;; (find-efunction 'eepitch-this-line)
(defvar eepitch-regexp-eepitch "")
(setq eepitch-regexp-eepitch "^[•]\\W\\(\(eepitch-.*\)\\)")

(defun eepitch-this-line-killing (&optional debug)
"Pitch this line to the target buffer, or eval it as lisp if it starts with `'.
 Also, if it starts with `', skip it.
 See: (find-eepitch-intro)
 and: `eepitch', `eepitch-regexp', `eepitch-comment-regexp'."
  (interactive "P")
  (if debug
      (find-eepitch-debug-links)
    (let ((line (buffer-substring (ee-bol) (ee-eol))))  ; get line contents
      (setq line (eepitch-preprocess-line line))        ;   and preprocess it
      (cond ((string-match eepitch-comment-regexp line) ; comment lines
             (message "Comment: %s" line))

	    ((string-match eepitch-regexp-eepitch line)
	     (eval (read (replace-regexp-in-string "^.*?\(" "(" line)))
	     (eepitch-kill)
	     (eval (read (replace-regexp-in-string "^.*?\(" "(" line))))

            ((string-match eepitch-regexp line)         ; red star lines
             (ee-eval-string-print                      ;  are eval'ed and the
              (match-string 1 line)))                   ;  result is printed,
            (t (eepitch-prepare)                        ; normal lines
               (eepitch-line line))))                   ;  are sent
    (ee-next-line 1)))
;; (debug-on-entry 'eepitch-this-line-killing)
;; (cancel-debug-on-entry 'eepitch-this-line-killing)

;; (find-efunctiondescr 'define-key)
(define-key global-map (kbd "<f7>") 'eepitch-this-line-killing)
;; (define-key global-map (kbd "<f8>") 'eepitch-this-line)

;; (find-eepitch-intro "3.3. `eepitch-preprocess-line'")
