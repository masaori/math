# 対象ラベル: complex_times_negation_is_negation_of_product_in_cc
# 証明の五行の鎖の六つの項:
#   z(-w) = z((-1_C)w) = (z(-1_C))w = ((-1_C)z)w = (-1_C)(zw) = -(zw)
# ℂ を実数の対として持ち（definition_of_cc）、対の積は definition_of_cc の式で作る。r_C := (r, 0)（inclusion_rr_to_cc）。
# 符号反転は multiply_by_minus_one の定義どおり (-1_C) との積として組む。
# z = (a, b), w = (c, d) の成分は QQ 上の多項式環の不定元（任意の実数を代入しても等号は保たれる）。
# 帰属: 成分はすべて QQ[a, b, c, d] の元。浮動小数点と RR / CC への脱出はない。
P.<a, b, c, d> = PolynomialRing(QQ)

def incl(r):
    return (P(r), P(0))

def pair_add(z, w):
    return (z[0] + w[0], z[1] + w[1])

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

minus_one_C = incl(-1)
one_C = incl(1)
zero_C = incl(0)

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return pair_mul(minus_one_C, z)

z = (a, b); w = (c, d)
chain = [
    pair_mul(z, neg(w)),                                  # z(-w)
    pair_mul(z, pair_mul(minus_one_C, w)),                # z((-1_C)w)        multiply_by_minus_one (z -> w)
    pair_mul(pair_mul(z, minus_one_C), w),                # (z(-1_C))w        積の結合律を右辺から左辺へ
    pair_mul(pair_mul(minus_one_C, z), w),                # ((-1_C)z)w        積の可換律
    pair_mul(minus_one_C, pair_mul(z, w)),                # (-1_C)(zw)        積の結合律
    neg(pair_mul(z, w)),                                  # -(zw)             multiply_by_minus_one (z -> zw) を右辺から左辺へ
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: 符号を落とした zw とは一致しない
assert chain[0] != pair_mul(z, w)
print("checked the chain of 6 terms over QQ[a, b, c, d] pairs")
print("RESULT: PASS")
