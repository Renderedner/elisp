;; «.find-crmremote-links»	(to "find-crmremote-links")
;; «.find-glsl-links»	(to "find-glsl-links")
;; «.find-ytdlpmusic-links»	(to "find-ytdlpmusic-links")
;; «.find-0soil-links»	(to "find-0soil-links")
;; «.find-h2mpdfs-links»	(to "find-h2mpdfs-links")
;; «.find-html2pdf-links»	(to "find-html2pdf-links")
;; «.find-pyinspect-links»	(to "find-pyinspect-links")
;; «.find-yttranscript-links»	(to "find-yttranscript-links")
;; «.find-iw-links»	(to "find-iw-links")
;; «.find-princeurl-links»	(to "find-princeurl-links")
;; «find-aur-links»  (to ".find-aur-links")
;; «find-quickpush-links»  (to ".find-quickpush-links")



;; «find-0soil-links»  (to ".find-0soil-links")
;; Skel: (find-find-links-links-new "0soil" "remoteip" "localip")
;; Test: (find-0soil-links)

(defun brnm-get-local-ip ()
  (interactive)
  (save-window-excursion
    (shell-command "ip address")
    (switch-to-buffer shell-command-buffer-name)
    (goto-char (search-forward-regexp "wlan[0-9]"))
    (goto-char (search-forward        "inet "))
    (search-forward-regexp "[0-9]+.[0-9]+.[0-9]+.[0-9]+")
    (match-string 0)))

(defvar 0soil-localpath  nil
  "Holds the path to the project 0soil root folder on local machine")
(defvar 0soil-remotepath nil
  "Holds the path to the project 0soil's root folder on the remote machine")
