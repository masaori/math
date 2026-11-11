# 対象ラベル: i_times_inverse_of_two_i_is_inverse_of_two_in_cc
# 主張の前置き（2_C, i, 2_C i ∈ ℂ^×）と証明の鎖（6 行）を一行ずつ確かめる:
#   i(2_C i)^{-1} = 1_C(i(2_C i)^{-1}) = (2_C^{-1}2_C)(i(2_C i)^{-1}) = … = 2_C^{-1}
#   逆元は multiplicative_group_of_cc の証明の逆元の式 w^{-1} := (x/(x^2+y^2), -y/(x^2+y^2))。2_C = (2,0)、i = (0,1) なので成分は QQ。
# ℂ を実数の対として持ち（definition_of_cc）、積は definition_of_cc の式、r_C := (r, 0)（inclusion_rr_to_cc）を、それぞれ書いた関数で作る。
# 帰属: 成分は QQ の元。ℝ への脱出はない。

R = QQ

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (R(r), R(0))

def mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

one = incl(1)          # 1_C
two = incl(2)          # 2_C
zero = incl(0)         # 0_C

def inv(z):
    """multiplicative_group_of_cc の証明の逆元の式: (x, y)^{-1} := (x/(x^2+y^2), -y/(x^2+y^2))（z ≠ 0_C）。"""
    n = z[0] ** 2 + z[1] ** 2
    assert n != 0
    return (z[0] / n, -z[1] / n)

iC = (R(0), R(1))      # i = (0, 1)
assert two != zero and iC != zero and mul(two, iC) != zero   # 主張の前置き: 2_C, i, 2_C i ∈ ℂ^×
assert mul(inv(two), two) == one and mul(mul(two, iC), inv(mul(two, iC))) == one
chain = [
    mul(iC, inv(mul(two, iC))),                                   # i (2_C i)^{-1}
    mul(one, mul(iC, inv(mul(two, iC)))),                         # 積の単位元（右辺から左辺へ）
    mul(mul(inv(two), two), mul(iC, inv(mul(two, iC)))),          # 逆元（2_C）を右辺から左辺へ
    mul(inv(two), mul(two, mul(iC, inv(mul(two, iC))))),          # 積の結合律
    mul(inv(two), mul(mul(two, iC), inv(mul(two, iC)))),          # 積の結合律を右辺から左辺へ
    mul(inv(two), one),                                           # 逆元（2_C i）
    inv(two),                                                     # 積の単位元
]
assert len(chain) == 7
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], ("chain", k)
print(f"  証明の鎖: {len(chain)} 項（6 等号）が QQ の対で一致する（2_C^{{-1}} = {inv(two)}）")
# 対照: 2 行目で 2_C^{-1} 2_C を 2_C に替えると鎖が切れる
assert mul(two, mul(iC, inv(mul(two, iC)))) != chain[1]
print("  対照: 証明の鎖の 2 行目で 2_C^{-1}2_C を 2_C に替えると等号が成り立たない")
print("RESULT: PASS")
