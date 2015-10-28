(require 'package)

;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; 初期化
(package-initialize)

; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------------------------------------------------
;; @ load-path

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")
;; ------------------------------------------------------------------------
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
 
;; 半角と全角の比を1:2に
;; (setq face-font-rescale-alist
;;       '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;カーソル設定
(setq-default cursor-type '(bar . 2))
;;(set-cursor-color 'controlLightHighlightColor)

;; ツールバー非表示
(tool-bar-mode 0)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;; C-hをバックスペースへ
(keyboard-translate ?\C-h ?\C-?)
;; ¥ to \
(global-set-key [?¥] [?\\])

(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(global-set-key (kbd "C-t") 'other-window)

;;(column-number-mode t)

(setq frame-title-format "%b : %f")

;; 行番号の表示
;;(global-linum-mode t)

;;(global-set-key (kbd "C-x C-c") nil)

(global-set-key (kbd "C-z") 'undo)

(setq visible-bell t)
(setq ring-bell-function 'ignore) 

(add-hook 'dired-mode-hook
  (lambda ()
    (define-key dired-mode-map (kbd "q") 'dired-up-directory)
    (local-unset-key (kbd "C-t"))
    ))

(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?d)
               (enlarge-window-horizontally dx))
              ((= c ?a)
               (shrink-window-horizontally dx))
              ((= c ?s)
               (enlarge-window dy))
              ((= c ?w)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))


(global-set-key "\C-c\C-r" 'window-resizer)

;;通常のウィンドウ用の設定
(setq-default truncate-lines t)
(put 'dired-find-alternate-file 'disabled nil)


(setq-default tab-width 4 indent-tabs-mode nil)


(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'load-path "~/projects/dotfiles/.emacs.d/public_repos/jshint-mode")
(require 'flymake-jshint)
(add-hook 'js2-mode-hook
     (lambda () (flymake-mode t)))

(require 'darcula-theme)


(cua-mode t)
(setq cua-enable-cua-keys nil)



;; ctags.elの設定
(require 'ctags nil t)
(setq tags-revert-without-query t)
;; ctagsを呼び出すコマンドライン。パスが通っていればフルパスでなくてもよい
;; etags互換タグを利用する場合はコメントを外す
(setq ctags-command "ctags -e -R ")
;; anything-exuberant-ctags.elを利用しない場合はコメントアウトする
;;(setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
;; (require 'yasnippet)
;; (yas-global-mode 1)
(add-to-list 'load-path
              "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)


;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will

;;(ac-set-trigger-key "TAB")
;;(ac-set-trigger-key "<tab>")
(setq ac-auto-start nil)
;;(ac-set-trigger-key "TAB")  ; TABで補完開始(トリガーキー)
;; or
(define-key ac-mode-map [C-tab] 'auto-complete)  ; M-TABで補完開始

(if (not (eq system-type 'windows-nt))
    (exec-path-from-shell-initialize))

(require 'smartparens-config)
(smartparens-global-mode t)

(global-anzu-mode +1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(tab-width 2))


(global-set-key "\C-c\C-t" 'other-frame)

(menu-bar-mode 0)

(require 'cl-lib) ;; emacs 24.3 標準で付属
(defun my-dired-sqlite ()
  (interactive)
  (let ((file (dired-get-filename))
        (buffer (format "SQLite%s" (cl-gensym))))
    (async-shell-command (format "sqlite3 '%s'" file) buffer)
    (switch-to-buffer buffer)
    (insert ".header on")
    (execute-kbd-macro (kbd "RET"))
    (insert ".mode column")
    (execute-kbd-macro (kbd "RET"))
    (insert ".tables")
    (execute-kbd-macro (kbd "RET"))))

;;haskell-mode
;; (setq haskell-program-name "/usr/bin/ghci")
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-to-list 'load-path "~/.emacs.d/elisp/haskell-mode-2.8.0")

(require 'haskell-mode)
(require 'haskell-cabal)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

;; https://github.com/m2ym/auto-complete
(ac-define-source ghc-mod
  '((depends ghc)
    (candidates . (ghc-select-completion-symbol))
    (symbol . "s")
    (cache)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

(add-hook 'find-file-hook 'my-haskell-ac-init)

(defadvice haskell-indent-indentation-info (after haskell-indent-reverse-indentation-info)
  (when (>= (length ad-return-value) 2)
    (let ((second (nth 1 ad-return-value)))
      (setq ad-return-value (cons second (delete second ad-return-value))))))

(ad-activate 'haskell-indent-indentation-info)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;;-------------------------------------------------------------------------
;; (when (member "DejaVu Sans Mono" (font-family-list))
;;   (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(set-default-font "Inconsolata-12")
(set-face-font 'variable-pitch "Inconsolata-12")
(set-fontset-font (frame-parameter nil 'font)
                'japanese-jisx0208
                '(".*Hiragino_Mincho_pro.*" . "unicode-bmp")
)

(setq line-spacing 0.3)

(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
;; (global-set-key (kbd "C-c C-T") 'swap-screen)
(global-set-key (kbd "C-c C-T") 'swap-screen-with-cursor)

;; If use bundled typescript.el,
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tss)

;; Key binding
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")
(setq tss-implement-definition-key "C-c i")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "tss")

;; Do setting recommemded configuration
(tss-config-default)

(defun reopen-with-sudo ()
  "Reopen current buffer-file with sudo using tramp."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "Cannot get a file name"))))

(column-number-mode t)


(global-set-key "\C-c\C-l" 'goto-line)

(setq create-lockfiles nil)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-to-list 'load-path "public_repos/helm/")

(require 'helm-config)
(helm-mode 1)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-c C-f") 'helm-find)
