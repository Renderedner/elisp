;; (find-dailyfile "14-03-2024.org")
(defun firstfunc (regexp)
  (interactive "s")
  "Função genérica que, dada uma regexp, seleciiona apenas a linhas que possuem
   um match, e cria um novo parágrafo com essas linhas. É útil para criar parágrafos
   filtrados com apenas um método de pagamento, etc... "
  (mark-paragraph)
  (let ((result
	 (mapcar
	  (lambda (x) (if (string-match regexp x) (concat x "\n") nil))
	  (s-lines (buffer-substring-no-properties (point) (mark))))))
    (deactivate-mark)
    (forward-paragraph)
    (insert "\n\n" (apply #'s-concat (-non-nil result)))))

(defun cartaofunc ()
  (interactive)
  "Filtra o parágrafo atual, e criar um novo parágrafo abaixo apenas com as vendas
   no cartão."
  (firstfunc "cart[aã]o"))

;; (find-dailyfile "13-03-2024.org")
(defun count-total ()
  (interactive)
  "Soma os valores de um parágrafo e insere o valor abaixo."
  (save-excursion
    (let ((price-list nil) limit)
      (search-backward "\n\n;;")
      (setq limit (save-excursion (search-forward "\n\n" nil t 2) (match-beginning 0)))
      (while (< (if (search-forward-regexp "[0-9]+" nil 1) (match-beginning 0) (point)) limit)
	(setq price-list (cons (string-to-number (match-string 0)) price-list))
	(forward-line 1))
      (goto-char limit)
      (insert (concat "\n\n" (number-to-string (apply #'+ price-list)))))))

(defalias 'ct 'count-total)
(defalias 'ff 'firstfunc)
