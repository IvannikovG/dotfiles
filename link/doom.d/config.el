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
(setq doom-font (font-spec :family "iosevka" :size 18 :antialias="off"))
;; (setq doom-font "Fira Code Retina:pixelsize=16:antialias=off")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)
(setq auto-dark-emacs/dark-theme 'doom-solarized-dark)
(setq auto-dark-emacs/light-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Yandex.Disk.localized/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)
(global-subword-mode 1)
;; (display-battery-mode 1)
;; (display-time-mode 1)

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))


(setq avy-all-windows t)

;; (toggle-frame-maximized)
(setq initial-frame-alist
'((top . 30) (left . 15) (width . 140) (height . 36)))

(use-package! paredit
  :hook ((scheme-mode emacs-lisp-mode clojure-mode) . enable-paredit-mode))

(after! evil (evil-escape-mode nil))

;; Temp fix, https://github.com/hlissner/doom-emacs/issues/2860
(after! dtrt-indent
  (add-to-list 'dtrt-indent-hook-mapping-list '(typescript-tsx-mode typescript-mode javascript typescript-indent-level)))

;; (use-package! aggressive-indent
;;   :hook
;;   (clojure-mode . aggressive-indent-mode)
;;   (hy-mode . aggressive-indent-mode)
;;   (emacs-lisp-mode . aggressive-indent-mode))

;; (use-package! lispyville
;;   :when (featurep! :editor evil)
;;   :hook ((emacs-lisp-mode clojure-mode json-mode) . lispyville-mode) ;; :hook (lispy-mode . lispyville-mode)
;;   :config
;;   (lispyville-set-key-theme
;;    '((operators normal)
;;      c-w
;;      c-u
;;      (prettify insert)
;;      (atom-movement normal visual)
;;      slurp/barf-lispy
;;      additional
;;      commentary
;;      additional-insert)))

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

;; (map! :leader
;;       :desc "Switch to last buffer" "TAB"    #'evil-switch-to-windows-last-buffer
;;       ;;; <leader> TAB --- workspace
;;       (:when (featurep! :ui workspaces)
;;        (:prefix-map ("`" . "workspace")
;;         :desc "Display tab bar"           "`" #'+workspace/display
;;         :desc "Switch workspace"          "."   #'+workspace/switch-to
;;         :desc "Switch to last workspace"  "TAB"   #'+workspace/other
;;         :desc "New workspace"             "n"   #'+workspace/new
;;         :desc "Load workspace from file"  "l"   #'+workspace/load
;;         :desc "Save workspace to file"    "s"   #'+workspace/save
;;         :desc "Delete session"            "x"   #'+workspace/kill-session
;;         :desc "Delete this workspace"     "d"   #'+workspace/delete
;;         :desc "Rename workspace"          "r"   #'+workspace/rename
;;         :desc "Restore last session"      "R"   #'+workspace/restore-last-session
;;         :desc "Next workspace"            "]"   #'+workspace/switch-right
;;         :desc "Previous workspace"        "["   #'+workspace/switch-left
;;         :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
;;         :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
;;         :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
;;         :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
;;         :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
;;         :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
;;         :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
;;         :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
;;         :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
;;         :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final))
;;       )

(after! cider
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (set-popup-rule! "^\\*cider*" :size 0.45 :side 'right :select t :quit nil)
  ;; (setq clojure-indent-style 'align-arguments)
  ;; (setq clojure-align-forms-automatically nil)
  )


(set-popup-rule! "^\\*help*" :size 0.4 :side 'bottom :select t :quit t)
(set-popup-rule! "^\\*info*" :size 0.7 :side 'bottom :select t :quit t)
(set-popup-rule! "^\\*SQL*" :size 0.5 :side 'right :select nil :quit nil)
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


(define-key evil-normal-state-map "x" 'delete-forward-char)     ; delete to the black hole
(define-key evil-normal-state-map "X" 'delete-backward-char)

(setq
 projectile-project-search-path '("~/projects"))


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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#FFFBEA" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#556b72"])
 '(custom-safe-themes
   (quote
    ("0cb1b0ea66b145ad9b9e34c850ea8e842c4c4c83abe04e37455a1ef4cc5b8791" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" default)))
 '(fci-rule-color "#D6D6D6")
 '(jdee-db-active-breakpoint-face-colors (cons "#FFFBF0" "#268bd2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#FFFBF0" "#859900"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#FFFBF0" "#E1DBCD"))
 '(objed-cursor-color "#dc322f")
 '(pdf-view-midnight-colors (cons "#556b72" "#FDF6E3"))
 '(rustic-ansi-faces
   ["#FDF6E3" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#556b72"])
 '(vc-annotate-background "#FDF6E3")
 '(vc-annotate-color-map
   (list
    (cons 20 "#859900")
    (cons 40 "#959300")
    (cons 60 "#a58e00")
    (cons 80 "#b58900")
    (cons 100 "#bc7407")
    (cons 120 "#c35f0e")
    (cons 140 "#cb4b16")
    (cons 160 "#cd4439")
    (cons 180 "#d03d5d")
    (cons 200 "#d33682")
    (cons 220 "#d63466")
    (cons 240 "#d9334a")
    (cons 260 "#dc322f")
    (cons 280 "#dd5c56")
    (cons 300 "#de867e")
    (cons 320 "#dfb0a5")
    (cons 340 "#D6D6D6")
    (cons 360 "#D6D6D6")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(message "Hello World")
(column-number-mode)
(visual-line-mode)
(global-hl-line-mode)
(find-file "~/todo.org")
