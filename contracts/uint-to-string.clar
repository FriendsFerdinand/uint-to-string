;; convert uint to string

(define-constant FOLDS_39 (list 
    true true true true true true true true true true true true true
    true true true true true true true true true true true true true
    true true true true true true true true true true true true true
))

(define-constant NUM_TO_CHAR (list
    u"0" u"1" u"2" u"3" u"4" u"5" u"6" u"7" u"8" u"9"
))

(define-private (concat-uint (ignore bool) (input { dec: uint, data: (string-utf8 39) }))
    (let (
            (last-val (get dec input))
        )
        (if (is-eq last-val u0)
            {
                dec: last-val,
                data: (get data input)
            }
            (if (< last-val u10)
                {
                    dec: u0,
                    data: (concat-num-to-string last-val (get data input))
                }
                {
                    dec: (/ last-val u10),
                    data: (concat-num-to-string (mod last-val u10) (get data input))
                }
            )
        )
    )
)

(define-private (concat-num-to-string (num uint) (right (string-utf8 39)))
    (unwrap-panic (as-max-len? (concat (unwrap-panic (element-at NUM_TO_CHAR num)) right) u39))
)

(define-read-only (uint-to-string (num uint))
    (if (is-eq num u0)
        (unwrap-panic (as-max-len? u"0" u39))
        (get data (fold concat-uint FOLDS_39 { dec: num, data: u""}))
    )
)
