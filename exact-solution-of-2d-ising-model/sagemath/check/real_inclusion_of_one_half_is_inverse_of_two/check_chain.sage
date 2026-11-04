# 対象ラベル: real_inclusion_of_one_half_is_inverse_of_two
# 証明の七つの等号（八つの項）:
#   (1/2)_C = (1/2)_C 1_C = (1/2)_C (2_C 2_C^{-1}) = ((1/2)_C 2_C) 2_C^{-1} = (1/2·2)_C 2_C^{-1}
#           = (1)_C 2_C^{-1} = 1_C 2_C^{-1} = 2_C^{-1}
# ℂ を実数の対として持ち（definition_of_cc の積 (x,y)(u,v) = (xu - yv, xv + yu)）、成分は QQ で厳密に計算する。
# 2_C^{-1} は「2_C w = 1_C を満たす w」として、対の一次方程式を QQ で解いて作る（逆元の値を先に置かない独立な経路）。
def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (QQ(r), QQ(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

one = (QQ(1), QQ(0))
two = incl(2)
assert two != (QQ(0), QQ(0))                      # 2_C ≠ 0_C
# 2_C^{-1}: 2_C (u, v) = (1, 0) を QQ で解く
u, v = var('u v')
lhs = pair_mul((SR(two[0]), SR(two[1])), (u, v))   # definition_of_cc の積の式から方程式を作る
sol = solve([lhs[0] == 1, lhs[1] == 0], u, v, solution_dict=True)
assert len(sol) == 1
inv_two = (QQ(sol[0][u]), QQ(sol[0][v]))
assert pair_mul(two, inv_two) == one
half = incl(QQ(1) / 2)
chain = [half,
         pair_mul(half, one),
         pair_mul(half, pair_mul(two, inv_two)),
         pair_mul(pair_mul(half, two), inv_two),
         pair_mul(incl(QQ(1) / 2 * 2), inv_two),
         pair_mul(incl(1), inv_two),
         pair_mul(one, inv_two),
         inv_two]
n_eq = 0
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
    n_eq += 1
# 対照: (1/3)_C は 2_C^{-1} でなく、2_C (1/2, 1) は 1_C でない
assert incl(QQ(1) / 3) != inv_two
assert pair_mul(two, (QQ(1) / 2, QQ(1))) != one
print(f"checked the chain of 8 terms over QQ pairs (equalities {n_eq}, negative controls 2)")
print("RESULT: PASS")
