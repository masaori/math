# 対象ラベル: reversed_difference_is_negation_of_difference_in_cc
# 証明の十行の鎖の十一の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# ℂ を実数の対として持ち（definition_of_cc）、和は成分ごと、積は definition_of_cc の式
# (x,y)(u,v) = (xu - yv, xv + yu)。r_C := (r, 0)（inclusion_rr_to_cc）。
# 符号反転は multiply_by_minus_one の (-1_C) との積、差は def_complex_difference の z + (-w) として組む。
# a, b の成分は QQ 上の多項式環の不定元に置く（任意の実数を代入しても等号は保たれる）。
# 帰属: 成分はすべて QQ[a0, a1, b0, b1] の元。浮動小数点と RR / CC への脱出はない。
P.<a0, a1, b0, b1> = PolynomialRing(QQ)

def incl(r):
    return (P(r), P(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def pair_add(z, w):
    return (z[0] + w[0], z[1] + w[1])

m = incl(-1)          # -1_C
one = incl(1)         # 1_C

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return pair_mul(m, z)

def sub(z, w):
    """def_complex_difference: z - w := z + (-w)。"""
    return pair_add(z, neg(w))

a = (a0, a1)
b = (b0, b1)
chain = [
    sub(b, a),                                            # b - a
    pair_add(b, neg(a)),                                  # b + (-a)                def_complex_difference
    pair_add(neg(a), b),                                  # (-a) + b                加法の可換律
    pair_add(neg(a), pair_mul(one, b)),                   # (-a) + 1_C b            積の単位元
    pair_add(neg(a), pair_mul(pair_mul(m, m), b)),        # (-a) + ((-1)(-1)) b     minus_one_times_minus_one_is_one_in_cc
    pair_add(neg(a), pair_mul(m, pair_mul(m, b))),        # (-a) + (-1)((-1) b)     積の結合律
    pair_add(neg(a), pair_mul(m, neg(b))),                # (-a) + (-1)(-b)         multiply_by_minus_one
    pair_add(pair_mul(m, a), pair_mul(m, neg(b))),        # (-1)a + (-1)(-b)        multiply_by_minus_one
    pair_mul(m, pair_add(a, neg(b))),                     # (-1)(a + (-b))          左からの分配律
    neg(pair_add(a, neg(b))),                             # -(a + (-b))             multiply_by_minus_one
    neg(sub(a, b)),                                       # -(a - b)                def_complex_difference
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: b - a は a - b とは一致しない
assert sub(b, a) != sub(a, b)
print("checked the chain of 11 terms over QQ[a0, a1, b0, b1] pairs")
print("RESULT: PASS")
