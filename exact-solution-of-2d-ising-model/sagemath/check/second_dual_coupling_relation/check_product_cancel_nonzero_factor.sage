load('_prelude.sage')
check_pair(lambda k: sinh(k) * cosh(k) * ((cosh(k)^2 - sinh(k)^2) / (sinh(k) * cosh(k))),
           lambda k: cosh(k)^2 - sinh(k)^2,
           'cancel the nonzero sinh-cosh product')
