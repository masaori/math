# 対象ラベル: negation_plus_self_is_zero_in_cc
# 証明の八行の鎖の九つの項:
#   (-x)+x = (-1_C)x + x = (-1_C)x + 1_C x = ((-1_C)+1_C)x = ((-1,0)+(1,0))x
#          = (-1+1, 0+0)x = (0,0)x = 0_C x = 0_C
# ℂ を実数の対として持ち（definition_of_cc）、対の和・積は definition_of_cc の式で作る。r_C := (r, 0)（inclusion_rr_to_cc）。
# 符号反転は multiply_by_minus_one の定義どおり (-1_C) との積として組む。
# x = (a, b) の成分は QQ 上の多項式環の不定元（任意の実数を代入しても等号は保たれる）。
# 帰属: 成分はすべて QQ[a, b, c, d] の元（x の成分に使うのは a, b だけ）。浮動小数点と RR / CC への脱出はない。
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

x = (a, b)
chain = [
    pair_add(neg(x), x),                                              # (-x)+x
    pair_add(pair_mul(minus_one_C, x), x),                            # (-1_C)x + x            multiply_by_minus_one (z -> x)
    pair_add(pair_mul(minus_one_C, x), pair_mul(one_C, x)),           # (-1_C)x + 1_C x        積の単位元を右辺から左辺へ
    pair_mul(pair_add(minus_one_C, one_C), x),                        # ((-1_C)+1_C)x          右からの分配律を右辺から左辺へ
    pair_mul(pair_add((P(-1), P(0)), (P(1), P(0))), x),               # ((-1,0)+(1,0))x        inclusion_rr_to_cc を 2 箇所へ同時適用
    pair_mul((P(-1) + P(1), P(0) + P(0)), x),                         # (-1+1, 0+0)x           definition_of_cc の和
    pair_mul((P(0), P(0)), x),                                        # (0,0)x                 R の四則
    pair_mul(zero_C, x),                                              # 0_C x                  inclusion_rr_to_cc を右辺から左辺へ
    zero_C,                                                           # 0_C                    complex_zero_times_is_zero
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: x + x は 0_C と一致しない
assert pair_add(x, x) != zero_C
print("checked the chain of 9 terms over QQ[a, b, c, d] pairs (x = (a, b))")
print("RESULT: PASS")
