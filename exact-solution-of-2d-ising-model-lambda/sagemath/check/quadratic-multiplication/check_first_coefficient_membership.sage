# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 定数係数の有理数への所属
# 所属: a * ap + 2 * (b * bp) in QQ。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    coefficient = a * ap + 2 * (b * bp)
    assert coefficient.parent() is QQ, (a, b, ap, bp, coefficient)
    checked += 1
assert checked == 4802
print('RESULT: PASS (定数係数の有理数への所属: %s 所属)' % checked)
