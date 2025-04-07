; «pavucontrol-key»  (to ".pavucontrol-key")
; «rstdoc-react»  (to ".rstdoc-react")
; «daily-search»  (to ".daily-search")
; «official-org-abandon»  (to ".official-org-abandon")
; «rst-doc-prep»  (to ".rst-doc-prep")
;; «ee-rstdoc-:gunicorn»  (to ".ee-rstdoc-:gunicorn")
;; «ee-rstdoc-:flask»  (to ".ee-rstdoc-:flask")
; «my-eewrap-eepitch»  (to ".my-eewrap-eepitch")
;; «ee-rstdoc-:flasklogin»  (to ".ee-rstdoc-:flasklogin")
;; «ee-rstdoc-:gdal»  (to ".ee-rstdoc-:gdal")
;; «ee-rstdoc-:rasterio»  (to ".ee-rstdoc-:rasterio")
;; «ee-rstdoc-:geopandas»  (to ".ee-rstdoc-:geopandas")
;   «geopandas_api_tofile»  (to ".geopandas_api_tofile")
;; «ee-rstdoc-:pyproj»  (to ".ee-rstdoc-:pyproj")
;   «pyproj-api-geod»  (to ".pyproj-api-geod")
;; «ee-rstdoc-:shapely»  (to ".ee-rstdoc-:shapely")
;; «dudasd-project»  (to ".dudasd-project")
;; «api-linestring»  (to ".api-linestring")
; «cria-anchor-direita-texto»  (to ".cria-anchor-direita-texto")
; «h2m-scan»  (to ".h2m-scan")
; «gpt»  (to ".gpt")
; «pdf-view-enable-midnight-mode»  (to ".pdf-view-enable-midnight-mode")

(set-frame-font "Iosevka 9" nil t)

;; https://github.com/radian-software/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

;; https://github.com/radian-software/straight.el#install-packages

