;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "mPut"
      user-mail-address "putintsev@gmail.com")
(add-load-path! "vendor/")
(require 'auto-dark-emacs)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)
(setq auto-dark-emacs/dark-theme 'doom-solarized-dark)
(setq auto-dark-emacs/dark-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Yandex.Disk.localized/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

(setq avy-all-windows t)

(setq initial-frame-alist
'((top . 30) (left . 15) (width . 180) (height . 50)))

(use-package! paredit
  :hook ((scheme-mode emacs-lisp-mode clojure-mode) . enable-paredit-mode))

;; (use-package! aggressive-indent
;;   :hook
;;   (clojure-mode . aggressive-indent-mode)
;;   (hy-mode . aggressive-indent-mode)
;;   (emacs-lisp-mode . aggressive-indent-mode))

(use-package! lispyville
  :when (featurep! :editor evil)
  :hook ((emacs-lisp-mode clojure-mode json-mode) . lispyville-mode) ;; :hook (lispy-mode . lispyville-mode)
  :config
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     c-u
     (prettify insert)
     (atom-movement normal visual)
     slurp/barf-lispy
     additional
     commentary
     additional-insert)))

(map! (:localleader
       (:map (clojure-mode-map clojurescript-mode-map)
        (:prefix ("e" . "eval")
         "f" #'cider-eval-defun-at-point
         "F" #'cider-insert-defun-in-repl
         ";" #'cider-pprint-eval-last-sexp-to-comment)
        (:prefix ("i")
         "p" #'cider-inspector-pop)))
      (:leader
       (:map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
        (:prefix ("l" . "lisp")
         "j" #'paredit-join-sexps
         "c" #'paredit-split-sexp
         "s" #'paredit-splice-sexp
         "d" #'paredit-kill
         "<" #'paredit-backward-slurp-sexp
         ">" #'paredit-backward-barf-sexp
         "." #'paredit-forward-slurp-sexp
         "," #'paredit-forward-barf-sexp
         "r" #'paredit-raise-sexp
         "w" #'paredit-wrap-sexp
         "[" #'paredit-wrap-square
         "'" #'paredit-meta-doublequote
         "{" #'paredit-wrap-curly)))
      (:after ivy
       :map ivy-minibuffer-map
       "C-d" #'ivy-switch-buffer-kill))

(after! cider
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (set-popup-rule! "^\\*cider*" :size 0.45 :side 'right :ttl 0 :select t :quit t))

(set-popup-rule! "^\\*help*" :size 0.4 :side 'bottom :select t :quit t)
(set-popup-rule! "^\\*info*" :size 0.7 :side 'bottom :select t :quit t)
(set-popup-rule! "^\\*Flycheck*" :size 0.3 :side 'bottom :select t :quit t)

(+global-word-wrap-mode +1)

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))

(add-hook! '(clojure-mode-local-vars-hook
             clojurec-mode-local-vars-hook
             clojurescript-mode-local-vars-hook)
  (defun lsp-cl-params ()
    (setq-local lsp-enable-symbol-highlighting nil)
    (setq-local lsp-diagnostic-package :none))
  (defun my-flycheck-setup ()
    (setq-local flycheck-disabled-checkers '(lsp))
    (setq-local flycheck-checkers '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))))


;; here are some additional functions/macros that could help you configure doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; to get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'k' (non-evil users must press 'c-c g k').
;; this will open documentation for it, including demos of how they are used.
;;
;; you can also try 'gd' (or 'c-c g d') to jump to their definition and see how
;; they are implemented.
