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
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

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

(column-number-mode t)

(setq frame-title-format "%b : %f")

;; 行番号の表示
;;(global-linum-mode t)

;;(global-set-key (kbd "C-x C-c") nil)

(global-set-key (kbd "C-z") nil)

(setq visible-bell t)
(setq ring-bell-function 'ignore) 