(add-to-list 'load-path default-directory)

(straight-use-package 'EXWM)
(straight-use-package 'xelb)
(load "my-exwm-config")
; (find-fline "./my-exwm-config.el")

(straight-use-package 'tao-theme)
(setq tao-theme-use-boxes nil)
(setq tao-theme-use-sepia nil)
(setq tao-theme-use-height nil)
;; (load-theme 'tao-yin)
;; (face-attribute 'font-lock-function-name-face :weight)
(set-face-attribute 'font-lock-function-name-face nil :weight 'bold)

;; (straight-use-package '(eev :host github
;; 			    :repo "edrx/eev"
;; 			    :branch "UTF-8"))
(add-to-list 'load-path "~/clones/eev/")
(require 'eev-load)
(load "eev-load")
(eev-mode 1)
(load "eev-custom/code-c-ds")
(load "eev-custom/main")
(load "eev-custom/templates")
(load "eev-custom/custom-eejump")
(load "eev-custom/custom-eeptich")
(load "eev-custom/utils.el")
;; (find-fline "./eev-custom/code-c-ds.el")
;; (find-fline "./eev-custom/main.el")


(straight-use-package 'swiper)

; Mini-buffer completion
(straight-use-package 'orderless)
(straight-use-package 'selectrum)
(straight-use-package 'marginalia)
(require 'orderless)
(add-to-list 'orderless-matching-styles 'orderless-prefixes)
(require 'selectrum)
(selectrum-mode 1)
(setq selectrum-refine-candidates-function #'orderless-filter)
(setq selectrum-highlight-candidates-function #'orderless-highlight-matches)
(require 'marginalia)
(marginalia-mode)

;; Evil and keybinds config
(straight-use-package 'evil)
; (find-fline "./evil-and-keybinds-config.el")
(load "evil-and-keybinds-config")

; LSP-MODE
(straight-use-package 'lsp-mode)
(require 'lsp-mode)
; Javascript-Typescript
; https://emacs-lsp.github.io/lsp-mode/page/lsp-typescript/
; npm install -g typescript-language-server typescript
(straight-use-package 'origami)
(require 'origami)
(straight-use-package 'company)
(require 'company)
; company-backends
; https://github.com/tigersoldier/company-lsp
(straight-use-package 'company-lsp)
(require 'company-lsp)
(setq company-backends '(company-lsp))
(straight-use-package 'yasnippet)
(require 'yasnippet)

(straight-use-package 'vterm)
(require 'vterm)
(put 'narrow-to-region 'disabled nil)

(straight-use-package 'pdf-tools)
(require 'pdf-tools)
(pdf-tools-install)

(straight-use-package 'org-transclusion)

(straight-use-package 'elpy)
;; (elpy-enable)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(straight-use-package 'evil-mc)
(global-evil-mc-mode 1)

(defun brnm-toggle-hide-emphasis-markers () (interactive)
       (if org-hide-emphasis-markers
	   (setq org-hide-emphasis-markers nil)
	 (setq org-hide-emphasis-markers t))
       (org-mode-restart))
(defalias 'bthem 'brnm-toggle-hide-emphasis-markers)

; Define oque esconder quando se utiliza o dired
(with-eval-after-load 'dired
  (require 'dired-x)
  (setq dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'\\|^\\.\\|^_"))
(add-hook 'dired-mode-hook
 (lambda () (dired-omit-mode 1) ))

;; (replace-regexp "^\"\"\"\n\\(.*\n\\)+?\"\"\"" "")
;; (replace-regexp "^\s*#\s*(.*" "")

(straight-use-package 'minimap)
(with-eval-after-load 'minimap
  ;; (set-face-attribute 'minimap-font-face nil :height 30)
  (set-face-background 'minimap-active-region-background "gray15") 
  (set-face-attribute 'minimap-font-face nil :height 15))

(straight-use-package 'crdt)
(setq crdt-use-tuntox t)
(setq crdt-tuntox-executable "/usr/bin/tuntox")

(straight-use-package 'lua-mode)

(straight-use-package 'glsl-mode)

(straight-use-package 'rg)


;; (find-fline "~/p/meta/")
(add-to-list 'load-path "~/.config/emacs/meta-package")
;; (find-fline "meta-package/")
(load "meta-package/overlay-hide.el")
(load "meta-package/new.el")
(load "meta-package/sepia-fontlock.el")
(load "meta-package/intra-search.el")
(load "meta-package/parallel-commit.el")
(load "meta-package/meta-file-double-link.el")
(load "meta-package/link-to-region.el")
(load "meta-package/overlay-meta-file.el")

(load "toggle")

(load "link")
;; (find-fline "link.el")

(load "daily")
;; (find-fline "daily.el")

(load "center")
;; (find-fline "center.el")


(setq org-hide-emphasis-markers t)

(straight-use-package 'git-gutter-fringe)

(straight-use-package 'counsel)

;; (find-dailyfile "10-12-2023.org" "(( FIND ATOMIC LINKS WITH REGEXP ))")
(defun atmn () (interactive) (rg "^\\(\\([[:space:]]([A-Z\-ÇÁÉÍÓÚÂÊÎÛÔÃÕ]+[[:space:]])+\\)\\)" "**" "~/daily"))
(defun actnbl () (interactive) (let ((rg-command-line-flags '("-U"))) (rg "^\\(!\\)([[:space:]][A-Z\-ÇÁÉÍÓÚÂÊÎÛÔÃÕ]+)+.?(\\(.+\\))?\\n.+" "*" "~/daily")))

(evil-define-key '(normal visual replace insert) global-map (kbd "M-k") (lambda () (interactive) (kill-buffer (current-buffer))))

(display-time)
(display-battery-mode)

(straight-use-package '(awesome-tray :host github
				     :repo "manateelazycat/awesome-tray"))
;; (awesome-tray-mode 1)

(defvar brnm-screen-on-p nil "Wether screen is turned on")
(defun brnm-toggle-screen-on-off ()
  (interactive)
  (if brnm-screen-on-p
      (progn
	(setq brnm-screen-on-p nil)
	(shell-command "sudo vbetool dpms off"))
    (setq brnm-screen-on-p t)
    (shell-command "sudo vbetool dpms on")))
(defalias 'btsof 'brnm-toggle-screen-on-off)

;; (find-dailycaps "10-01-2024.org" "go back to link")
(defun brnm-mark-before-fline (str &rest r) ()
(push-mark (point))
(deactivate-mark))
(advice-add 'find-fline :before 'brnm-mark-before-fline)

(server-start)

(setq brnm-toggle-theme-whitep nil)
(defun brnm-toggle-theme-tao ()
  (interactive)
  (if brnm-toggle-theme-whitep
      (progn
	(setq brnm-toggle-theme-whitep nil)
	(load-theme 'tao-yin))
    (setq brnm-toggle-theme-whitep t)
    (load-theme 'tao-yang)))
(defalias 'bttt 'brnm-toggle-theme-tao)


; «.gpt»	(to "gpt")
(straight-use-package 'gpt)
(require 'gpt)
;; (setq gpt-openai-engine "gpt-3.5-turbo-0125")
;; (setq gpt-openai-engine "gpt-4")
;; https://community.openai.com/t/tier-3-api-account-but-no-access-to-o3-mini-receiving-http-error-400-invalid-model-id/1116313/2
;; (setq gpt-openai-engine "o3-mini")
; (setq gpt-openai-engine "gpt-4o-mini")
(setq gpt-openai-key    (getenv "OPENAI_KEY"))
;; (setq gpt-openai-key    "")

; (find-fline "/home/redner/.emacs.d/straight/repos/gpt.el/gpt2.py")
(setq gpt-script-path "/home/redner/.emacs.d/straight/repos/gpt.el/gpt2.py")
(setq gpt-openai-engine "o3-mini")

;; (find-dailyfile "18-03-2024.org")
(defun brnm-find-ip-address ()
  (interactive)
  (let ((ip-list nil)
	(index   1  ))
    (while (< index 30)
      (setq ip-list (cons (cons (concat "192.168.1." (number-to-string index)) (number-to-string index)) ip-list))
      (setq index (+ 1 index)))
    (switch-to-buffer (get-buffer-create "*finding-ip*"))
    (brnm-find-ip-address-given-list ip-list)))

(defun brnm-find-ip-address-given-list (ip-list)
  (mapcar
   (lambda (x) (set-process-sentinel
		(start-process (concat (cdr x) "\t" (car x)) nil "ssh" (concat "brnm@" (car x)))
		(lambda (process status)
		  (save-window-excursion
		  (get-buffer-create "*finding-ip*")
		  (goto-char (point-max))
		  (insert (concat
			   (process-name process) ":\t"
			   (substring status 0 -1) " "
			   (symbol-name (process-status process)) "\n"))
		  (sort-numeric-fields 1 (point-min) (point-max))))))
   ip-list))
;; (brnm-find-ip-address)


(defun brnm-inser-first-posspec-in-next-sexp-hyperlink ()
  (interactive)
  (beginning-of-line)
  (if (search-forward-regexp "\".+?\"" nil t 2)
      (let ((pp (match-string 0)))
	(forward-line 1)
	(if (search-forward-regexp "\".+?\"")
	    (progn (goto-char (match-end 0))
		   (insert (concat " " pp)))))))
(defalias 'bifpp 'brnm-inser-first-posspec-in-next-sexp-hyperlink)

(defun tmst ()
  (interactive)
  (insert (ts-format "[%d-%m-%Y|%H:%M]" (ts-now))))


(defun leuvend ()
  (interactive)
  (load-theme 'leuven-dark))
(defun leuven ()
  (interactive)
  (load-theme 'leuven))
(defun tao ()
  (interactive)
  (load-theme 'tao-yang))
(defun taod ()
  (interactive)
  (load-theme 'tao-yin))


(straight-use-package 'tree-edit)
(straight-use-package 'evil-tree-edit)
(straight-use-package 'which-key)
(which-key-mode 1)

(defun my-insert-big (string)
    (interactive "s")
  (insert (s-replace-regexp "^" ";; " 
	   (shell-command-to-string (concat "figlet " string)))))
(defalias 'mib 'my-insert-big)

(defun brnm-delete-second-posspec ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (search-forward "(")
    (search-forward-regexp "\\ \".+?\""  nil nil 2)
    (delete-region (match-beginning 0) (match-end 0))))
(evil-define-key '(normal insert) global-map (kbd "C-M-d") #'brnm-delete-second-posspec)

;; <awesome_tray>
;; awesome-tray-active-modules

(require 'awesome-tray)
(global-hide-mode-line-mode 1)
(awesome-tray-mode          1)
(add-to-list 'awesome-tray-active-modules "buffer-name")
(add-to-list 'awesome-tray-active-modules "file-path")
;; awesome-tray-active-modules 

(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-langs)

(setq treesit-extra-load-path '("~/clones/tree-sitter-module/dist"))
;; (find-mfile "firstp.e" "Helpfull post\n======== ====")

(add-to-list 'auto-mode-alist '("\\.e\\'". emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'". tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'". tsx-ts-mode))

(defun brnm-toggle-visualizer ()
  (interactive)
  (if (string= (buffer-name) "VISUALIZER")
      (winner-undo)
    (let ((b (get-buffer "VISUALIZER")))
      (if b
	  (switch-to-buffer b)
	(rename-buffer "VISUALIZER"))
      )))

(defun brnm-toggle-music-buffer ()
  (interactive)
  (if (string= (buffer-name) "music")
      (winner-undo)
    (let ((b (get-buffer "music")))
      (if b
	  (switch-to-buffer b)
	(rename-buffer "music"))
      )))

(define-key global-map (kbd "s-m") #'brnm-toggle-music-buffer)

(defun brnm-set-full-page () (setq pdf-view-display-size 'fit-height))
(add-hook 'pdf-view-mode-hook #'brnm-set-full-page)

(defun print-screen () (interactive) (async-shell-command "flameshot gui"))

(setq display-buffer-alist `((,shell-command-buffer-name-async . display-buffer-no-window )))
;; display-buffer-alist

(straight-use-package 'haki-theme)
(require 'haki-theme)
(load-theme 'haki)

(define-key global-map (kbd "M-C--") 'exwm-layout-shrink-window) 
(define-key global-map (kbd "M-C-_") 'exwm-layout-shrink-window-horizontaly) 


; (find-dailyfile "17-07-2024.org")
(defun brnm-increase-backlight () (interactive) (shell-command "echo $(expr $(cat /sys/class/backlight/amdgpu_bl1/brightness) + 1) | sudo tee /sys/class/backlight/amdgpu_bl1/brightness"))
(defun brnm-decrease-backlight () (interactive) (shell-command "echo $(expr $(cat /sys/class/backlight/amdgpu_bl1/brightness) - 1) | sudo tee /sys/class/backlight/amdgpu_bl1/brightness"))

(define-key global-map (kbd "M--") #'brnm-decrease-backlight)
(define-key global-map (kbd "M-+") #'brnm-increase-backlight)




(defun brnm-get-number (string)
 (if (string-match "\\.$" string)
  (setq string (s-concat string "0")))
 (string-to-number string))
;; (brnm-get-number "2.")
; ;# (find-node "(elisp)Special Properties" "‘face’")
; ;# (find-node "(elisp)Faces")
; ;# (put-text-property 0 10 'face '(:size 2.0))
; ;# (setq ovl (make-overlay 0 10))
; ;# (overlay-put ovl 'face '(:height 2.0))
; ;# (find-efunctiondescr 'search-forward-regexp)
; ;# (find-efunctiondescr 'search-forward-regexp "(search-forward-regexp REGEXP &optional BOUND NOERROR COUNT)")
(defun brnm-ovl-height-set ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (let ((n 1))
      (while (save-excursion (search-forward-regexp "^# +\\([0-9]+\\(\\.\\([0-9]+\\)?\\)?\\) +!.*$" nil t n))
	(setq ovl (make-overlay (match-beginning 0) (match-end 0)))
	(overlay-put ovl 'face
		     `(:height    ,(brnm-get-number (match-string 1))
		       :underline t))
	(setq n (+ n 1))))))

(define-key global-map (kbd "M-o") #'brnm-ovl-height-set)

(straight-use-package 'google-this)
(define-key global-map (kbd "M-G") #'google-this)


(defface hi-orange
  '((t :background "orange"))
  "My custom face with an orange background.")

(defface hi-green
  '((t :background "green"))
  "My custom face with an green background.")

(defface hi-gray
  '((t :background "gray" :foreground "black"))
  "My custom face with an gray background.")

;; para dar highlight em newlines
(defface hi-nline-dark
  '((t :background "firebrick4")) "")
(defface hi-nline-light
  '((t :background "firebrick3")) "")

(straight-use-package 'telega)

;; From: (find-templates-intro "4. Adding meat")
(require 'eev-qrl)     ; (find-eev "eev-qrl.el")

(setq ee-youtubedl-command "yt-dlp -o '%(title)s-%(id)s.%(ext)s'")

; (find-efunctiondescr 'pyvenv-activate)
; (pyvenv-activate "~/.venv/")

(defun brnm-screen-off () (interactive) (shell-command "xrandr --output eDP-1 --off"))
(defun brnm-screen-on  () (interactive) (shell-command "xrandr --output eDP-1 --auto"))
(define-key global-map (kbd "s-s") #'brnm-screen-off)
(define-key global-map (kbd "s-S") #'brnm-screen-on)

;; <eewrap-arch-package>
;; Skel: (find-eewrap-links "W" "arch-package" "query link")
;; Test: (find-eewraptest-links "arch-package" "query link")
(defun  eewrap-arch-package () (interactive)
  (ee-this-line-wrapn 2 'ee-wrap-arch-package))
(defun ee-wrap-arch-package (query link)
  "An internal function used by `eewrap-arch-package'."
  (ee-template0 "\
{(ee-HS `(find-arch-package-links ,query ,link))}"))
(define-key eev-mode-map "\M-W" 'eewrap-arch-package)

;; (find-angg-es-links)
;; The `progn' below defines versions of `find-angg',
;; `find-anggfile' and `find-es' that use `find-wget' to access
;; the public copies of my files at anggtwu.net:
;;
(progn

  (defun find-angg (fname &rest rest)
    (apply 'find-wgeta (format "http://anggtwu.net/%s" fname) rest))
  (defun find-anggfile (fname &rest rest)
    (apply 'find-wget  (format "http://anggtwu.net/%s" fname) rest))
  (defun find-es (fname &rest rest)
    (apply 'find-wgeta (format "http://anggtwu.net/e/%s.e" fname) rest))

)

(setq ee-git-dir "~/clones/")

(setq ee-find-youtube-video-program 'find-firefox)

(defun rednerwrap-anchor () (interactive)
       (ee-this-line-wrapn 1 'ee-wrap-anchor)
       (save-excursion
	(evil-normal-state)
	(previous-line)
	(eek "dd")
	(beginning-of-buffer)
	(forward-paragraph)
	(yank)))

; (define-key eev-mode-map "\M-A"     'eewrap-anchor)
(define-key eev-mode-map "\M-A" 'rednerwrap-anchor)

; «.pavucontrol-key»	(to "pavucontrol-key")
; (find-daily "11-10-2024.org" ".pavucontrol-key")
(define-key global-map (kbd "s-P") (lambda () (interactive) (start-process "pavucontrol" nil "pavucontrol")))

; «.rstdoc-react»	(to "rstdoc-react")
;; Skel: (find-rstdoc-links :react)
(defvar ee-rstdoc-:react
      '(:base      "index"
        :base-web  "https://react.dev/"
        :base-html "file:///usr/share/doc/python3.11-doc/html/"
        :base-rst  "/home/redner/clones/react.dev-main/react.dev-main/src/content/"
        :rst       ".md"
	:res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://react.dev/"
		    "^/home/redner/clones/react.dev-main/react.dev-main/src/content/"
		    "^~/clones/react.dev-main/react.dev-main/src/content/")
        :kill      rdk
	:htm       ""
	)
      "See: (find-code-rstdoc :react)")

(defalias 'ee-rstdoc-browse-url 'find-firefox)
; (defalias 'ee-rstdoc-browse-url 'find-googlechrome)

;; (find-code-rstdoc :react)
        (code-rstdoc :react)
(setq ee-googlechrome-program "chromium")

(defun eejump-201 () (find-file "~/todo.e"))




; «.daily-search»	(to "daily-search")
(defun  eewrap-daily-search () (interactive)
  (ee-this-line-wrapn 1 'ee-wrap-daily-search))
(defun ee-wrap-daily-search (query)
  "An internal function used by `eewrap-daily-search'."
  (ee-template0 "\
{(ee-HS `(find-dailysearch ,query))}"))
(define-key eev-mode-map (kbd "s-d") 'eewrap-daily-search)


; «.official-org-abandon»	(to "official-org-abandon")
(add-to-list 'auto-mode-alist '("\\.org\\'". emacs-lisp-mode))



; «.rst-doc-prep»	(to "rst-doc-prep")
(ee-rstdoc-default-defuns)


;; «.ee-rstdoc-:gunicorn»	(to "ee-rstdoc-:gunicorn")
; (find-daily "04-11-2024.org" ".gunicorn-docs")
; # (find-git-links "https://github.com/benoitc/gunicorn" "gunicorn")
; # (code-c-d "gunicorn" "~/clones/gunicorn/")
; # (find-gunicornfile "")
;  (eepitch-vterm)
; cd ~/clones/gunicorn/docs/
; make html
; # As páginas HTML estão em build/html.
;; Skel: (find-rstdoc-links :gunicorn)
(setq ee-rstdoc-:gunicorn
      '(:base      "index"
        :base-web  "https://docs.gunicorn.org/en/stable/"
        :base-html "file:///home/redner/clones/gunicorn/docs/build/html/"
        :base-rst  "/home/redner/clones/gunicorn/docs/source/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://docs.gunicorn.org/en/stable/"
                    "^/home/redner/clones/gunicorn/docs/build/html/"
                    "^/home/redner/clones/gunicorn/docs/source/")
        :kill      gunik
	))

;; (find-code-rstdoc :gunicorn)
        (code-rstdoc :gunicorn)




;; «.ee-rstdoc-:flask»	(to "ee-rstdoc-:flask")
; (find-daily "04-11-2024.org" ".flask-docs")
; (find-daily "03-11-2024.org" ".rst-doc-flask")
; (code-c-d "flask" "~/clones/flask/")
; ; (find-flaskfile "")
;  (eepitch-vterm)
; cd ~/clones/flask/docs
; make 
; make html
; # As páginas HTML estão em _build/html.
; ; (find-flaskfile "docs/_build/html")
; 
; pacman -Ss sphinx
; sudo pacman -Sy python-sphinx
; pacman -Ss sphinx | grep themes
; sudo pacman -Sy python-pallets-sphinx-themes
; pacman -Ss flask
; sudo pacman -Sy python-flask
; pacman -Ss sphinx | grep contrib
; sudo pacman -Sy python-sphinxcontrib-log-cabinet
; pacman -Ss sphinx | grep tabs
; sudo pacman -Sy python-sphinx-tabs
; 
; (find-rstdoc-intro "7. `find-rstdoc-links'")
; (find-rstdoc-intro "3. `code-rstdoc'")
;; Skel: (find-rstdoc-links :flask)
(setq ee-rstdoc-:flask
      '(:base      "index"
        :base-web  "https://flask.palletsprojects.com/en/stable/"
        :base-html "file:///home/redner/clones/flask/docs/_build/html/"
        :base-rst  "~/clones/flask/docs/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://flask.palletsprojects.com/en/stable/"
                    "^/home/redner/clones/flask/docs/_build/html/"
                    "^/home/redner/clones/flask/docs/")
        :kill      flaskk
	))

;; (find-code-rstdoc :flask)
        (code-rstdoc :flask)

; «.my-eewrap-eepitch»	(to "my-eewrap-eepitch")
; (find-efunction 'eewrap-eepitch)
(defun my-eewrap-eepitch () (interactive)
  "Convert the current into an eepitch block (three lines long)."
  (let* ((fmt   " (eepitch-%s)")
	 (li    (ee-this-line-extract))
	 (newli (format fmt li li)))
    (insert (ee-adjust-red-stars newli)))
  (ee-next-line 1))
(define-key global-map (kbd "M-T") #'my-eewrap-eepitch)
(define-key eev-mode-map (kbd "M-T") #'my-eewrap-eepitch)




;; «.ee-rstdoc-:flasklogin»	(to "ee-rstdoc-:flasklogin")
;; (find-daily "16-11-2024.org" ".flask-login-docs-rst")
;; Skel: (find-rstdoc-links :flasklogin)
(setq ee-rstdoc-:flasklogin
      '(:base      "index"
        :base-web  "https://flask-login.readthedocs.io/en/latest/"
        :base-html "file:///home/redner/clones/flask-login/docs/build/html/"
        :base-rst  "/home/redner/clones/flask-login/docs/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://flask-login.readthedocs.io/en/latest/"
                    "^home/redner/clones/flask-login/docs/build/html/"
                    "^/home/redner/clones/flask-login/docs/")
        :kill      flogk
	))

;; (find-code-rstdoc :flasklogin)
        (code-rstdoc :flasklogin)

;; «.ee-rstdoc-:gdal»	(to "ee-rstdoc-:gdal")
;; Skel: (find-rstdoc-links :gdal)
(setq ee-rstdoc-:gdal
      '(:base      "index"
        :base-web  "https://gdal.org/en/latest/"
        :base-html "file:///home/redner/clones/gdal/doc/build/html/"
        :base-rst  "/home/redner/clones/gdal/doc/source/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://gdal.org/en/latest/"
                    "^/home/redner/clones/gdal/doc/build/html/"
                    "^/home/redner/clones/gdal/doc/source/")
        :kill      gdalk
	))

;; (find-code-rstdoc :gdal)
        (code-rstdoc :gdal)

;; «.ee-rstdoc-:rasterio»	(to "ee-rstdoc-:rasterio")
;  (find-daily "02-12-2024.org" ".rasterio-documentation")
;; Skel: (find-rstdoc-links :rasterio)
(setq ee-rstdoc-:rasterio
      '(:base      "index"
        :base-web  "https://rasterio.readthedocs.io/en/stable/"
        :base-html "file:///home/redner/clones/rasterio/docs/_build/html/"
        :base-rst  "/home/redner/clones/rasterio/docs/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://rasterio.readthedocs.io/en/stable/"
                    "^/home/redner/clones/rasterio/docs/_build/html/"
                    "^/home/redner/clones/rasterio/docs/")
        :kill      rastk
	))

;; (find-code-rstdoc :rasterio)
        (code-rstdoc :rasterio)

;; «.ee-rstdoc-:geopandas»	(to "ee-rstdoc-:geopandas")
; (find-daily "06-12-2024.org" ".geopandas-docs")
;; Skel: (find-rstdoc-links :geopandas)
(setq ee-rstdoc-:geopandas
      '(:base      "index"
        :base-web  "https://geopandas.org/en/stable/"
        :base-html "file:///home/redner/clones/geopandas/doc/build/html/"
        :base-rst  "~/clones/geopandas/doc/source/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://geopandas.org/en/stable/"
                    "^/home/redner/clones/geopandas/doc/build/html/"
                    "^~/clones/geopandas/doc/source/")
        :kill      geopk
	))

;; (find-code-rstdoc :geopandas)
        (code-rstdoc :geopandas)


; «.geopandas_api_tofile»	(to "geopandas_api_tofile")
; (find-html2pdf-links "api_tofile" "https://geopandas.org/en/stable/docs/reference/api/geopandas.GeoDataFrame.to_file.html#geopandas.GeoDataFrame.to_file")
(code-pdf-page  "api_tofile" "$S/https/geopandas.org/en/stable/docs/reference/api/geopandas.GeoDataFrame.to_file.html#geopandas.GeoDataFrame.to_file.pdf")
(code-pdf-text8 "api_tofile" "$S/https/geopandas.org/en/stable/docs/reference/api/geopandas.GeoDataFrame.to_file.html#geopandas.GeoDataFrame.to_file.pdf")
; (page-utils-mode 1)
; (find-api_tofiletext 1)

;; «.ee-rstdoc-:pyproj»	(to "ee-rstdoc-:pyproj")
;; (find-daily "07-12-2024.org" ".pyproj-docs")
;; Skel: (find-rstdoc-links :pyproj)
(setq ee-rstdoc-:pyproj
      '(:base      "index"
        :base-web  "https://pyproj4.github.io/pyproj/stable/"
        :base-html "file:///home/redner/clones/pyproj/docs/_build/html/"
        :base-rst  "~/clones/pyproj/docs/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://pyproj4.github.io/pyproj/stable/"
                    "^/home/redner/clones/pyproj/docs/_build/html/"
                    "^~/clones/pyproj/docs/")
        :kill      pyprjk
	))

;; (find-code-rstdoc :pyproj)
        (code-rstdoc :pyproj)

; «.pyproj-api-geod»	(to "pyproj-api-geod")
; (find-html2pdf-links "pyproj-api-geod" "https://pyproj4.github.io/pyproj/stable/api/geod.html#pyproj.Geod")
(code-pdf-page  "pyproj-api-geod" "$S/https/pyproj4.github.io/pyproj/stable/api/geod.html#pyproj.Geod.pdf")
(code-pdf-text8 "pyproj-api-geod" "$S/https/pyproj4.github.io/pyproj/stable/api/geod.html#pyproj.Geod.pdf")
; (page-utils-mode 1)
; (find-pyproj-api-geodtext 1)

;; «.ee-rstdoc-:shapely»	(to "ee-rstdoc-:shapely")
; (find-daily "07-12-2024.org" ".shapely")
;; Skel: (find-rstdoc-links :shapely)
(setq ee-rstdoc-:shapely
      '(:base      "index"
        :base-web  "https://shapely.readthedocs.io/en/stable/"
        :base-html "file:///home/redner/clones/shapely/docs/_build/html/"
        :base-rst  "~/clones/shapely/docs/"
        :rst       ".rst"
        :res       ("#.*$" "\\?.*$" ".html$" ".txt$" ".rst$" "^file://"
                    "^https://shapely.readthedocs.io/en/stable/"
                    "^/home/redner/clones/shapely/docs/_build/html/"
                    "^~/clones/shapely/docs/")
        :kill      shpk
	))

;; (find-code-rstdoc :shapely)
        (code-rstdoc :shapely)


;; «.dudasd-project»	(to "dudasd-project")
;; (find-ddprjfile "")
;; (find-ddprjfile "ddprj.el")
; (load "~/p/h2m/dudasprj/ddprj.el")

; «.api-linestring»	(to "api-linestring")
(code-pdf-page  "api-linestring" "$S/https/shapely.readthedocs.io/en/stable/reference/shapely.LineString.html#shapely.LineString.pdf")
(code-pdf-text8 "api-linestring" "$S/https/shapely.readthedocs.io/en/stable/reference/shapely.LineString.html#shapely.LineString.pdf")
; (page-utils-mode 1)
; (find-api-linestringtext 1)



; «.cria-anchor-direita-texto»	(to "cria-anchor-direita-texto")
; (find-daily "25-12-2024.org" ".cria-anchor-direita-texto")
(defun cria-anchor-direita-texto (texto)
  (interactive "s")
  (save-excursion
    (eek "<<evil-normal-state>> A")
    (insert (s-concat " ; «" texto "» (to \"." texto "\")"))
    (eek "<<evil-normal-state>> gg M-}")
    (insert (s-concat "; «." texto "» (to \"" texto "\")\n"))))

(define-key global-map (kbd "s-a") 'cria-anchor-direita-texto)

; «.h2m-scan»	(to "h2m-scan")
; (load "/home/redner/opencv-test/templates.el")
; (find-fline "/home/redner/opencv-test/templates.el")

; «.pdf-view-enable-midnight-mode»	(to "pdf-view-enable-midnight-mode")
(defun brnm-enable-midnight-mode () (pdf-view-midnight-minor-mode 0))
(add-hook 'pdf-view-mode-hook #'brnm-enable-midnight-mode)
