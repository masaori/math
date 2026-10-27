# 対象ラベル: claim_same_direction_dual_inner_orthogonality
# 二つの根の有限等比和による場合分け。
load('sagemath/check/same-direction-dual-inner-orthogonality/_prelude.sage')
for L, delta, varpi, varsigma, vp, sp in cases():
    r, t = vp / varpi, sp / varsigma
    assert r**L == 1 and t**L == 1
    horizontal_sum = sum(r**j for j in range(L))
    vertical_sum = sum(t**i for i in range(L))
    assert horizontal_sum == (QQbar(L) if vp == varpi else QQbar(0))
    assert vertical_sum == (QQbar(L) if sp == varsigma else QQbar(0))
    assert horizontal_sum * vertical_sum == (
        QQbar(L**2) if (vp, sp) == (varpi, varsigma) else QQbar(0))
print('PASS: same-direction orthogonality')
