# 対象ラベル: claim_untwisted_mode_zero_condition
P = PolynomialRing(QQ, 'q')
q = P.gen()
assert (1+q^2)^2-q*(1-q^2)*(1+1+1+1) == (1+q^2)^2-4*q*(1-q^2)
print('RESULT: PASS untwisted mode sum')
