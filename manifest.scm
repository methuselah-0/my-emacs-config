;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (guix transformations))

(define transform2
  (options->transformation
    '((with-source . "guile-bash=https://git.sr.ht/~methuselah-0/guile-bash"))))

(define transform1
  (options->transformation
    '((with-latest . "emacs-org-contrib"))))

(packages->manifest
  (list (specification->package "esbuild")
        (specification->package "python-mypy")
        (specification->package "python-flake8")
        (specification->package
          "emacs-flycheck-pycheckers")
        (specification->package "emacs-company")
        (specification->package "emacs-js2-mode")
        (specification->package "emacs-js2-refactor-el")
        (specification->package "python-wrapper")
        (specification->package "emacs-posframe")
        (specification->package "emacs-browse-at-remote")
        (specification->package "emacs-test-simple")
        (specification->package
          "emacs-magit-org-todos-el")
        (specification->package "emacs-magit-todos")
        (specification->package "emacs-magit")
        (specification->package "emacs-frame-local")
        (specification->package "emacs-all-the-icons")
        (specification->package "emacs-treemacs-extra")
        (specification->package "emacs-treemacs")
        (specification->package "emacs-doom-themes")
        (transform1
          (specification->package "emacs-org-contrib"))
        (specification->package "emacs-eldoc")
        (specification->package "emacs-slime")
        (specification->package "emacs-jupyter")
        (specification->package "emacs-auto-complete")
        (specification->package "emacs-ac-geiser")
        (specification->package "python-epc")
        (specification->package "jami-gnome")
        (specification->package
          "python-nbdev-org-babel-master")
        (specification->package
          "python-nbdev-org-babel-4f195e9")
        (specification->package "jupyter-next")
        (specification->package "python-nbdev-org-babel")
        (specification->package "python-pylint")
        (specification->package "gajim")
        (specification->package "python-ipython")
        (specification->package "gnome-tweaks")
        (specification->package "python-jedi")
        (specification->package "yad")
        (specification->package "lsof")
        (specification->package "vlc")
        (specification->package "curl")
        (specification->package "guile-curl")
        (specification->package "icecat")
        (specification->package "hdparm")
        (specification->package "xf86-input-synaptics")
        (specification->package "pcre2")
        (specification->package "ffmpeg")
        (specification->package "node")
        (specification->package "automake")
        (specification->package "rsync")
        (specification->package "virt-viewer")
        (specification->package "linux-pam")
        (transform2
          (specification->package "guile-bash"))
        (specification->package "zile")
        (specification->package "jami")
        (specification->package "pv")
        (specification->package "haveged")
        (specification->package "guile-zlib")
        (specification->package "python-yq")
        (specification->package "expect")
        (specification->package "bats")
        (specification->package "orgmk")
        (specification->package "bash-ctypes")
        (specification->package "python-lxml")
        (specification->package "jq")
        (specification->package "php")
        (specification->package "socat")
        (list (specification->package "bind") "utils")
        (specification->package "inkscape")
        (specification->package "mps-youtube")
        (specification->package "youtube-dl")
        (specification->package "python-pytest")
        (specification->package "python-trepan3k")
        (specification->package "python-virtualenv")
        (specification->package
          "python-flask-sqlalchemy")
        (specification->package "python-mysqlclient")
        (specification->package "mesa")
        (specification->package "mesa-utils")
        (specification->package "libnotify")
        (specification->package "python-bash-kernel")
        (specification->package "python-netaddr")
        (specification->package "python-pydotplus")
        (specification->package "python-pycrypto")
        (specification->package "guile")
        (specification->package "libxml2-xpath0")
        (specification->package "fontconfig")
        (specification->package "prips")
        (specification->package "quaternion")
        (specification->package "emacs-guix")
        (specification->package "emacs-lispy")
        (specification->package "emacs-org-caldav")
        (specification->package "emacs-ox-pandoc")
        (specification->package "emacs-ag")
        (specification->package "emacs-flycheck")
        (specification->package "emacs-geiser")
        (specification->package "emacs-org")
        (specification->package "emacs-org-bullets")
        (specification->package "emacs-org-tree-slide")
        (specification->package "emacs-php-mode")
        (specification->package "moreutils")
        (specification->package "passwordsafe")
        (specification->package "glibc")
        (specification->package "cups")
        (specification->package "vsftpd")
        (specification->package "nextcloud-client")
        (specification->package "filezilla")
        (specification->package "nginx")
        (specification->package "gunicorn")
        (specification->package "galera")
        (specification->package "cmake")
        (specification->package "mariadb")
        (specification->package "xeyes")
        (specification->package "audit")
        (specification->package "unzip")
        (specification->package "scrot")
        (specification->package "pulseaudio")
        (specification->package "dconf-editor")
        (specification->package "arandr")
        (specification->package "libreoffice")
        (specification->package "pavucontrol")
        (specification->package "mpd")
        (specification->package "mpv")
        (specification->package "mupdf")
        (specification->package "ncmpcpp")
        (specification->package "weechat")
        (specification->package "xsensors")
        (specification->package "xf86-video-qxl")
        (specification->package "gnupg")
        (specification->package "pinentry")
        (specification->package "pinentry-qt")
        (specification->package "pinentry-tty")
        (specification->package "nyxt")
        (specification->package "ungoogled-chromium")
        (specification->package "alpine")
        (specification->package "alsa-plugins")
        (specification->package "xrandr")
        (specification->package "icedtea")
        (specification->package "bind")
        (specification->package "nmap")
        (specification->package "openssh")
        (specification->package "openvpn")
        (specification->package "wget")
        (specification->package "wpa-supplicant")
        (specification->package "xrdb")
        (specification->package "rxvt-unicode")
        (specification->package "terminology")
        (specification->package "setxkbmap")
        (specification->package "fbcat")
        (specification->package "fbida")
        (specification->package "feh")
        (specification->package "lynx")
        (specification->package "vis")
        (specification->package "recutils")
        (specification->package "xclip")
        (specification->package "xdotool")
        (specification->package "xdg-utils")
        (specification->package "git")
        (specification->package "libhandy")
        (specification->package "texlive")
        (specification->package "js-mathjax")
        (specification->package "imagemagick")
        (specification->package "graphviz")
        (specification->package "emacs")
        (specification->package "perl-pango")
        (specification->package "perl-devel-repl")
        (specification->package "espeak-ng")
        (specification->package "espeak")
        (specification->package "emacs-emms")
        (specification->package "emacs-pdf-tools")
        (specification->package "emacs-w3m")
        (specification->package "emacs-wget")
        (specification->package "font-abattis-cantarell")
        (specification->package "gdb")
        (specification->package "guix-jupyter")
        (specification->package "nss")
        (specification->package "fuse")
        (specification->package "grep")
        (specification->package "guile-dsv")
        (specification->package "openssl")
        (specification->package "quassel")
        (specification->package "p7zip")
        (specification->package "cryptsetup")
        (specification->package "bc")
        (specification->package "guile2.2-sjson")
        (specification->package "iperf")
        (specification->package "ncftp")
        (specification->package "hello")
        (specification->package "autobuild")
        (specification->package "autoconf")
        (specification->package "binutils")
        (specification->package "gcc-toolchain")
        (specification->package "m4")
        (specification->package "make")
        (specification->package "pkg-config")
        (specification->package "elfutils")
        (specification->package "beep")
        (specification->package "cpulimit")
        (specification->package "cowsay")
        (specification->package "cpio")
        (specification->package "iptables")
        (specification->package "htop")
        (specification->package "ccrypt")
        (specification->package "zip")
        (specification->package "strace")
        (specification->package "ipcalc")
        (specification->package "mpd-mpc")
        (specification->package "xf86-video-fbdev")
        (specification->package "nss-certs")
        (specification->package "glibc-locales")
        (specification->package "mcron")
        (specification->package "file")
        (specification->package "flac")
        (specification->package "alsa-lib")
        (specification->package "alsa-utils")
        (specification->package "haunt")
        (specification->package "dnsmasq")
        (specification->package "bridge-utils")
        (specification->package "aircrack-ng")
        (specification->package "netcat")
        (specification->package "net-tools")
        (specification->package "screen")
        (specification->package "xmodmap")
        (specification->package "coreutils")
        (specification->package "bash-completion")
        (specification->package "dvtm")
        (specification->package "abduco")
        (specification->package "gash")
        (specification->package "unclutter")
        (specification->package "shellcheck")
        (specification->package "xmlstarlet")
        (specification->package "pcre")
        (specification->package "texinfo")
        (specification->package "texlive-latex-preview")
        (specification->package "perl")
        (specification->package "perl-data")
        (specification->package
          "perl-datetime-format-ical")
        (specification->package "perl-data-ical")
        (specification->package "pandoc")
        (specification->package "emacs-bash-completion")
        (specification->package "emacs-nginx-mode")
        (specification->package
          "emacs-rainbow-delimiters")
        (specification->package "emacs-realgud")
        (specification->package "emacs-rudel")
        (specification->package "emacs-scheme-complete")
        (specification->package "emacs-tramp")
        (specification->package "emacs-xmlgen")
        (specification->package "xlsfonts")
        (specification->package "font-ghostscript")
        (specification->package
          "font-adobe-source-code-pro")
        (specification->package "font-anonymous-pro")
        (specification->package "font-awesome")
        (specification->package "font-bitstream-vera")
        (specification->package "font-dejavu")
        (specification->package "font-fantasque-sans")
        (specification->package "font-fira-mono")
        (specification->package "font-gnu-freefont")
        (specification->package "font-gnu-unifont")
        (specification->package "font-go")
        (specification->package
          "font-google-material-design-icons")
        (specification->package "font-google-noto")
        (specification->package "font-google-roboto")
        (specification->package "font-hack")
        (specification->package "font-inconsolata")
        (specification->package "font-liberation")
        (specification->package "font-linuxlibertine")
        (specification->package "font-mathjax")
        (specification->package "font-rachana")
        (specification->package "font-tamzen")
        (specification->package "font-terminus")
        (specification->package "font-tex-gyre")
        (specification->package "font-un")
        (specification->package "xautolock")
        (specification->package "guildhall")
        (specification->package
          "guile2.2-syntax-highlight")
        (specification->package "guile-config")
        (specification->package "guile-pfds")
        (specification->package "guile-sjson")
        (specification->package "fwknop-client")
        (specification->package "python-vobject")
        (specification->package "python-dateutil")
        (specification->package "bash-bcu")
        (specification->package "pydaemon")
        (specification->package "tree")
        (list (specification->package "pcre") "bin")
        (specification->package "guile-bootstrap")))