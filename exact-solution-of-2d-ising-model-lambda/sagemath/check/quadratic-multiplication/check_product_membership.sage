# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: Q_s の定義の有理係数二つを証人とする積の所属。
# 帰属: 証人 c,d は QQ、その像と xi * eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    c = a * ap + 2 * (b * bp)
    d = a * bp + b * ap
    assert c.parent() is QQ and d.parent() is QQ
    assert xi * eta == j(c) + j(d) * s, (a, b, ap, bp, s)
    checked += 1
assert checked == 4802
print('RESULT: PASS (有理係数を証人とする積の所属: %s 所属)' % checked)
