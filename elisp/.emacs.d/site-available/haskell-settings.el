;; Haskell mode setting, include auto load and 
;; unicode char beutiful

(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode")
(load "haskell-site-file")

(defun unicode-symbol (name)
   "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW                                      
 or GREATER-THAN into an actual Unicode character code. "
   (decode-char 'ucs (case name                                             
                       ('left-arrow #X2190)
                       ('up-arrow #X2191)
                       ('right-arrow #X2192)
                       ('down-arrow #X2193)
                       ('right-double-arrow #X21D2)
                       ('left-arrow-tail #X2919)
                       ('right-arrow-tail #X291A)
                       ('left-double-arrow-tail #X291B)
                       ('right-double-arrow-tail #X291C)
                       ('black-star #X2605)
                       ('choice-operator #X2194)
                       ('monad-bind #X21C9)
                       ('monad-then 187)
                       ('proportion #X2237)
                       ('rightwards-double-arrow #X21D2)
                       ('for-all #X2200)
                       ('double-vertical-bar #X2551)                  
                       ('equal #X003d)
                       ('not-equal #X2260)
                       ('identical #X2261)
                       ('not-identical #X2262)
                       ('less-than #X003c)
                       ('greater-than #X003e)
                       ('less-than-or-equal-to #X2264)
                       ('greater-than-or-equal-to #X2265)
                       ('logical-and #X2227)
                       ('logical-or #X2228)
                       ('logical-neg #X00AC)
                       ('phi #X2205)
                       ('horizontal-ellipsis #X2026)
                       ('double-exclamation #X203C)
                       ('prime #X2032)
                       ('double-prime #X2033)
                       ('for-all #X2200)
                       ('there-exists #X2203)
                       ('element-of #X2208)              
                       ('square-root #X221A)
                       ('squared #X00B2)
                       ('cubed #X00B3)
                       ('lambda #X03BB)
                       ('alpha #X03B1)
                       ('beta #X03B2)
                       ('gamma #X03B3)
                       ('delta #X03B4))))

(defun substitute-pattern-with-unicode (pattern symbol)
    "Add a font lock hook to replace the matched part of PATTERN with the                                       
     Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
    (interactive)
    (font-lock-add-keywords
     nil `((,pattern 
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     ,(unicode-symbol symbol)
                                     'decompose-region)
                             nil))))))

(defun substitute-patterns-with-unicode (patterns)
   "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
   (mapcar #'(lambda (x)
               (substitute-pattern-with-unicode (car x)
                                                (cdr x)))
           patterns))

(defun haskell-unicode ()
 (interactive)
 (substitute-patterns-with-unicode
  (list (cons "\\(<-\\)" 'left-arrow)
        (cons "\\(->\\)" 'right-arrow)
        (cons "\\(<|>\\)" 'choice-operator)
        (cons "\\(::\\)" 'proportion)
        (cons "\\(=>\\)" 'right-double-arrow)
        (cons "\\(forall\\)" 'for-all)
        (cons "\\(-<\\)" 'left-arrow-tail)
        (cons "\\(>-\\)" 'right-arrow-tail)
        (cons "\\(-<<\\)" 'left-double-arrow-tail)
        (cons "\\(>>-\\)" 'right-double-arrow-tail)
        (cons "\\(>>=\\)" 'monad-bind)
        (cons "\\(>>\\)" 'monad-then)
        (cons "\\(==\\)" 'identical)
        (cons "\\(/=\\)" 'not-identical)
        (cons "\\(()\\)" 'phi)
        (cons "\\<\\(sqrt\\)\\>" 'square-root)
        (cons "\\(&&\\)" 'logical-and)
        (cons "\\(||\\)" 'logical-or)
        (cons "\\<\\(not\\)\\>" 'logical-neg)
        (cons "\\(>\\)\\[^=\\]" 'greater-than)
        (cons "\\(<\\)\\[^=\\]" 'less-than)
        (cons "\\(>=\\)" 'greater-than-or-equal-to)
        (cons "\\(<=\\)" 'less-than-or-equal-to)
        (cons "\\<\\(alpha\\)\\>" 'alpha)
        (cons "\\<\\(beta\\)\\>" 'beta)
        (cons "\\<\\(gamma\\)\\>" 'gamma)
        (cons "\\<\\(delta\\)\\>" 'delta)
        (cons "\\(''\\)" 'double-prime)
        (cons "\\('\\)" 'prime)
        (cons "\\(!!\\)" 'double-exclamation)
        (cons "\\(\\.\\.\\)" 'horizontal-ellipsis)
        (cons " \\(*\\) " 'black-star))))

(load-library "haskell-ghci")
(add-hook 'haskell-mode-hook 
          (lambda () 
            (turn-on-haskell-ghci)
            (turn-on-haskell-decl-scan)
            (turn-on-haskell-doc-mode)
            (turn-on-haskell-indent)
            (turn-on-haskell-simple-indent)
            (haskell-unicode)
            ))
