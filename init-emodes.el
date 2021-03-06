;; -------------------------------------------------------------------------
;; File: init-emodes.el -  configure Emacs mode options
;;       Part of my emacs configuration (see ~/.emacs or init.el)
;;
;; Copyright (c) 2010 Sebastien Varrette <Sebastien.Varrette@uni.lu>
;;               http://varrette.gforge.uni.lu
;;
;; -------------------------------------------------------------------------
;;   _       _ _                                 _                      _
;;  (_)_ __ (_) |_       ___ _ __ ___   ___   __| | ___  ___        ___| |
;;  | | '_ \| | __|____ / _ \ '_ ` _ \ / _ \ / _` |/ _ \/ __|      / _ \ |
;;  | | | | | | ||_____|  __/ | | | | | (_) | (_| |  __/\__ \  _  |  __/ |
;;  |_|_| |_|_|\__|     \___|_| |_| |_|\___/ \__,_|\___||___/ (_)  \___|_|
;;
;; -------------------------------------------------------------------------
;; More information about Emacs Lisp:
;;              http://www.emacswiki.org/emacs/EmacsLisp
;; -------------------------------------------------------------------------
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; -------------------------------------------------------------------------

;; ===================================================
;; === Shell pop ===
;; see http://www.emacswiki.org/emacs/ShellPop
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60)         ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 

;; ===================================================
;; === Aspell/Ispell spell checking ===
;; see http://www.emacswiki.org/emacs/InteractiveSpell

