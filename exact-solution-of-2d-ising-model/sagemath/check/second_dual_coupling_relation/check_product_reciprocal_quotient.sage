load('_prelude.sage')
check_pair(lambda k: sinh(k) * cosh(k) * ((1 / (sinh(k) / cosh(k))) - (sinh(k) / cosh(k))),
           lambda k: sinh(k) * cosh(k) * ((cosh(k) / sinh(k)) - (sinh(k) / cosh(k))),
           'invert the nonzero quotient')
