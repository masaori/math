# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 平方根積の補助式の代入
# 式ペア: (A * Ap + (A * Bp) * s) + ((B * Ap) * s + (B * s) * (Bp * s)) = (A * Ap + (A * Bp) * s) + ((B * Ap) * s + j(2) * (B * Bp))
# 帰属: a,b,ap,bp は QQ、A,B,Ap,Bp,s,xi,eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    lhs = (A * Ap + (A * Bp) * s) + ((B * Ap) * s + (B * s) * (Bp * s))
    rhs = (A * Ap + (A * Bp) * s) + ((B * Ap) * s + j(2) * (B * Bp))
    assert lhs == rhs, (a, b, ap, bp, s, lhs, rhs)
    checked += 1
assert checked == 4802
print('RESULT: PASS (平方根積の補助式の代入: %s 等式)' % checked)