(setq 0soil-localpath  "p/odecamsoil/")
(setq 0soil-remotepath "~/0soil/")
;;
(defun find-0soil-links (&optional remoteip &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for 0soil."
  (interactive)
  (setq remoteip (or remoteip "{remoteip}"))
  (let* ((localip (brnm-get-local-ip)))
    (apply
     'find-elinks
     `((find-0soil-links ,remoteip ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-0soil-links)
       ""
       ,(ee-template0 "\
 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
cd ~/{0soil-localpath}
npx gatsby develop


 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
sudo systemctl start sshd
ssh brnm@{remoteip}
mkdir -p {0soil-remotepath}
sshfs odecam@{localip}:{0soil-localpath} {0soil-remotepath}
ls {0soil-remotepath}

cd {0soil-remotepath}
npx gatsby develop --host=0.0.0.0
")
       ""
       (find-soilfile "")
       (find-soilfile "src/")
       (find-soilcfile "headerLayout.js")
       (find-soilfile "meta/")
       )
     pos-spec-list)))

;; Functions to test changes in the template of `find-0soil-links'.
;; To use them type `M-x tt' inside the `(defun find-0soil-links ...)'.
;; See: (find-templates-intro "5. Debugging the meat")
;;
;; (defun ee-template-test (&rest args)
;;   (let ((ee-buffer-name "*ee-template-test*"))
;;     (find-2a nil `(find-0soil-links ,@args))))

;; (defun tt0 () (interactive) (eek "C-M-x") (ee-template-test))
;; (defun tt  () (interactive) (eek "C-M-x") (ee-template-test "192.168.1.23"))



;; «find-glsl-links»  (to ".find-glsl-links")
;; Skel: (find-find-links-links-new "glsl" "filename ipaddress" "")
;; Test: (find-glsl-links)
;;
(defun find-glsl-links (&optional filename ipaddress &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for glsl."
  (interactive)
  (setq filename (or filename "{filename}"))
  (setq ipaddress (or ipaddress "{ipaddress}"))
  (apply
   'find-elinks
   `((find-glsl-links ,filename ,ipaddress ,@pos-spec-list)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-glsl-links)
     ""
     (find-glslfile "")
     (find-glslfile ,filename)
     ""
     ,(ee-template0 "\
 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
mkdir -p ~/glsl/
sshfs brnm@{ipaddress}:glsl/ ~/glsl/

ssh brnm@{ipaddress}
export DISPLAY=:0
glslViewer ~/glsl/{filename}
")
     )
   pos-spec-list))

;; «find-ytdlpmusic-links»  (to ".find-ytdlpmusic-links")
;; Skel: (find-find-links-links-new "ytdlpmusic" "link" "")
;; Test: (find-ytdlpmusic-links)
;;
(defun find-ytdlpmusic-links (&optional link &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for ytdlpmusic."
  (interactive "s")
  (setq link (or link "{link}"))
  (apply
   'find-elinks
   `(
     ,(ee-template0 "\
 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
mkdir -p ~/music/
cd ~/music/
source ~/yt-dlp-venv/bin/activate
echo \"{link}\" >> ~/downloaded_music.txt
yt-dlp -f 233 -o \"%(playlist_title)s/%(playlist_autonumber)s-%(title)s.%(ext)s\" {link}
yt-dlp -f 233 -o \"%(title)s.%(ext)s\" {link}
yt-dlp -F {link}
")
     ""
     (find-ytdlpmusic-links ,link ,@pos-spec-list)
     (find-efunction 'find-ytdlpmusic-links)
     ""
     (find-man "yt-dlp")
     (find-man "yt-dlp" "-F, --list-formats")
     (find-man "yt-dlp" "-f, --format FORMAT")
     ""
     (find-man "yt-dlp" "-o, --output [TYPES:]TEMPLATE")
     (find-man "yt-dlp" "- `playlist_autonumber`")
     ""
     (find-file "~/music/")
     (find-file "~/downloaded_music.txt")
     )
   pos-spec-list))
;; <find-spotifydl-links>
;; Skel: (find-find-links-links-new "spotifydl" "link" "")
;; Test: (find-spotifydl-links)
;;
(defun find-spotifydl-links (&optional link &rest pos-spec-list)
  "Visit a temporary buffer containing hyperlinks for spotifydl."
  (interactive "s")
  (setq link (or link "{link}"))
  (apply
   'find-elinks
   `(
     ,(ee-template0 "\
 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)

# https://developer.spotify.com/dashboard
export     SPOTIPY_CLIENT_ID=\"e9538f9cd976485881843187db8abf42\"
export SPOTIPY_CLIENT_SECRET=\"74cbc248c345450ebcf366ee3b6f7044\"

source ~/.venv/bin/activate
cd ~/music
spotify_dl --format_str \"%(playlist_title)s/%(playlist_autonumber)s-%(title)s.%(ext)s\" -l {link}
   "
		    )
     ""
     (find-sh "source ~/.venv/bin/activate; spotify_dl --help") 
     ""
     (find-spotifydl-links ,link ,@pos-spec-list)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-spotifydl-links)
     )
   pos-spec-list))


;; «find-crmremote-links»  (to ".find-crmremote-links")
;; Skel: (find-find-links-links-new "crmremote" "local_ip remote_ip local_path remote_path" "")
;; Test: (find-crmremote-links)
;;
(defun find-crmremote-links (&optional local_ip remote_ip local_path remote_path &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for crmremote."
  (interactive)
  (setq local_ip (or local_ip "{local_ip}"))
  (setq remote_ip (or remote_ip "{remote_ip}"))
  (setq local_path (or local_path "{local_path}"))
  (setq remote_path (or remote_path "{remote_path}"))
  (apply
   'find-elinks
   `((find-crmremote-links ,local_ip ,remote_ip ,local_path ,remote_path ,@pos-spec-list)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-crmremote-links)
     ""
     ,(ee-template0 "\
 (eepitch-vterm)
 (find-wset \"o_o\" '(eek \"C-u -2 s-t\"))
 (eepitch-kill)
 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
sudo systemctl start sshd
ssh brnm@{remote_ip}
mkdir -p {remote_path}
sshfs odecam@{local_ip}:{local_path} {remote_path}
ls {remote_path}

cd {remote_path}flaskr/
source ~/.venv-crm/bin/activate
sudo systemctl start mongodb
./run_server.sh
# (find-file \"~/{local_path}flaskr/run_server.sh\")
 (find-wset \"o_o\" '(eek \"C-u -2 s-t\"))

 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
 (find-wset \"o_2o_o\" '(eek \"C-u 2 s-t\") '(eek \"s-t\"))
ssh brnm@{remote_ip}
cd {remote_path}chronos-front/
npm start


 (eepitch-vterm)
 (eepitch-kill)
 (eepitch-vterm)
ssh brnm@{remote_ip}
python -m venv ~/.venv-crm
sshfs odecam@{local_ip}:{local_path} {remote_path}
source ~/.venv-crm/bin/activate
pip install -r {remote_path}flaskr/requirements.txt
")
     )
   pos-spec-list))


;; Functions to test changes in the template of `find-crmremote-links'.
;; To use them type `M-x tt' inside the `(defun find-crmremote-links ...)'.
;; See: (find-templates-intro "5. Debugging the meat")
;;
(defun ee-template-test (&rest args)
  (let ((ee-buffer-name "*ee-template-test*"))
    (find-2a nil `(find-crmremote-links ,@args))))

(defun tt0 () (interactive) (eek "C-M-x") (ee-template-test))
(defun tt  () (interactive) (eek "C-M-x") (ee-template-test "192.168.1.12" "192.168.1.14" "p/chronos-crm/" "~/chronos-crm/"))




(defun find-runh2m-links (&optional username remote-ip remote-project-path &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for runh2m."
  (interactive)
  (setq username (or username "{username}"))
  (setq remote-ip (or remote-ip "{remote-ip}"))
  (setq remote-project-path (or remote-project-path "{remote-project-path}"))
  (let* (({vars} "{{vars}}"))
    (apply
     'find-elinks
     `((find-runh2m-links ,username ,remote-ip ,remote-project-path ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-runh2m-links)
       ""
       ,(ee-template0 "\
 (eepitch-vterm)
sudo iwctl station wlan0 show
sudo iwctl station wlan0 connect PUNFT
sudo iwctl station wlan0 show

 (eepitch-vterm)
ssh {username}@{remote-ip}
killall chromium
exit
xpra start ssh:{username}@{remote-ip} --exit-with-children --start-child=\"chromium\"
 (eek \"s-o C-u -2 s-t s-o\")
 (eepitch-vterm)
ssh {username}@{remote-ip}
cd {remote-project-path}server/
npm ci
npm start
 (eek \"s-o C-u -3 s-t s-o\")
 (eepitch-vterm)
ssh {username}@{remote-ip}
cd {remote-project-path}client/
npm ci
npm start
 (eek \"s-o C-u -4 s-t s-o\")
 (find-wset \"13o_2o_o2o_ooo\" '(find-ebuffer \"*vterm*<4>\") '(find-ebuffer \"Chromium\") '(find-ebuffer \"*vterm*<3>\"))
 (find-wset \"1_3o_2o_o\"  '(find-ebuffer \"Chromium\") '(find-ebuffer \"*vterm*<3>\") '(find-ebuffer \"*vterm*<4>\"))
 (find-2a nil '(find-ebuffer \"Chromium\"))
")
       )
     pos-spec-list)))


(load "~/p/h2m/data2pdf/templates.el")




;; «find-html2pdf-links»  (to ".find-html2pdf-links")
;; Skel: (find-find-links-links-new "html2pdf" "c url" "path")
;; Test: (find-html2pdf-links)
;;
;; (find-fline "~/notes/daily/16-08-2024.org")
;; This was taken from a suggestion by edrx some time ago.
;;
;; (find-efunction 'ee-url-to-fname0)
(defun find-html2pdf-links (&optional c url &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for html2pdf."
  (interactive)
  (setq c (or c "{c}"))
  (setq url (or url "{url}"))
  (let* ((path (ee-url-to-fname0 url))
	 (ee-hyperlink-prefix "# "))
    (apply
     'find-elinks
     `((find-html2pdf-links ,c ,url ,@pos-spec-list)
       (find-html2pdf-links1 ,c ,url ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-html2pdf-links)
       ""
       ,(ee-template0 "\
{ee-hyperlink-prefix}To save the pdf, do M-e, M-x brg and C-p in:
 (eepitch-shell2)
mkdir -p {path}
cd       {path}
wkhtmltopdf {url} {path}.pdf

{ee-hyperlink-prefix}<{c}>
(code-pdf-page  \"{c}\" \"{path}.pdf\")
(code-pdf-text8 \"{c}\" \"{path}.pdf\")
(page-utils-mode 1)
{ee-hyperlink-prefix}(find-{c}text 1)
")
       )
     pos-spec-list))
  (sh-mode))

(defun find-html2pdf-links1 (&optional c url &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for html2pdf."
  (interactive)
  (setq c (or c "{c}"))
  (setq url (or url "{url}"))
  (let* ((path (ee-url-to-fname0 url))
	 (ee-hyperlink-prefix "# "))
    (apply
     'find-elinks
     `((find-html2pdf-links1 ,c ,url ,@pos-spec-list)
       (find-html2pdf-links  ,c ,url ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-html2pdf-links1)
       ""
       ,(ee-template0 "\
{ee-hyperlink-prefix}To save the pdf, do M-e, M-x brg and C-p in:
 (kill-new \"/tmp/tmp.pdf\")
 (find-firefox \"{url}\")
 (eepitch-shell2)
mkdir -p              {path}
cp       /tmp/tmp.pdf {path}.pdf

{ee-hyperlink-prefix}<{c}>
(code-pdf-page  \"{c}\" \"{path}.pdf\")
(code-pdf-text8 \"{c}\" \"{path}.pdf\")
(page-utils-mode 1)
{ee-hyperlink-prefix}(find-{c}text 1)
")
       )
     pos-spec-list))
  (sh-mode))

;; «find-pyinspect-links»  (to ".find-pyinspect-links")
;; Skel: (find-find-links-links-new "pyinspect" "var" "ee-hyperlink-prefix")
;; Test: (find-pyinspect-links)
;;
(defun find-pyinspect-links (&optional var &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for pyinspect."
  (interactive)
  (setq var (or var "{var}"))
  (let* ((ee-hyperlink-prefix "# "))
    (apply
     'find-elinks
     `((find-pyinspect-links ,var ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-pyinspect-links)
       ""
       ,(ee-template0 "\
from inspect import getmembers, getdoc
from pprint import pprint, pformat
from pathlib import Path

pprint([i for i,_ in getmembers({var})])
print(getdoc({var}))
{var}

dir = Path(\".cachedlinks/\")
if not dir.exists():
    dir.mkdir()

with open(\".cachedlinks/{var}.getmembers\", \"w\") as file:
    file.write(pformat([i for i,_ in getmembers({var})]))

with open(\".cachedlinks/{var}.getdoc\", \"w\") as file:
    file.write(getdoc({var}))

with open(\".cachedlinks/{var}\", \"w\") as file:
    file.write(str({var}))

# (find-fline \"./.cachedlinks/{var}.getdoc\")
# (find-fline \"./.cachedlinks/{var}.getmembers\")
# (find-fline \"./.cachedlinks/{var}\")
")
       )
     pos-spec-list))
  (python-mode))

;; <find-arch-package-links>
;; Skel: (find-find-links-links-new "arch-package" "query link" "")
;; Test: (find-arch-package-links)
;;       (find-arch-package-links "inviduous" "https://aur.archlinux.org/invidious.git")
;;
(defun find-arch-package-links (&optional query link &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for arch-package."
  (interactive)
  (setq query (or query "{query}"))
  (setq link (or link "{link}"))
  (apply
   'find-elinks
   `((find-arch-package-links ,query ,link ,@pos-spec-list)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-arch-package-links)
     ""
     ,(ee-template0 "\
 (eepitch-vterm)
pacman -Ss {query}
# (find-sh \"pacman -Ss {query}\")
sudo pacman -S {query}

sudo pacman -Syu
sudo pacman -S {query}

 (eepitch-vterm)
 (google-this-string nil \"aur {query}\" t)
cd ~/clones/
git clone {link}
cd {query}
makepkg -s
makepkg -i

 (eepitch-vterm)
pacman -Ql {query}
# (find-sh \"pacman -Ql {query}\")
")
     )
   pos-spec-list))

;; «find-yttranscript-links»  (to ".find-yttranscript-links")
;; Skel: (find-find-links-links-new "yttranscript" "c hash" "")
;; Test: (find-yttranscript-links)
;;       (find-yttranscript-links "acmetour" "dP1xVpMPn8M")
;; See:  http://anggtwu.net/find-yttranscript-links.html
;;
(defun find-yttranscript-links (&optional c hash &rest pos-spec-list)
"Display a temporary script that downloads a transcript from youtube."
  (interactive (list nil (ee-youtubedl-hash-around-point)))
  (setq c (or c "{c}"))
  (setq hash (or hash "{hash}"))
  (let ((ee-hyperlink-prefix "# ") 
	(ee-buffer-name (or ee-buffer-name "*find-yttranscript-links*")))
    (apply
     'find-elinks
     `((find-yttranscript-links ,c ,hash ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-yttranscript-links)
       ""
       ,(ee-template0 "\
# (find-pip3-links \"youtube_transcript_api\")
# (find-youtubedl-links nil nil \"{hash}\" nil \"{c}\")

 (let ((default-directory \"~/\")) (eepitch-vterm))
source ~/.ytvenv/bin/activate
python
from youtube_transcript_api import YouTubeTranscriptApi
from math import floor
vid    = \"{hash}\"
f      = \"find-{c}video\"
tr     = YouTubeTranscriptApi.get_transcript(vid)
# tr     = YouTubeTranscriptApi.get_transcript(vid, languages=['pt'])

times  = [i['start'] for i in tr]
times  = [floor(i) for i in times]
times  = ['\"' + str(i // 60) + ':' + str(i%60) + '\"' for i in times]

texts  = [i['text'] for i in tr]
texts  = ['\"' + i + '\"' for i in texts]


import re
texts  = [re.sub(r'\\n', \" \", i) for i in texts]

links  = '\\n'.join(('(' + f + \" \" + time + \" \" + text + \")\" for time, text in zip(times, texts))) 
print(links)

with open(\"transcripts/{c}-{hash}.txt\", \"w\") as file:
    file.write(links)

# (find-fline \"~/transcripts/{c}-{hash}.txt\")
")
       )
     pos-spec-list))
  (python-mode))

;; «find-iw-links»  (to ".find-iw-links")
;; Skel: (find-find-links-links-new "iw" "network-name network-password" "ee-hyperlink-prefix")
;; Test: (find-iw-links "Punft"          "Nina1949")
;; Test: (find-iw-links "VILLA_DA_PRAIA" "Nina1949")
;; Test: (find-iw-links "VILLA_DA_PRAIA" "Celia1999")
;;
(defun find-iw-links (&optional network-name network-password &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for iw."
  (interactive)
  (setq network-name (or network-name "{network-name}"))
  (setq network-password (or network-password "{network-password}"))
  (let* ((ee-hyperlink-prefix "# "))
    (apply
     'find-elinks
     `((find-iw-links ,network-name ,network-password ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-iw-links)
       ""
       ,(ee-template0 "\
 (eepitch-vterm)
sudo iwctl

station list
station wlan0 show
station wlan0 scan
station wlan0 get-networks
station wlan0 connect {network-name}
{network-password}

known-networks {network-name} forget
")
       )
     pos-spec-list)))

;; (find-angg ".emacs.templates" "find-princeurl-links")
;; «find-princeurl-links»  (to ".find-princeurl-links")
;; Skel: (find-find-links-links-new "princeurl" "url outdir" "")
;; Test: (brprinceurl "https://ocaml.org/learn/tutorials/a_first_hour_with_ocaml.html")
;; See: (find-efunction 'ee-find-psne-core)
;;
(code-brurl 'find-princeurl-links
       :remote 'brprinceurl)

;; <find-princeurl-links>
;; Skel: (find-find-links-links-new "princeurl" "url outdir" "")
;; Test: (find-princeurl-links)
;;
(defun find-princeurl-links (&optional url outdir &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for princeurl."
  (interactive)
  (setq url (or url "{url}"))
  (setq outdir (or outdir "{outdir}"))
  (apply
   'find-elinks
   `((find-princeurl-links ,url)
     (brprinceurl ,url)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-princeurl-links)
     ""
     ,(ee-findprinceurl-core url)
     )
   pos-spec-list))

(defun ee-findprinceurl-core (url &optional outdir)
  (let* ((fname0   (ee-url-to-fname0 url))
         (fnamepdf (replace-regexp-in-string ".html$" ".pdf" fname0))
	 (localdir (or outdir (file-name-directory    fnamepdf)))
	 (stempdf  (file-name-nondirectory fnamepdf)))
    (ee-template0 "\
 (eepitch-shell)
 (eepitch-kill)
 (eepitch-shell)
# {url}
# (find-fline \"{localdir}\" \"{stempdf}\")
# (find-pdf-page \"{fnamepdf}\")

cat > /tmp/print.css <<'%%%'
body {<} font-size: 12pt {>}
@page {<} size: A4 {>}
@page {<} @bottom-center {<} content: counter(page); {>} {>}
%%%

# @page {<}
#   @bottom {<}
#     content: counter(page);
#   {>}
# {>}

mkdir -p  {localdir}
cd        {localdir}
prince --media=print \\
       -s /tmp/print.css \\
       -o {fnamepdf}  \\
           {url}
")))

;; «.find-aur-links»	(to "find-aur-links")
;; Skel: (find-find-links-links-new "aur" "package-name" "")
;; Test: (find-aur-links)
;;
(defun find-aur-links (&optional package-name &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for aur."
  (interactive)
  (let ((ee-hyperlink-prefix "# "))
  (setq package-name (or package-name "{package-name}"))
  (apply
   'find-elinks
   `((find-aur-links ,package-name ,@pos-spec-list)
     ;; Convention: the first sexp always regenerates the buffer.
     (find-efunction 'find-aur-links)
     ""
     ,(ee-template0 "\
# (find-firefox \"https://aur.archlinux.org/packages/{package-name}\")
# (find-firefox \"https://aur.archlinux.org/packages?O=0&K={package-name}\")
 (eepitch-vterm)
cd ~/clones/
git clone https://aur.archlinux.org/{package-name}.git
cd {package-name}
makepkg -s
makepkg -i


# (find-firefox \"https://archlinux.org/packages?q={package-name}\")
 (eepitch-vterm)
pacman -Ss {package-name}
sudo pacman -Sy {package-name}
")
     )
   pos-spec-list)
  (sh-mode)))

;; «.find-quickpush-links»	(to "find-quickpush-links")
;; Skel: (find-find-links-links-new "quickpush" "path" "ee-hyperlink-prefix tmst")
;; Test: (find-quickpush-links)
;;
(defun qqpush-notes () (interactive) (find-quickpush-links "~/notes/"))
(defun find-quickpush-links (&optional path &rest pos-spec-list)
"Visit a temporary buffer containing hyperlinks for quickpush."
  (interactive)
  (setq path (or path "{path}"))
  (let* ((ee-hyperlink-prefix "; ")
         (tmst (ts-format "[%d-%m-%Y|%H:%M]" (ts-now)))) ; (find-efunction 'tmst)
    (apply
     'find-elinks
     `((find-quickpush-links ,path ,@pos-spec-list)
       ;; Convention: the first sexp always regenerates the buffer.
       (find-efunction 'find-quickpush-links)
       ""
       ,(ee-template0 "\
 (eepitch-vterm)
cd ~/notes/
git add *
cgs
git commit -m \"{tmst}\"
git push -u origin main
")
       )
     pos-spec-list)))

