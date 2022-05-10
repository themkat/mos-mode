;;; lsp-mos.el --- mos toolkit usage in Emacs
;; Version: 0.0.1

(require 'lsp-mode)
(require 'dap-mode)
(require 'dash)

(defcustom lsp-mos-executable-path (executable-find "mos")
  "Path to the mos executable"
  :group 'lsp-mos
  :type 'string)

;; simple major mode based on assembly mode that can be activated
(define-derived-mode mos-mode
  asm-mode "MOS mode"
  "Major mode for use with the MOS toolkit for 6502 processors")

(add-to-list 'lsp-language-id-configuration '(mos-mode . "mos"))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection (lambda () (list lsp-mos-executable-path "lsp")))
  :activation-fn (lsp-activate-on "mos")
  :major-modes '(mos-mode)
  :priority -1
  :server-id 'mos-ls))

;; TODO: possibility to download mos automatically if not found?

(defun lsp-mos-populate-debug-args (conf)
  (-> conf
      (dap--put-if-absent :type "mos")
      (dap--put-if-absent :request "launch")
      (dap--put-if-absent :workspace (lsp-workspace-root))
      (dap--put-if-absent :port 6503)))

(dap-register-debug-provider "mos" #'lsp-mos-populate-debug-args)

;; todo: dry!
(defun mos-build ()
  (interactive)
  (let ((default-directory (locate-dominating-file default-directory "mos.toml")))
    (compile (string-join (list lsp-mos-executable-path " build")))))

(defun mos-run-all-tests ()
  (interactive)
  (let ((default-directory (locate-dominating-file default-directory "mos.toml")))
    (compile (string-join (list lsp-mos-executable-path " test")))))


;; TODO: run/debug single test at point? when we hover the name?

(provide 'lsp-mos)
;;; lsp-mos.el ends here
