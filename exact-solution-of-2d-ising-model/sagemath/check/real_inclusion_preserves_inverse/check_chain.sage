# 対象ラベル: real_inclusion_preserves_inverse
# 準備 r_C ∈ C^× と、証明の七つの等号（八つの項）の鎖:
#   (r^{-1})_C = (r^{-1})_C 1_C = (r^{-1})_C (r_C (r_C)^{-1}) = ((r^{-1})_C r_C)(r_C)^{-1} = (r^{-1} r)_C (r_C)^{-1}
#              = (1)_C (r_C)^{-1} = 1_C (r_C)^{-1} = (r_C)^{-1}
# ℂ を実数の対として持ち（definition_of_cc の積 (x,y)(u,v) = (xu - yv, xv + yu)）、成分は QQ で厳密に計算する。
# (r_C)^{-1} は「r_C w = 1_C を満たす w」として、対の一次方程式を QQ で解いて作る（逆元の値を先に置かない独立な経路）。
def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (QQ(r), QQ(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

one = (QQ(1), QQ(0))
u, v = var('u v')
n_eq = 0
n_r = 0
for r in [QQ(2), QQ(-3), QQ(1)/7, QQ(-5)/4, QQ(11)/3, QQ(1), QQ(-1)]:
    rC = incl(r)
    assert rC != (QQ(0), QQ(0))                       # 準備: r ≠ 0 なら r_C ≠ 0_C
    lhs = pair_mul((SR(rC[0]), SR(rC[1])), (u, v))     # definition_of_cc の積の式から方程式を作る
    sol = solve([lhs[0] == 1, lhs[1] == 0], u, v, solution_dict=True)
    assert len(sol) == 1
    inv_rC = (QQ(sol[0][u]), QQ(sol[0][v]))
    assert pair_mul(rC, inv_rC) == one
    rinv = incl(r**-1)
    chain = [rinv,
             pair_mul(rinv, one),
             pair_mul(rinv, pair_mul(rC, inv_rC)),
             pair_mul(pair_mul(rinv, rC), inv_rC),
             pair_mul(incl(r**-1 * r), inv_rC),
             pair_mul(incl(1), inv_rC),
             pair_mul(one, inv_rC),
             inv_rC]
    for k in range(len(chain) - 1):
        assert chain[k] == chain[k + 1], (r, k)
        n_eq += 1
    # 対照: (r^{-1})_C は (-r)_C の逆元ではない（r ≠ 0 なので r^{-1} ≠ -r^{-1}）
    assert pair_mul(rinv, incl(-r)) != one
    n_r += 1
# 対照: r = 0 なら r_C = 0_C で、準備が成り立たない
assert incl(0) == (QQ(0), QQ(0))
print(f"checked {n_r} values of r over QQ pairs (equalities {n_eq}, negative controls {n_r + 1})")
print("RESULT: PASS")
