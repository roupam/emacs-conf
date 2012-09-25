;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.

;;(set-default-font "M+_1m-14")
;;(set-default-font "Anonymous-14")
;;(set-default-font "Terminus-18")
(set-default-font "Inconsolata-16")
;;(set-default-font "Continuum_Light-18")
;;(set-default-font "Share-TechMono-16")
;;(set-default-font "BloomingGrove-15")
;;(set-default-font "Roboto-16")

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; From nflath.com
;;; add all subdirs under "~/.emacs.d/" to load-path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
           (default-directory my-lisp-dir)
           (orig-load-path load-path))
      (setq load-path (cons my-lisp-dir nil))
      (normal-top-level-add-subdirs-to-load-path)
      (nconc load-path orig-load-path)))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Load up ELPA, the package manager

(add-to-list 'load-path dotfiles-dir)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)
(require 'starter-kit-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)

(regen-autoloads)
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))
(if (file-exists-p user-specific-config) (load user-specific-config))

;; My Cutomizations

;; ---- Load exec-path ----
(setq exec-path (append exec-path '("/usr/bin")))
(setq exec-path (append exec-path '("/bin")))
(setq exec-path (append exec-path '("/usr/sbin")))
(setq exec-path (append exec-path '("/sbin")))
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("/usr/X11/bin")))
(setq exec-path (append exec-path '("/Users/rpg/bin")))
;; (setq exec-path (append exec-path '("/sw/bin/")))
;; (setq exec-path (append exec-path '("/Users/rpg/android-sdk/tools/")))
;; (setq exec-path (append exec-path '("/Users/rpg/android-sdk/platform-tools/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/jed/0.99-19/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/tree/1.6.0/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/cmatrix/1.2a/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/blahtexml/0.8/bin/")))
;; (setq exec-path (append exec-path '("/usr/texbin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/uemacs/HEAD/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/emacs/23.3a/bin/")))
;; (setq exec-path (append exec-path '("/Users/rpg/project/golang/go/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/fortune/9708/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/ncdu/1.7/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/rtmpdump/2.3/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/ircii/20110228/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/maxima/5.25.1/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/tsung/1.4.1/bin/")))
;; (setq exec-path (append exec-path '("/Applications/calibre.app/Contents/MacOS")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/git-flow/0.4.1/bin/")))
;; (setq exec-path (append exec-path '("/Users/rpg/.rvm/bin")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/git-flow/0.4.1/bin")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/herrie/2.2/bin")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/links/2.2/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/nasm/2.09.10/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/tiger-vnc/1.0.1/bin/")))
;; (setq exec-path (append exec-path '("/usr/local/Cellar/dict/1.9.15/bin/")))

(load-library "color-theme-actress")
;; (load-library "color-theme-cobalt")
(load-library "color-theme-complexity")
;; (load-library "color-theme-dawn-night")
;; (load-library "color-theme-eclipse")
;; (load-library "color-theme-github")
;; (load-library "color-theme-gruber-darker")
;; (load-library "color-theme-ir-black")
;; (load-library "color-theme-tangotango")
(color-theme-complexity)
;;(load-library "mc-theme3")
;;(mc-theme3)

;; (load-library "mc-theme")
;; (mc-theme)

;; ----------- linum mode ----------
(require 'linum)
(global-linum-mode)
(setq linum-format
      (lambda (line)
    (propertize
     (format
      (let
      ((w (length (number-to-string (count-lines (point-min)
                             (point-max))))))
      (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; ---------------------------------


;;(hl-line-mode)
;;(set-face-background hl-line-face "LightGrey")

(require 'auto-complete-config)
(ac-config-default)

(autoload 'whizzytex-mode
  "~/elisp/whizzytex"
  "WhizzyTeX, a minor-mode WYSIWYG environment for LaTeX" t)
(setq-default whizzy-viewers '(("-dvi" "xdvi") ("-ps" gv) ("-pdf" "xpdf")))

;;(load-library "color-theme-solarized")
;;(color-theme-solarized-dark)

(load-library "android-mode")
(require 'android-mode)
(setq android-mode-sdk-dir "~/android-sdk/")
(add-hook 'gud-mode-hook
          (lambda ()
            (add-to-list 'gud-jdb-classpath "~/android-sdk/platforms/android-7/android.jar")))


;; My Setup for GNUS+GMAIL

;; (eval-after-load "mail-source" '(require 'pop3))
;; (setq smtpmail-debug-info t)
;; (setq pop3-debug t)
;; (setq gnus-secondary-select-methods '((nnml "")))
;; (setq user-full-name "Roupam Ghosh")
;; (setq user-full-mail-address "rpg@infinitelybeta.com")
;; (setq mail-sources
;;       '(;
;;         (pop :server "pop.gmail.com"
;;              :port 995
;;              :user "rpg@helpshift.com"
;;              :connection ssl
;;              :password "********"
;;              :leave t)))
;; ;; Sending mail
;; (setq message-send-mail-function 'smtpmail-send-it)
;; (setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
;; (setq smtpmail-auth-credentials '(("smtp.gmail.com" 587 "rpg@helpshift.com"
;;                                    nil)))
;; (setq smtpmail-default-smtp-server "smtp.gmail.com")
;; (setq smtpmail-smtp-server "smtp.gmail.com")
;; (setq smtpmail-smtp-service 587)

;; ;; My Setup for Mew + GMAIL
;; (add-to-list 'load-path "~/.emacs.d/mew/")
;; (require 'mew)


;; My setup for android auto-complete

;; ;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.6.1")
(require 'yasnippet)
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
(yas/initialize)
;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas/root-directory '("~/.emacs.d/elpa/yasnippet-0.6.1/snippets"))
;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4.20110207")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/Users/rpg/.emacs.d/elpa/auto-complete-1.4.20110207/dict")

(setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

;; android specific settings
;; AndroidManifest.xml
;; (defun ac-android-manifest-nxml-setup()
;;   ""
;;   (when (string= (buffer-name) "AndroidManifest.xml")
;;     (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))))
;; (add-hook 'nxml-mode-hook 'ac-android-manifest-nxml-setup)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)


;; android specific settings
;; AndroidManifest.xml
(defun ac-android-manifest-nxml-setup()
  (when (string= (buffer-name) "AndroidManifest.xml")
    (setq ac-sources '(ac-source-yasnippet
                       ac-source-abbrev
                       ac-source-dictionary
                       ac-source-words-in-same-mode-buffers))
    ((lambda () (auto-complete-mode 1)))))
(add-hook 'nxml-mode-hook 'ac-android-manifest-nxml-setup)

;; ------------------------

;; (add-to-list 'load-path "/usr/local/Cellar/maxima/5.25.1/share/maxima/5.25.1/emacs/")
;; (add-to-list 'load-path "/usr/local/Cellar/maxima/5.25.1/bin/")
;; (autoload 'maxima-mode "maxima" "Maxima mode" t)
;; (autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
;; (autoload 'maxima "maxima" "Maxima interaction" t)
;; (autoload 'imath-mode "imath" "Imath mode for math formula input" t)
;; (setq imaxima-use-maxima-mode-flag t)

;; Vedang's init.el extension
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)

;; Hide Show config
(load-library "hideshow")
(defvar my-hs-hide t "Current state of hideshow for toggling all.")
;;;###autoload
(defun my-toggle-hideshow-all ()
  "Toggle hideshow all."
  (interactive)
  (set (make-variable-buffer-local 'my-hs-hide) (not my-hs-hide))
  (if my-hs-hide
      (hs-hide-all)
    (hs-show-all)))

;; Added 2003.11.21 ---
(defun sacha/hs-minor-mode-setup ()
  "Turn on `hs-minor-mode' and hide everything."
  (hs-minor-mode 1)
  (hs-hide-all)
  (set (make-variable-buffer-local 'my-hs-hide) t))
 ;; (add-hook 'emacs-lisp-mode-hook 'sacha/hs-minor-mode-setup)
 ;; (add-hook 'java-mode-hook 'sacha/hs-minor-mode-setup)
 ;; (add-hook 'perl-mode-hook 'sacha/hs-minor-mode-setup)

;; Maybe make this a define-key for hs-minor-mode-map to be proper?
(global-set-key (kbd "C-c @ @") 'my-toggle-hideshow-all)
(global-set-key (kbd "C-c @ h") 'hs-hide-block)
(global-set-key (kbd "C-c @ s") 'hs-show-block)
(global-set-key (kbd "C-c @ SPC") 'hs-show-block)

;; Emacs-nav
(load-library "nav")

;; Emacs eclim
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/emacs-eclim/"))
;; only add the vendor path when you want to use the libraries provided with emacs-eclim
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/emacs-eclim/vendor"))
(require 'eclim)

(setq eclim-auto-save t)
(global-eclim-mode)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(add-hook 'eclim-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-emacs-eclim)))

;; ---- Objective C Mode ----
;;(setq auto-mode-alist
      ;; (cons '("\\.m$" . objc-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (cons '("\\.mm$" . objc-mode) auto-mode-alist))

;; (setq initial-scratch-message nil)
;; (setq initial-buffer-choice "/Users/rpg/init-art")

;; ---- fullscreen mode ----
;; (require 'maxframe)
;; (add-hook 'window-setup-hook 'maximize-frame t)
;; (x-maximize-frame)

;; Dictionary

;; (require 'dictem)
;; (setq dictem-server "dict.org")
;; (setq dictem-port "2628")
;; (dictem-initialize)

;; (global-set-key "\C-cs" 'dictem-run-search)
;; (global-set-key "\C-cd" 'dictem-run-define)

;; auto-complete-etags
(provide 'auto-complete-etags)
(require 'auto-complete)
(eval-when-compile
  (require 'cl))

(defface ac-etags-candidate-face
  '((t (:background "gainsboro" :foreground "deep sky blue")))
  "Face for etags candidate")

(defface ac-etags-selection-face
  '((t (:background "deep sky blue" :foreground "white")))
  "Face for the etags selected candidate.")

(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-etags-candidate-face)
    (selection-face . ac-etags-selection-face)
    (requires . 3))
  "Source for etags.")


;; -- org-mode
(setq org-agenda-files '("~/Downloads/"))
(require 'org-latex)
(setenv "PATH" (shell-command-to-string "echo -n $PATH"))

;; -- beautify json
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))
;; --- nero
(load-library "w3m-load.el")
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
(global-set-key "\C-xl" 'load-library)

;; ------ AucTeX ------
(add-to-list 'load-path "/usr/local/Cellar/auctex/11.86/share/emacs/site-lisp/")
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t)
(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"

(getenv "PATH")))
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(global-set-key "\C-cp" 'doc-view-previous-page)
(global-set-key "\C-cn" 'doc-view-next-page)

;; --- mu4e ---
(add-to-list 'load-path "/Users/rpg/.emacs.d/elpa/mu4e")
(load-library "mu4e")

     ;; default
     ;; (setq mu4e-maildir (expand-file-name "~/Maildir"))

     (setq mu4e-drafts-folder "/[Gmail].Drafts")
     (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
     (setq mu4e-trash-folder  "/[Gmail].Trash")

     ;; don't save message to Sent Messages, Gmail/IMAP will take care of this
     (setq mu4e-sent-messages-behavior 'delete)

     ;; setup some handy shortcuts
     (setq mu4e-maildir-shortcuts
         '( ("/INBOX"               . ?i)
            ("/[Gmail].Sent Mail"   . ?s)
            ("/[Gmail].Trash"       . ?t)
            ("/[Gmail].All Mail"    . ?a)))

     ;; allow for updating mail using 'U' in the main view:
     (setq mu4e-get-mail-command "offlineimap")

     ;; something about ourselves
     (setq
        user-mail-address "rpg@helpshift.com"
        user-full-name  "Roupam Ghosh"
        message-signature
         (concat
           "\n\nRoupam Ghosh\n"
           "Sent from emacs\n"))

     ;; sending mail -- replace USERNAME with your gmail username
     ;; also, make sure the gnutls command line utils are installed
     ;; package 'gnutls-bin' in Debian/Ubuntu

     (require 'smtpmail)
     ;; (setq message-send-mail-function 'smtpmail-send-it
     ;;    starttls-use-gnutls t
     ;;    smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
     ;;    smtpmail-auth-credentials '(("smtp.gmail.com" 587 "rpg@helpshift.com" nil))
     ;;    smtpmail-default-smtp-server "smtp.gmail.com"
     ;;    smtpmail-smtp-server "smtp.gmail.com"
     ;;    smtpmail-smtp-service 587)

     ;; alternatively, for emacs-24 you can use:
     (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-stream-type 'starttls
          smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587)

     ;; don't keep message buffers around
     (setq message-kill-buffer-on-exit t)

;; -------- Octopress config ----------

(defun save-then-publish ()
  (interactive)
  (save-buffer)
  (org-save-all-org-buffers)
  (org-publish-current-project))


(setq org-publish-project-alist
      '(("blog-org" .  (:base-directory "~/git/octopress/source/org_posts/"
                                        :base-extension "org"
                                        :publishing-directory "~/git/octopress/source/_posts/"
                                        :sub-superscript ""
                                        :recursive t
                                        :publishing-function org-publish-org-to-octopress
                                        :headline-levels 4
                                        :html-extension "markdown"
                                        :octopress-extension "markdown"
                                        :body-only t))
        ("blog-extra" . (:base-directory "~/git/octopresss/source/org_posts/"
                                         :publishing-directory "~/git/octopress/source/"
                                         :base-extension "css\\|pdf\\|png\\|jpg\\|gif\\|svg"
                                         :publishing-function org-publish-attachment
                                         :recursive t
                                         :author nil
                                         ))
        ("blog" . (:components ("blog-org" "blog-extra")))
        ))

(require 'octopress)
(require 'org-octopress)
(setq exec-path (append exec-path '("/Users/rpg/git/octopress/")))

;; ------ Powerline -------

(require 'powerline)
(custom-set-faces
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;; ------- Sauron notifications ------
(add-to-list 'load-path "~/.emacs.d/elpa/sauron/")
(require 'sauron)
(setq sauron-dbus-cookie t)


;; ------ IRC clients ------
(setq rcirc-server-alist
      '(("irc.qotdinc.com" :channels ("#dev" "#bakvaas"))))

;; ------ Emacs Muse ------
;; Add this to your .emacs or .xemacs/init.el file.
(setq load-path (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/muse/"))
(require 'muse-mode)
(require 'muse-publish)
(require 'muse-html)  ;; and so on

;;init.el end
