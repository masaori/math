# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 外側の和の結合解除
# 式ペア: (A * Ap + (A * Bp) * s) + (j(2) * (B * Bp) + (B * Ap) * s) = A * Ap + ((A * Bp) * s + (j(2) * (B * Bp) + (B * Ap) * s))
# 帰属: a,b,ap,bp は QQ、A,B,Ap,Bp,s,xi,eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    lhs = (A * Ap + (A * Bp) * s) + (j(2) * (B * Bp) + (B * Ap) * s)
    rhs = A * Ap + ((A * Bp) * s + (j(2) * (B * Bp) + (B * Ap) * s))
    assert lhs == rhs, (a, b, ap, bp, s, lhs, rhs)
    checked += 1
assert checked == 4802
print('RESULT: PASS (外側の和の結合解除: %s 等式)' % checked)
