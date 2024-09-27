; (find-dailycaps "10-01-2024.org" "isto aqui seria um anchor")
(defun ee-code-c-d-:caps (c d &rest rest)
  (concat (ee-template0 "
    (defun find-{c}caps (str &rest pos-spec-list)
    (interactive (list \"\"))
    (apply 'find-fline (ee-{c}file str) (cons (upcase (car pos-spec-list)) (cdr pos-spec-list))))
") (ee-code-c-d-rest c d rest)))

(defun ee-code-c-d-:defun (c d &rest rest)
  (concat (ee-template0 "
    (defun find-{c}defun (str &rest pos-spec-list)
    (interactive (list \"\"))
    (apply 'find-fline (ee-{c}file str) (cons (concat \"defun \" (car pos-spec-list)) (cdr pos-spec-list))))
") (ee-code-c-d-rest c d rest)))

;; (find-eevfile "eev-code.el" "(defun ee-code-c-d-base (c d)")
(defun ee-code-c-d-base (c d)
  (ee-template0 "\
   ;; {(ee-S `(find-code-c-d ,c ,d ,@rest))} 
   ;; {(ee-S `(ee-code-c-d-base ,c ,d))} 
   ;; See: (find-eev-quick-intro \"9.1. `code-c-d'\")
   ;;      (find-elisp-intro \"5. Variables\")
   ;;      (find-elisp-intro \"5. Variables\" \"setq\")
   ;;      (find-elisp-intro \"6. Defining functions\")
   ;;      (find-elisp-intro \"6. Defining functions\" \"defun\")
   ;;      (find-elisp-intro \"11. Byte-compiled functions\")
   ;;      (eek \"M-h M-f  apply\")
   ;;      (eek \"M-h M-f  interactive\")
   ;;
   (setq ee-{c}dir \"{d}\")
   (defun ee-{c}file (str)
     (concat (ee-expand ee-{c}dir) str))
   (defun find-{c}file (str &rest pos-spec-list)
     (interactive \"s\") ;; Modifiquei essa linha para conseguir acessar arquivo iterativamente
     (apply 'find-fline (ee-{c}file str) pos-spec-list))
   (defun find-{c}sh (command &rest pos-spec-list)
     (apply 'find-sh-at-dir ee-{c}dir command pos-spec-list))
   (defun find-{c}sh0 (command)
     (funcall 'ee-find-xxxsh0 ee-{c}dir command))
   (defun find-{c}sh00 (command)
     (funcall 'ee-find-xxxsh00 ee-{c}dir command))
   (defun find-{c}grep (grep-command-args &rest pos-spec-list)
     (apply 'ee-find-grep ee-{c}dir grep-command-args pos-spec-list))
     "))



(code-c-d "~" "~/" :caps :anchor)
(code-c-d "notes" "~/notes/" :caps :anchor)
(code-c-d "daily" "~/notes/daily/" :caps :anchor)


(code-c-d "p" "~/p/" :anchor)
(code-c-d "tccsuci" "~/p/ic/src/split_loso_uci_har/" :caps :anchor)

(code-c-d "tcc" "~/p/ic/" :caps :anchor)
(code-c-d "tccs" "~/p/ic/src/" :caps :anchor)
(code-c-d "tccdalstm" "~/p/ic/src/lstm_time_warping/" :caps :anchor)

(code-c-d "pdfc" "~/p/pdf-contabilidade/" :caps :anchor)
(code-c-d "glsl" "~/p/glsl/" :caps :anchor)

(code-c-d "crm" "~/p/chronos-crm/" :caps :anchor)
(code-c-d "crmfs" "~/p/chronos-crm/chronos-front/src/" :caps :anchor)
(code-c-d "crmfsc" "~/p/chronos-crm/chronos-front/src/components/" :caps :anchor)
(code-c-d "crmb" "~/p/chronos-crm/flaskr/" :caps :anchor)

(code-c-d "soil" "~/p/odecamsoil/" :caps :anchor)
(code-c-d "soilc" "~/p/odecamsoil/src/components/" :caps :anchor)
(code-c-d "0soilc" "~/p/odecamsoil/src/components/" :caps :anchor)


(code-c-d "meta" "~/p/meta/" :caps :defun :anchor)
(code-c-d "eevc" "~/.config/emacs/eev-custom/" :caps :anchor)
(code-c-d "config" "~/.config/emacs/" :caps :anchor)

(code-c-d "eev" "~/clones/eev/" :anchor)
(code-c-d "cncrs" "~/p/concursos/" :anchor)

(code-c-d "emxgpt" "/home/odecam/clones/gpt.el/" :anchor)
(code-c-d "tccnp" "~/p/ic/src/new_paradigm/" :anchor :caps)
;; (find-tccnpfile "")

(code-c-d "h2m"   "~/p/h2m/" :caps :anchor)
(code-c-d "h2mas" "~/p/h2m/albertos_sheet/" :anchor)
(code-c-d "h2masd" "~/p/h2m/albertos_sheet/data/" :anchor)
(code-c-d "arcgebsdkr" "~/clones/arcgis-experience-builder-sdk-resources/")
(code-c-d "ebaddlayers" "~/clones/arcgis-experience-builder-sdk-resources/widgets/add-layers/")
;; (find-ebaddlayersfile "")
(code-c-d "ebfeatfunc" "~/clones/arcgis-experience-builder-sdk-resources/widgets/feature-layer-function/")
;; (find-ebfeatfuncfile "")

(code-c-d "poe" "~/poe/")
(code-c-d "poe-doc" ".steam/root/steamapps/compatdata/238960/pfx/drive_c/users/steamuser/My Documents/My Games/Path of Exile/")

(code-c-d "gspreaddataframe" "~/clones/gspread-dataframe/")
;; (find-gspreaddataframefile "")
(code-c-d "gspreadpandas" "~/clones/gspread-pandas/")
;; (find-gspreadpandasfile "")
(code-c-d "gspreadformatting" "~/clones/gspread-formatting/")
;; (find-gspreadformattingfile "")
(code-c-d "h2map" "~/p/h2m/alberto_points/")
;; (find-h2mapfile "")
(code-c-d "gism" "~/gis-meta/" :anchor)
;; (find-gismfile "")
