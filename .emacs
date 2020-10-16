;; Red Hat Linux default .emacs initialization file  ; -*- mode: emacs-lisp -*-

;; MAC OSX
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)
(setq mac-control-modifier 'super)
(set-keyboard-coding-system nil)
;; The above works in the GUI emacs

(setq tab-width 2)
(setq js-indent-level 2)
(setq c-basic-offset 2)

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

(global-set-key [f4] 'goto-line)
(global-set-key [f3] 'shell)
(global-set-key [f5] 'switch-to-buffer)
(global-set-key (kbd "C-q") 'switch-to-buffer)
(global-set-key [f6] 'query-replace)
(global-set-key [f8] 'hippie-expand)
(global-set-key [f7] 'ispell)


(global-set-key (kbd "M-_") 'shrink-window-horizontally)
(global-set-key (kbd "M-+") 'enlarge-window-horizontally)
(global-set-key (kbd "M--") 'shrink-window)
(global-set-key (kbd "M-=") 'enlarge-window)

(global-set-key (kbd "M-u") 'undo) 

(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "C-v") `keyboard-escape-quit)

(defun colorize-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) 


;;BEGIN RUBY-MODE
;; turn on font-lock mode
(global-font-lock-mode t)
;; enable visual feedback on selections
(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;;p4
;;(add-to-list 'load-path "~/.emacs.d/site-lisp")
;;(load-library "p4")
;

;(tool-bar-mode -1)
(menu-bar-mode -1)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby")

(autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\\.ctl$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\\Rakefile$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\\.rakefile$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
 ;; If you have Emacs 19.2x or older, use rubydb2x                              
 (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
 ;; uncomment the next line if you want syntax highlighting                     
 (add-hook 'ruby-mode-hook 'turn-on-font-lock)

; BEGIN CEDET INSTALL
; allows syntax highlighting to work
; (global-font-lock-mode 1)

;; Load CEDET.
;; This is required by ECB which will be loaded later.
;; See cedet/common/cedet.info for configuration details.
;(load-file "/home/skyf/.emacs_includes/plugins/cedet-1.0/common/cedet.el")

;; Enable EDE (Project Management) features
;(global-ede-mode 1)

;; * This enables the database and idle reparse engines
;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;(semantic-load-enable-code-helpers)
; END CEDET INSTALL

; BEGIN ECB INSTALL
;(add-to-list 'load-path "/home/skyf/.emacs_includes/plugins/ecb-2.40")
;(load-file "/home/skyf/.emacs_includes/plugins/ecb-2.40/ecb.el")
; END ECB INSTALL


; BEGIN RUBY AUTO INDENT
(add-hook 'ruby-mode-hook
      (lambda()
        (add-hook 'local-write-file-hooks
                  '(lambda()
                     (save-excursion
                       (untabify (point-min) (point-max))
                       (delete-trailing-whitespace)
                       )))
        (set (make-local-variable 'indent-tabs-mode) 'nil)
        (set (make-local-variable 'tab-width) 2)
        (imenu-add-to-menubar "IMENU")
        (define-key ruby-mode-map "\C-m" 'newline-and-indent) ;Not sure if this line is 100% right!
        ;(require 'ruby-electric) ; if i ever want 'electric key words' def, end, { ect...
        ;(ruby-electric-mode t)
        ))

; END RUBY AUTO INDENT
; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key (kbd "C-c c") 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key (kbd "C-c k") 'mode-compile-kill)
; END MODE COMPILE

; Set up some frame traversal keys
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)

(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)


;BEGIN RHTML MODE
(defface erb-face
  `((t (:background "grey18")))
  "Default inherited face for ERB tag body"
  :group 'rhtml-faces)

(defface erb-delim-face
  `((t (:background "grey15")))
  "Default inherited face for ERB tag delimeters"
  :group 'rhtml-faces)
;;; rhtml mode
(require 'rhtml-mode)
; put rhtml templates into rhtml-mode
(setq auto-mode-alist  (cons '("\\.rhtml$" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("\\.erb$" . rhtml-mode) auto-mode-alist))
; put any rjs scripts into ruby-mode, as they are basically ruby
(setq auto-mode-alist  (cons '("\\.rjs$" . ruby-mode) auto-mode-alist))
;END RHTML MODE

;;BEGIN RINARI
(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-g") 'ido-find-file)
(setq rinari-tags-file-name "TAGS")
;;END RINARI
;;BEGIN Ruby flymake
;(require 'flymake-ruby)
;(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; I don't like the default colors :)
;(require 'flymake)
;(set-face-background 'flymake-errline "red4")
;(set-face-background 'flymake-warnline "dark slate blue")
;;END flymake-ruby

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;;(when
;;    (load
;;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;;  (package-initialize))

;; rvm




;;(require `rvm)
;;(rvm-use-default) ;; use rvm.s default ruby for the current Emacs session
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

; Used for dvi access
;(server-start)

;; Used for latex autocomplete functionality
(add-to-list 'load-path "~/.emacs.d/autocomplete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/autocomplete/ac-dict")
(ac-config-default)

(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/autocomplete/ac-l-dict/")
(add-to-list 'ac-modes 'LaTeX-mode)
(add-to-list 'ac-modes 'tex-mode)
(add-to-list 'ac-modes 'latex-mode) ; important one
(add-to-list 'ac-modes 'TeX-mode)

(add-hook 'LaTeX-mode-hook 'ac-l-setup)
; END latex autocomplete

; JS MODE
(setq auto-mode-alist  (cons '("\\.js$" . javascript-mode) auto-mode-alist))

; org mode
(setq auto-mode-alist  (cons '("\\.org$" . org-mode) auto-mode-alist))

; put cython files into python mode
(add-to-list 'load-path "~/.emacs.d/cython")
(require 'cython-mode)
;;(setq auto-mode-alist  (cons '("\\.pyx$" . python-mode) auto-mode-alist))
;;(setq auto-mode-alist  (cons '("\\.pxd$" . python-mode) auto-mode-alist))

; go mode
(add-to-list 'load-path "~/.emacs.d/go-mode")
(require 'go-mode-autoloads)
(add-hook 'go-mode-hook 
  (lambda ()
    (setq-default) 
    (setq tab-width 2) 
    (setq standard-indent 2) 
    (setq indent-tabs-mode nil)))

;; TOOD: Enable this for MAC
;(require 'xcscope)
;(define-key global-map [(ctrl f3)] 'cscope-set-initial-directory)
;(define-key global-map [(ctrl f4)] 'cscope-unset-initial-directory)
;(define-key global-map [(ctrl f5)] 'cscope-find-this-symbol)
;(define-key global-map [(ctrl f6)] 'cscope-find-global-definition)
;(define-key global-map [(ctrl f7)] 'cscope-find-global-definition-no-prompting)
;(define-key global-map [(ctrl f8)] 'cscope-pop-mark)
;; (define-key global-map [(ctrl f9)] 'cscope-next-symbol)
;; (define-key global-map [(ctrl f10)] 'cscope-next-file)
;; (define-key global-map [(ctrl f11)] 'cscope-prev-symbol)
;; (define-key global-map [(ctrl f12)] 'cscope-prev-file)
;; (define-key global-map [(meta f9)] 'cscope-display-buffer)
;; (define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)


; tex redefenitions
; compile with out \\nonstopmode and with --file-line-error
(setq tex-start-commands "--file-line-error")
; pdflatex --file-line-error \\input dissertation.tex
