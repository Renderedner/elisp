;; Ao realizar o parallel commit, deve-se copiar o conteúdo de da pasta meta, sem filtra-la
(find-metafile "parallel-commit.el")


;; Existem alguns arquivos que simplesmente não são filtrados, e são copiados para a outra branch
;; através de uma pasta temporária. Vou me aproveitar deste mecanismo para adicionar a pasta inteira.
(find-metafile "parallel-commit.el" "defun mc-parallel-commit-1")
(find-metafile "parallel-commit.el" "defun mc-parallel-commit-1" "(_mc-copy-not-filtered-files-from-meta-to-temp")
(find-metafile "parallel-commit.el" "defun _mc-copy-not-filtered-files-from-meta-to-temp")

;; Esta função é utilizada para filtrar arquivos que não tem a extensão de arquivos filtráveis.
(find-metafile "parallel-commit.el" "defun _mc-filter-list-of-files-by-file-extension")
(find-metafile "parallel-commit.el" "defun mc-parallel-commit-1" "(_mc-filter-list-of-files-by-file-extension")
;; Primeiro passo é impedir o programa de copiar os arquivos filtrando.
(find-metafile "parallel-commit.el" "defun mc-filter-out-meta-folder")
(find-metafile "parallel-commit.el" "defun mc-parallel-commit-1" "(mc-filter-out-meta-folder")

(find-metafile "parallel-commit.el" "defun mc-parallel-commit-1" "_mc-copy-not-filtered-files-from-temp-to-original")
(find-metafile "parallel-commit.el" "(mc-copy-meta-folder-to-temp-folder)")
;; Copiou apenas alguns arquivos.

 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
cd ~/p/chronos-crm/
cgs
git restore README.md flaskr/run_server.sh
rm -r meta/ package-lock.json package.json
git checkout meta
 (find-wset "13o_2o_o2o_ooo" '(find-file "~/p/chronos-crm/meta/") '(find-file (concat _mc-directory-for-copying-not-filtered-files "meta/")) '(find-ebuffer "*Shell Command Output*"))
 (let ((default-directory "~/p/chronos-crm/")) (mc-copy-meta-folder-to-temp-folder))

 (let ((default-directory "~/p/chronos-crm/")) (mc-parallel-commit-1))
 (find-file _mc-directory-for-copying-not-filtered-files)
 (find-file "~/p/chronos-crm/meta/")


