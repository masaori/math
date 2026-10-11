# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 四つの係数積の包含保存
# 式ペア: (A * Ap + j(2) * (B * Bp)) + (A * Bp + B * Ap) * s = (j(a * ap) + j(2) * j(b * bp)) + (j(a * bp) + j(b * ap)) * s
# 帰属: a,b,ap,bp は QQ、A,B,Ap,Bp,s,xi,eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    lhs = (A * Ap + j(2) * (B * Bp)) + (A * Bp + B * Ap) * s
    rhs = (j(a * ap) + j(2) * j(b * bp)) + (j(a * bp) + j(b * ap)) * s
    assert lhs == rhs, (a, b, ap, bp, s, lhs, rhs)
    checked += 1
assert checked == 4802
print('RESULT: PASS (四つの係数積の包含保存: %s 等式)' % checked)
