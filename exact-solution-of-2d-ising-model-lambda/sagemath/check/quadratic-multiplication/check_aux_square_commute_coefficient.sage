# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 補助式: 二の像の移動
# 式ペア: (B * Bp) * j(2) = j(2) * (B * Bp)
# 帰属: a,b,ap,bp は QQ、A,B,Ap,Bp,s,xi,eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    lhs = (B * Bp) * j(2)
    rhs = j(2) * (B * Bp)
    assert lhs == rhs, (a, b, ap, bp, s, lhs, rhs)
    checked += 1
assert checked == 4802
print('RESULT: PASS (補助式: 二の像の移動: %s 等式)' % checked)
