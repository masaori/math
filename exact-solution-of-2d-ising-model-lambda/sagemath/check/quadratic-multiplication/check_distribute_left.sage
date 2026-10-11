# 対象ラベル: claim_quadratic_multiplication_mem
# 本文の行: 左因子の分配
# 式ペア: (A + B * s) * (Ap + Bp * s) = A * (Ap + Bp * s) + (B * s) * (Ap + Bp * s)
# 帰属: a,b,ap,bp は QQ、A,B,Ap,Bp,s,xi,eta は QQbar。
if 'multiplication_cases' not in globals():
    load('sagemath/check/quadratic-multiplication/_prelude.sage')

checked = 0
for a, b, ap, bp, s, xi, eta, A, B, Ap, Bp in multiplication_cases():
    lhs = (A + B * s) * (Ap + Bp * s)
    rhs = A * (Ap + Bp * s) + (B * s) * (Ap + Bp * s)
    assert lhs == rhs, (a, b, ap, bp, s, lhs, rhs)
    checked += 1
assert checked == 4802
print('RESULT: PASS (左因子の分配: %s 等式)' % checked)