;; use GNU Aspell (see http://aspell.net/)  instead of (port of) `ispell'
(setq-default ispell-program-name "aspell")
;; extra switches to pass to the `ispell' program
(setq ispell-extra-args '("--sug-mode=ultra"))
                                        ; tell `aspell' to speed up, though this
                                        ; reduces somewhat the quality of its
                                        ; suggestions.  According to the
                                        ; `aspell' documentation, "ultra" is the
                                        ; fastest suggestion mode, which is
                                        ; still twice as slow as `ispell'.  If
                                        ; your machine is fast enough, a better
                                        ; option might be to try "fast" mode,
                                        ; which is twice as slow as "ultra", but
                                        ; more accurate.  The "normal" mode,
                                        ; which is the `aspell' default, is even
                                        ; more accurate, but is reportedly 10
                                        ; times slower than "fast" mode.

;; `aspell' extensions should be used
(setq ispell-really-aspell t)

;; save the personal dictionary without confirmation
(setq ispell-silently-savep t)

;; solve the problem of words separated by `-' flagged as erroneous
;; by removing the `-' from the value of otherchars
(if (fboundp 'ispell-get-decoded-string)
    (defun ispell-get-otherchars ()
      (replace-regexp-in-string "-" "" (ispell-get-decoded-string 3))))

;; LaTeX-sensitive spell checking
(setq ispell-enable-tex-parser t)

;; defautl dictionnary
(setq ispell-local-dictionary "en")

;; === Flyspell: on-the-fly spell checking in Emacs ===
;; see http://www.emacswiki.org/emacs/FlySpell
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;; enable the likeness criteria
(setq flyspell-sort-corrections nil)

;; dash character (`-') is considered as a word delimiter
(setq flyspell-consider-dash-as-word-delimiter-flag t)

;; Add flyspell to the following major modes
(dolist (hook '(text-mode-hook html-mode-hook messsage-mode-hook))
  (add-hook hook (lambda ()
                   (turn-on-auto-fill)
                   (flyspell-mode t))))

;; disable flyspell in change log and log-edit mode that derives from text-mode
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode nil))))

;; flyspell comments and strings in programming modes
;; (preventing it from finding mistakes in the code)
(dolist (hook '(autoconf-mode-hook autotest-mode-hook c++-mode-hook c-mode-hook cperl-mode-hook  emacs-lisp-mode-hook makefile-mode-hook nxml-mode-hook python-mode-hook
                                   sh-mode-hook))
  (add-hook hook 'flyspell-prog-mode))

;; (add-hook 'autoconf-mode-hook   'flyspell-prog-mode)
;; (add-hook 'autotest-mode-hook   'flyspell-prog-mode)
;; (add-hook 'c++-mode-hook        'flyspell-prog-mode)
;; (add-hook 'c-mode-hook          'flyspell-prog-mode)
;; (add-hook 'cperl-mode-hook      'flyspell-prog-mode)
;; (add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
;; (add-hook 'makefile-mode-hook   'flyspell-prog-mode)
;; (add-hook 'nxml-mode-hook       'flyspell-prog-mode)
;; (add-hook 'python-mode-hook     'flyspell-prog-mode)
;; (add-hook 'sh-mode-hook         'flyspell-prog-mode)

;; spell-check your XHTML
(eval-after-load "flyspell"
  '(progn
     (add-to-list 'flyspell-prog-text-faces 'nxml-text-face)))

;; TODO: Take a look at `diction' (style and grammar)

;; ========= apache-mode ===========
;; see http://www.emacswiki.org/cgi-bin/wiki/apache-mode.el
;; Major mode for editing apache configuration files
(require 'apache-mode)


;; ===================================================
;; === Recentf mode ===
;; see http://www.emacswiki.org/emacs/RecentFiles
;; A minor mode that builds a list of recently opened files
(require 'recentf)

;;  file to save the recent list into
(setq recentf-save-file "~/.emacs.d/.recentf")

;; maximum number of items in the recentf menu
(setq recentf-max-menu-items 30)

;; save file names relative to my current home directory
(setq recentf-filename-handlers '(abbreviate-file-name))

(recentf-mode t)                        ; activate it


;; ===================================================
;; === Winner mode ===
;; see http://www.emacswiki.org/emacs/WinnerMode
;; allows to "undo" (and "redo") changes in the window configuration
;; via "C-c left" and "C-c right".
(when (fboundp 'winner-mode)
  (winner-mode t))

;; ===================================================
;; === Web browsing ===
;; Emacs Web browser -- see http://www.emacswiki.org/emacs/ewb.el
(autoload 'ewb "ewb" "emacs web browser" t)

;; ===================================================
;; === LaTeX ===
;; Load AucTeX : see http://www.gnu.org/software/auctex/
;; Debian/ubuntu: apt-get install auctex
;; Mac OS X: preinstalled on Carbon Emacs
(load "auctex.el" nil t t)
;;(require 'tex-site)

;; AUC TeX will will assume the file is a master file itself
;;(setq-default TeX-master t)

;;(setq TeX-auto-save t)

(setq TeX-parse-self t) ; enable parse on load (if no style hook is found for the file)

(setq TeX-directory ".")
(setq TeX-mode-hook '((lambda () (setq abbrev-mode t))))

(setq-default TeX-PDF-mode t)         ; use PDF mode by default (instead of DVI)

;;(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; number of spaces to add to the indentation for each `\begin' not matched by a
;; `\end'
(setq LaTeX-indent-level 4)

;; number of spaces to add to the indentation for `\item''s in list
;; environments
(setq LaTeX-item-indent -2)             ; -4

;; number of spaces to add to the indentation for each `{' not matched
;; by a `}'
(setq TeX-brace-indent-level 2)         ; 4

;; auto-indentation (suggested by the AUCTeX manual -- instead of adding
;; a local key binding to `RET' in the `LaTeX-mode-hook')
(setq TeX-newline-function 'newline-and-indent)

;; don't show output of TeX compilation in other window
                                        ;(setq TeX-show-compilation nil)

;; Directory containing automatically generated TeX information.
;; Must end with a slash
;;(setq TeX-auto-global "~/.emacs.d/auctex-auto-generated-info/")
;;(setq TeX-auto-local  "~/.emacs.d/auctex-auto-generated-info/")

;; RefTex: manage cross references, bibliographies, indices, document navigation
;; and a few other things
;; see http://www.emacswiki.org/emacs/RefTeX
(require 'reftex)

;; make a LaTeX reference (to a label) by pressing `C-c )'
;; insert a label by pressing `C-c (' (or `C-('
;; insert a citation by pressing `C-c [' (or `C-['

;; hit `C-c ='; the buffer will split into 2 and in the top half you
;; will see a TOC, hitting `l' there will show all the labels and cites.

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t)

;; ===================================================
;; === Dired (directory-browsing) ===
;; see http://www.emacswiki.org/emacs/DiredMode
;; Shows a directory (folder) listing that you can use to perform various
;; operations on files and subdirectories in the directory and its
;; subdirectories
(require 'dired)

;; doc: see http://www.gnu.org/software/emacs/manual/dired-x.html
;; see also ~/.emacs.d/dired-refcard.gnu.pdf
(add-hook 'dired-load-hook
         (function (lambda  ()
                     (load "dired-x")
                     (setq  dired-listing-switches       "-alF"
                            dired-ls-F-marks-symlinks    t
                            dired-guess-shell-gnutar     "gnutar"
                            dired-guess-shell-alist-user '(("\\.tgz$" "gnutar zxvf"))
                            )
                     )))

;; Mac Open/Execute from dired
(define-key dired-mode-map "p" 'dired-open-with-open) ; see ~/.emacs.d/init-defuns.el
(setq dired-enable-local-variables nil)
(setq dired-local-variables-file   nil)

;; === SVN support ===
(require 'vc-svn)
(add-to-list 'vc-handled-backends 'SVN)

(require 'vc-svn17)

;; === GIT support ===
;; based on magit (installed by elpa -- see ~/.emacs.d/init-elpa)
;; documentation: http://zagadka.vm.bytemark.co.uk/magit/magit.html


;; ;; === Web developement ===
;; ;; NxhtmlMode : see http://www.emacswiki.org/emacs/NxhtmlMode
;; ;; and http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
;; (load "~/.emacs.d/site-lisp/nxhtml/autostart.el")

;; ;; open a popup-menu for completing tags
;; (defun my-nxml-complete-binding ()
;;   (local-set-key (read-kbd-macro "C-<return>") 'nxml-complete))
;; (add-hook 'nxml-mode 'my-nxml-complete-binding)

;; =========================================================================
;; =========================== PROGRAMMING STUFF ===========================
;; =========================================================================

;; === POD mode ===
;; see http://github.com/jrockway/emacs-pod-mode
(require 'pod-mode)
(add-hook 'pod-mode-hook 'font-lock-mode)

;; === Automode alist ===
;; list of filename patterns vs. corresponding major mode functions
(setq auto-mode-alist
      (append
       '(("\\.pov$"         . pov-mode)
         ("\\.c$"           . c-mode)
         ("\\.pod$"         . pod-mode)
         ("\\.\\(h\\|cpp\\|cc\\|hpp\\|cxx\\)$"  . c++-mode)
         ("\\.\\(wml\\|htm\\|html\\|xhtml\\)$"  . nxhtml-mode)
         ("\\.\\(diffs?\\|patch\\|rej\\)\\'"    . diff-mode)
         ("\\.\\(pl\\|pm\\|cgi\\)$"             . cperl-mode)
         ("\\.gnuplot$"     . gnuplot-mode)
         ("\\.plot$"     . gnuplot-mode)
         ("\\.php$"         . php-mode)
         ("\\.css$"         . css-mode)
         ("\\.md$"          . markdown-mode)
         ("\\.rake$"        . ruby-mode)
         ("\\.gemspec$"     . ruby-mode)
         ("\\.rb$"          . ruby-mode)
         ("Rakefile$"       . ruby-mode)
         ("Gemfile$"        . ruby-mode)
         ("Capfile$"        . ruby-mode)
         (".ssh/config\\'"  . ssh-config-mode)
         ("sshd?_config\\'" . ssh-config-mode)
         ("^TODO"           . change-log-mode))
       auto-mode-alist))

;; list of interpreters specified in the first line (starts with `#!')
(setq interpreter-mode-alist
      (append
       `(("perl"   . cperl-mode)
         ("expect" . tcl-mode)
         ;;("bash" . sh-mode)
         ) interpreter-mode-alist))


;; === Doxymacs ===
;; see http://doxymacs.sourceforge.net/
;; to be installed on your machine as it contains a compiled code
(require 'doxymacs)
(add-hook 'c-mode-hook   'doxymacs-mode)
(add-hook 'c++-mode-hook 'doxymacs-mode)

;; === YAML ===
;; see http://www.emacswiki.org/emacs/YamlMode
;; and https://github.com/yoshiki/yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; === Source file navigation ===
;; load the corresponding file C/C++ header or source file for the current
;; buffer.
;; I now prefer to use eassist (see ~/.emacs.d/init-cedet)

;; (load-library "sourcepair")
;; (global-set-key "\C-xz" 'sourcepair-load)
;; (setq sourcepair-source-path    '( "." "../*" ))
;; (setq sourcepair-header-path    '( "." "Include" "../Include" "include" "../include" "../*"))
;; (setq sourcepair-recurse-ignore '( "CVS" "Obj" "Debug" "Release" ".svn" ".git"))

;; === Code template ===
;; see http://www.emacswiki.org/emacs/TempoMode
;; my personnal tempo configuration for templates in C and C++
;; see ~/.emacs.d/tempo-c-cpp
;; binding to 'C-t C-t' or 'f5' by default
(require 'tempo-c-cpp)

;; Templates using Yasnippet: Yet Another Snippet extension for Emacs.
;; see http://www.emacswiki.org/emacs/Yasnippet and http://yasnippet.googlecode.com
;; Installation notes: see README
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/yasnippet") ; my personnal settings
(yas/load-directory yas/root-directory)          ; Load the snippets

;; key bindings
(defun my-yas-trigger-key-hook ()
  (global-set-key (read-kbd-macro "M-<return>") 'yas/expand)
  )

;; application to the supported modes
(add-hook 'c-mode-common-hook   'my-yas-trigger-key-hook)
(add-hook 'python-mode-hook     'my-yas-trigger-key-hook)
(add-hook 'ruby-mode-hook       'my-yas-trigger-key-hook)
(add-hook 'perl-mode-hook       'my-yas-trigger-key-hook)
(add-hook 'lisp-mode-hook       'my-yas-trigger-key-hook)
(add-hook 'nxhtml-mode-hook     'my-yas-trigger-key-hook)
(add-hook 'emacs-lisp-mode-hook 'my-yas-trigger-key-hook)
(add-hook 'latex-mode-hook      'my-yas-trigger-key-hook)
(add-hook 'sql-mode-hook        'my-yas-trigger-key-hook)
(add-hook 'css-mode-hook        'my-yas-trigger-key-hook)
(add-hook 'nxml-mode-hook       'my-yas-trigger-key-hook)


;;(yas/load-directory "~/.emacs.d/plugins/yasnippet-x.y.z/snippets")
;;(setq yas/root-directory "~/.emacs.d/yasnippet") ; directory containing my templates
;;(yas/load-directory yas/root-directory)          ;  Load the snippets


;; === Code completion ===
;; see http://www.emacswiki.org/emacs/TabCompletion
(require 'smart-tab)
(global-smart-tab-mode t)

;; Disable indent "smart" alignement to insert real tabs
(defun indent-with-real-tab-hook ()
  (setq indent-line-function 'insert-tab)
  )
;;(add-hook 'text-mode-hook   'indent-with-real-tab-hook)
(add-hook 'conf-mode-hook   'indent-with-real-tab-hook)



;; =======================================
;; === Auto Encryption (with GPG etc.) ===
;; =======================================
;; See http://www.emacswiki.org/emacs/EasyPG
(unless (equal emacs-major-version 23)
  (require 'epa-setup))
(require 'epa-file)
(epa-file-enable)


;; ================================================
;; === Integrated Development Environment (IDE) ===
;; ================================================
;; Mainly rely on Collection Of Emacs Development Environment Tools (CEDET)
;; see http://cedet.sourceforge.net/
;; see ~/.emacs.d/init-cedet.el
(require 'init-cedet)

;; === Markdown ===
;; see http://jblevins.org/projects/markdown-mode/
(require 'markdown-mode)

;; === Ruby ===
;; cf http://www.emacswiki.org/emacs/RubyMode
;; ruby-mode is included in Emacs 23 and is also available via ELPA
;;(require 'ruby-mode)
(autoload    'ruby-mode       "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(setq ruby-indent-level 4)

;; see http://sl33p3r.free.fr/blog/ruby/RubyAndEmacs.html
;; automatic close parenthesis, 'def' keywords etc.
(require 'ruby-electric)

;; rdoc mode
(require 'rdoc-mode)
                                        ;(add-hook 'ruby-mode-hook 'rdoc-mode)

;; Puppet config
(require 'puppet-mode)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(setq puppet-indent-level 4)


;; Ri (ruby info) for Emacs
;; see http://rubyforge.org/projects/ri-emacs/
                                        ;(setq ri-ruby-script "/Users/svarrette/.emacs.d/site-lisp/ri-emacs.rb")
                                        ;(require 'ri-ruby)

;; Ruby on Rails
;; see http://www.emacswiki.org/emacs/RubyOnRails
;; In particular, I use the config from  http://github.com/dima-exe/emacs-rails-reloaded/tree/master
                                        ;(require 'rails-autoload)
;; (defun my-ruby-mode-hook ()
;;   (ruby-electric-mode t))
;; (add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

;; Webgen (static website generation)
;; see http://webgen.rubyforge.org/
;; Webgen mode: http://www.emacswiki.org/emacs/WebgenMode
(require 'webgen-mode nil t)
(add-to-list 'auto-mode-alist '("\\.page$" .     (lambda () (markdown-mode) (webgen-mode))))
(add-to-list 'auto-mode-alist '("\\.template$" . (lambda () (html-mode)     (webgen-mode))))
(add-to-list 'auto-mode-alist '("[Mm]etainfo$" . (lambda () (text-mode)     (webgen-mode))))

;; RVM (Ruby Version Manager) support 
;; see https://github.com/senny/rvm.el
(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

;; Gnuplot 
;; see http://astro.berkeley.edu/~mkmcc/software/gnuplot-mode.html
(require 'gnuplot)
;; specify the gnuplot executable (if other than /usr/bin/gnuplot)
(setq gnuplot-program "/usr/local/bin/gnuplot")

;; automatically open files ending with .gp or .gnuplot in gnuplot mode
(setq auto-mode-alist 
(append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist))



(provide 'init-emodes)
;; ----------------------------------------------------------------------
;; eof
;;
;; Local Variables:
;; mode: lisp
;; End:


