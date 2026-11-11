# 対象ラベル: double_negation_in_cc
# 証明の五行の鎖の六つの項:
#   -(-z) = (-1_C)(-z) = (-1_C)((-1_C)z) = ((-1_C)(-1_C))z = 1_C z = z
# ℂ を実数の対として持ち（definition_of_cc）、対の積は definition_of_cc の式
# (x,y)(u,v) = (xu - yv, xv + yu) を書いた関数で作る。r_C := (r, 0)（inclusion_rr_to_cc）。
# 符号反転は multiply_by_minus_one の定義どおり (-1_C) との積として組む。
# z の成分は QQ 上の多項式環の不定元 x, y に置く（任意の実数を代入しても等号は保たれる）。
# 帰属: 成分はすべて QQ[x, y] の元。浮動小数点と RR / CC への脱出はない。
P.<x, y> = PolynomialRing(QQ)

def incl(r):
    return (P(r), P(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

minus_one_C = incl(-1)
one_C = incl(1)

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return pair_mul(minus_one_C, z)

z = (x, y)
chain = [
    neg(neg(z)),                                          # -(-z)
    pair_mul(minus_one_C, neg(z)),                        # (-1_C)(-z)              multiply_by_minus_one (z -> -z)
    pair_mul(minus_one_C, pair_mul(minus_one_C, z)),      # (-1_C)((-1_C)z)         multiply_by_minus_one (z -> z)
    pair_mul(pair_mul(minus_one_C, minus_one_C), z),      # ((-1_C)(-1_C))z         積の結合律を右辺から左辺へ
    pair_mul(one_C, z),                                   # 1_C z                   minus_one_times_minus_one_is_one_in_cc
    z,                                                    # z                       積の単位元
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: 符号反転を一回だけ施したものは z と一致しない
assert neg(z) != z
print("checked the chain of 6 terms over QQ[x, y] pairs")
print("RESULT: PASS")
