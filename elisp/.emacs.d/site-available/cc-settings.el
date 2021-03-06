(defconst my-c-style 
  '((c-tab-always-indent        . t) 
    (c-comment-only-line-offset . 0) 
    (c-hanging-braces-alist     . ((substatement-open after) 
                                   (brace-list-open))) 
    (c-hanging-colons-alist     . ((member-init-intro before) 
                                   (inher-intro) 
                                   (case-label after) 
                                   (label after) 
                                   (access-label after))) 
    (c-cleanup-list             . (scope-operator 
                                   empty-defun-braces 
                                   defun-close-semi)) 
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist) 
                                   (substatement-open . 0) 
                                   (cpp-macro . 0) 
                                   (case-label        . 4) 
                                   (block-open        . 0) 
                                   (knr-argdecl-intro . -))) 
    (c-echo-syntactic-information-p . t)) "My C Programming Style") 

;; offset customizations not in my-c-style 
(setq c-offsets-alist '((member-init-intro . ++))) 

;; Customizations for all modes in CC Mode. 
(defun my-c-mode-common-hook () 
  ;; add my personal style and set it for the current buffer 
  ;; (c-add-style "PERSONAL" my-c-style t) 
  (c-set-style "whitesmith")
  ;; other customizations 
  (setq tab-width 4
		c-basic-offset 4)
  ;; this will make sure spaces are used instead of tabs 
  (indent-tabs-mode nil) 
  ;; we like auto-newline and hungry-delete 
  (c-toggle-auto-hungry-state 1) 
  ;; key bindings for all supported languages.  We can put these in 
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map, 
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it. 
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)) 

(add-hook 'cc-mode-common-hook 'my-c-mode-common-hook) 
