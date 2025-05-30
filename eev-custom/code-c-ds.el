; (find-dailycaps "10-01-2024.org" "isto aqui seria um anchor")
(defun ee-code-c-d-:caps (c d &rest rest)
  (concat (ee-template0 "
    (defun find-{c}caps (str &rest pos-spec-list)
    (interactive (list \"\"))
    (apply 'find-fline (ee-{c}file str) (cons (upcase (car pos-spec-list)) (cdr pos-spec-list))))
") (ee-code-c-d-rest c d rest)))
; «chronos»  (to ".chronos")

(defun ee-code-c-d-:defun (c d &rest rest)
  (concat (ee-template0 "
    (defun find-{c}defun (str &rest pos-spec-list)
    (interactive (list \"\"))
    (apply 'find-fline (ee-{c}file str) (cons (concat \"defun \" (car pos-spec-list)) (cdr pos-spec-list))))
") (ee-code-c-d-rest c d rest)))

(defun ee-code-c-d-:search (c d &rest rest)
  (concat (ee-template0 "
    (defun find-{c}search (str &rest pos-spec-list)
    (interactive (list \"\"))
     (apply 'ee-find-grep ee-{c}dir (concat \"grep --color=auto -nH --null --exclude=\\\"*~\\\" -e \\\"\" str \"\\\" ./*\") pos-spec-list))
") (ee-code-c-d-rest c d rest)))
;; (find-code-c-d "daily" "~/notes/daily/" :caps :anchor :search)
;; (code-c-d "daily" "~/notes/daily/" :caps :anchor :search)
;; (find-dailysearch "ochs")

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



(code-c-d "daily" "~/notes/daily/" :caps :anchor :search :search)
(code-c-d "~" "~/" :caps :anchor :search)
(code-c-d "notes" "~/notes/" :caps :anchor :search)


(code-c-d "p" "~/p/" :anchor :search)
(code-c-d "tccsuci" "~/p/ic/src/split_loso_uci_har/" :caps :anchor :search)

(code-c-d "tcc" "~/p/ic/" :caps :anchor :search)
(code-c-d "tccs" "~/p/ic/src/" :caps :anchor :search)
(code-c-d "tccdalstm" "~/p/ic/src/lstm_time_warping/" :caps :anchor :search)

(code-c-d "pdfc" "~/p/pdf-contabilidade/" :caps :anchor :search)
(code-c-d "glsl" "~/p/glsl/" :caps :anchor :search)

(code-c-d "crm" "~/p/chronos-crm/" :caps :anchor :search)
(code-c-d "crmfs" "~/p/chronos-crm/chronos-front/src/" :caps :anchor :search)
(code-c-d "crmfsc" "~/p/chronos-crm/chronos-front/src/components/" :caps :anchor :search)
(code-c-d "crmb" "~/p/chronos-crm/flaskr/" :caps :anchor :search)

(code-c-d "soil" "~/p/odecamsoil/" :caps :anchor :search)
(code-c-d "soilc" "~/p/odecamsoil/src/components/" :caps :anchor :search)
(code-c-d "0soilc" "~/p/odecamsoil/src/components/" :caps :anchor :search)


(code-c-d "meta" "~/p/meta/" :caps :defun :anchor :search)
(code-c-d "eevc" "~/.config/emacs/eev-custom/" :caps :anchor :search)
; (find-code-c-d "eevc" "~/.config/emacs/eev-custom/" :caps :anchor :search)
(code-c-d "config" "~/.config/emacs/" :caps :anchor :search)

(code-c-d "eev" "~/clones/eev/" :anchor :search)
(code-c-d "cncrs" "~/p/concursos/" :anchor :search)

(code-c-d "emxgpt" "/home/odecam/clones/gpt.el/" :anchor :search)
(code-c-d "tccnp" "~/p/ic/src/new_paradigm/" :anchor :caps :search)
;; (find-tccnpfile "" :search)

(code-c-d "h2m"   "~/p/h2m/" :caps :anchor :search)
(code-c-d "h2mas" "~/p/h2m/albertos_sheet/" :anchor :search)
(code-c-d "h2masd" "~/p/h2m/albertos_sheet/data/" :anchor :search)
(code-c-d "arcgebsdkr" "~/clones/arcgis-experience-builder-sdk-resources/" :search)
(code-c-d "ebaddlayers" "~/clones/arcgis-experience-builder-sdk-resources/widgets/add-layers/" :search)
;; (find-ebaddlayersfile "" :search)
(code-c-d "ebfeatfunc" "~/clones/arcgis-experience-builder-sdk-resources/widgets/feature-layer-function/" :search)
;; (find-ebfeatfuncfile "" :search)

(code-c-d "poe" "~/poe/" :search)
(code-c-d "poe-doc" ".steam/root/steamapps/compatdata/238960/pfx/drive_c/users/steamuser/My Documents/My Games/Path of Exile/" :search)

(code-c-d "gspreaddataframe" "~/clones/gspread-dataframe/" :search)
;; (find-gspreaddataframefile "" :search)
(code-c-d "gspreadpandas" "~/clones/gspread-pandas/" :search)
;; (find-gspreadpandasfile "" :search)
(code-c-d "gspreadformatting" "~/clones/gspread-formatting/" :search)
;; (find-gspreadformattingfile "" :search)
(code-c-d "h2map" "~/p/h2m/alberto_points/" :search)
;; (find-h2mapfile "" :search)
(code-c-d "gism" "~/gis-meta/" :anchor :search)
;; (find-gismfile "" :search)
(code-c-d "opencvtest" "~/opencv-test/" :anchor :search)
;; (find-opencvtestfile "" :search)
(code-c-d "opencvdocscan" "~/clones/OpenCV-Document-Scanner/" :anchor :search)
;; (find-opencvdocscanfile "" :search)

(code-c-d "OpenCVDocumentScanner" "~/clones/OpenCV-Document-Scanner/" :search)
(code-c-d "data2pdf" "~/p/h2m/data2pdf/" :anchor :search)
(code-c-d "gis-meta" "~/gis-meta/" :anchor :search)
;; (find-gis-metafile "")
(code-c-d "vpspdf" "~/vps-pdf-system/")
;; (find-vpspdffile "")
(code-c-d "reactdevcontent" "~/clones/react.dev-main/react.dev-main/src/content/")
;; (find-reactdevcontentfile "")
(code-c-d "h2map" "~/p/h2m/alberto_points/" :anchor)
;; (find-h2mapfile "")
(code-c-d "chronosbackmaster" "/home/redner/chronos-crm/chronos-crm-master/chronos-crm-master/flaskr/")
;; (find-chronosbackmasterfile "")

; «.chronos»	(to "chronos")
; (find-daily "16-11-2024.org" ".indexing-chronos-crm")
; (find-~file "crm.e")
(code-c-d "crmmaster" "~/chronos-crm/chronos-crm-master/chronos-crm-master/flaskr/" :anchor :search)
(code-c-d "crmmeta"   "~/chronos-crm/chronos-crm-meta/chronos-crm-meta/flaskr/" :anchor)
(code-c-d "ecw" "~/p/h2m/ecw/" :anchor)
;; (find-ecwfile "")
(code-c-d "ddprj" "~/p/h2m/dudasprj/" :anchor)
(code-c-d "ddprjshp" "~/p/h2m/dudasprj/BR-277 - Planalto/BR-277 - Planalto/SHP/" :anchor)
;; (find-ddprjfile "")
;; (find-ddprjshpfile "")
(code-c-d "ddprjp2shp" "~/p/h2m/dudasprj/p2/PR-804/PR-804/SHP/")
;; (find-ddprjp2shpfile "")
(code-c-d "rubi" "~/rubi/" :anchor)
;; (find-rubifile "")
(code-c-d "h2m-lirai" "~/p/h2m/lira-integration/" :anchor)
;; (find-h2m-liraifile "")
(code-c-d "contab" "~/p/contab/")
;; (find-contabfile "")
(code-c-d "lsapi" "~/p/h2m/laudosocialapi/" :anchor)
;; (find-lsapifile "")

(code-c-d "ygtest" "~/yagmail-test/" :anchor)
(code-c-d "pdfs" "~/pdfs/" :anchor )
;; (find-pdfsfile "")
(code-c-d "glndatt" "~/p/h2m/glendasatt/" :anchor)
;; (find-glndattfile "")
(code-c-d "macumba" "~/macumba/" :anchor)
;; (find-macumbafile "")

(code-c-d "vps" "/ssh:redner_vps@justclaymoving.xyz:" :anchor)
(code-c-d "vpsr" "/ssh:root@justclaymoving.xyz:" :anchor)
(code-c-d "lsapir" "/ssh:redner_vps@justclaymoving.xyz|ssh:brnm@localhost#8082:laudosocialapi/" :anchor)
(code-c-d "brnm" "/ssh:redner_vps@justclaymoving.xyz|ssh:brnm@localhost#8082:" :anchor)
(code-c-d "brnms" "/ssh:redner_vps@justclaymoving.xyz|ssh:brnm@localhost#8082|su::" :anchor)
(code-c-d "odecam" "/ssh:redner_vps@justclaymoving.xyz|ssh:odecam@localhost#8089:" :anchor)
(code-c-d "odecams" "/ssh:redner_vps@justclaymoving.xyz|ssh:odecam@localhost#8089|su::" :anchor)
