load('_prelude.sage')
check_pair(lambda k: sinh(k) * cosh(k) * ((cosh(k) / sinh(k)) - (sinh(k) / cosh(k))),
           lambda k: sinh(k) * cosh(k) * ((cosh(k)^2 - sinh(k)^2) / (sinh(k) * cosh(k))),
           'put the fractions over a common denominator')
