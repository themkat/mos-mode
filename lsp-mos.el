;;; lsp-mos.el --- mos toolkit usage in Emacs
;; Version: 0.0.1

(require 'lsp-mode)
(require 'dap-mode)
(require 'dash)

(defcustom lsp-mos-executable-path "setme"
  "Path to the mos executable"
  :group 'lsp-mos
  :type 'string)

;; simple major mode based on assembly mode that can be activated
(define-derived-mode mos-mode
  asm-mode "MOS mode"
  "Major mode for use with the MOS toolkit for 6502 processors")

(add-to-list 'lsp-language-id-configuration '(mos-mode . "mos"))

;; wtf.. server not present on path.. I give you the whole thing :rofl: any way we can just do that for now? 
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection (lambda () (list lsp-mos-executable-path "lsp")))
  :activation-fn (lsp-activate-on "mos")
  :major-modes '(mos-mode)
  :priority -1
  :server-id 'mos-ls))

;; TODO: debug config. is the defaultattach types here?
;; seems like the default one is 6503
(defun lsp-mos-populate-debug-args (conf)
  (-> conf
      (dap--put-if-absent :type "mos")
      (dap--put-if-absent :request "launch")
      (dap--put-if-absent :workspace (lsp-workspace-root))
      (dap--put-if-absent :port 6503)))

(dap-register-debug-provider "mos" #'lsp-mos-populate-debug-args)

;; todo: when running compile mode stuff. Just locate the folder with a mos.toml?
;; (defun mos-build ()
;;   (interactive)
;;   ())

;; TODO: possibility to download mos automatically if not found?

;; TODO: build project using simple shell task. Just compile mode? 

;; TODO: run/debug single test at point? when we hover the name?

(provide 'lsp-mos)
;;; lsp-mos.el ends here
