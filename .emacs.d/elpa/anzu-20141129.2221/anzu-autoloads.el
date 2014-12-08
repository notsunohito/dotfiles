;;; anzu-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (anzu-replace-at-cursor-thing anzu-query-replace-regexp
;;;;;;  anzu-query-replace anzu-query-replace-at-cursor-thing anzu-query-replace-at-cursor
;;;;;;  global-anzu-mode anzu-mode) "anzu" "../../../../../.emacs.d/elpa/anzu-20141129.2221/anzu.el"
;;;;;;  "cd47007173f8a8fe4c468d2aa910c142")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/anzu-20141129.2221/anzu.el

(autoload 'anzu-mode "anzu" "\
minor-mode which display search information in mode-line.

\(fn &optional ARG)" t nil)

(defvar global-anzu-mode nil "\
Non-nil if Global-Anzu mode is enabled.
See the command `global-anzu-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-anzu-mode'.")

(custom-autoload 'global-anzu-mode "anzu" nil)

(autoload 'global-anzu-mode "anzu" "\
Toggle Anzu mode in all buffers.
With prefix ARG, enable Global-Anzu mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Anzu mode is enabled in all buffers where
`anzu--turn-on' would do it.
See `anzu-mode' for more information on Anzu mode.

\(fn &optional ARG)" t nil)

(autoload 'anzu-query-replace-at-cursor "anzu" "\


\(fn)" t nil)

(autoload 'anzu-query-replace-at-cursor-thing "anzu" "\


\(fn)" t nil)

(autoload 'anzu-query-replace "anzu" "\


\(fn ARG)" t nil)

(autoload 'anzu-query-replace-regexp "anzu" "\


\(fn ARG)" t nil)

(autoload 'anzu-replace-at-cursor-thing "anzu" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/anzu-20141129.2221/anzu-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/anzu-20141129.2221/anzu.el")
;;;;;;  (21637 39311 238000 0))

;;;***

(provide 'anzu-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; anzu-autoloads.el ends here
