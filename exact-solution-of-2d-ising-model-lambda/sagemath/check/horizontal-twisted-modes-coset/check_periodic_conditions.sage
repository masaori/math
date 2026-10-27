# 対象ラベル: claim_horizontal_twisted_modes_coset
# U_0 と μ_L の元の条件を照合する。
for L in range(1, 7):
    roots = [QQbar.zeta(2 * L)^k for k in range(2 * L)]
    assert {z for z in roots if z^L == 1} == {QQbar.zeta(L)^k for k in range(L)}
print('RESULT: PASS')
