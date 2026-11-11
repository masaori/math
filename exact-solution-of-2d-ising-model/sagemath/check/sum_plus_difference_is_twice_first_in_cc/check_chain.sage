# 対象ラベル: sum_plus_difference_is_twice_first_in_cc
# 証明の十一行の鎖の十二の項を、各行に書かれた式どおりに組み、隣り合う項が等しいことを確かめる。
# ℂ を実数の対として持ち（definition_of_cc）、和は成分ごと、積は definition_of_cc の式
# (x,y)(u,v) = (xu - yv, xv + yu)。r_C := (r, 0)（inclusion_rr_to_cc）。
# 符号反転は multiply_by_minus_one の (-1_C) との積、差は def_complex_difference の z + (-w) として組む。
# a, b の成分は QQ 上の多項式環の不定元に置く（任意の実数を代入しても等号は保たれる）。
# 帰属: 成分はすべて QQ[a0, a1, b0, b1] の元。浮動小数点と RR / CC への脱出はない。
P.<a0, a1, b0, b1> = PolynomialRing(QQ)

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (P(r), P(0))

def mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def add(z, w):
    """definition_of_cc の和。"""
    return (z[0] + w[0], z[1] + w[1])

m1 = incl(-1)         # -1_C
one = incl(1)         # 1_C
two = incl(2)         # 2_C
zero = incl(0)        # 0_C

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return mul(m1, z)

def sub(z, w):
    """def_complex_difference: z - w := z + (-w)。"""
    return add(z, neg(w))

a = (a0, a1)
b = (b0, b1)
chain = [
    add(add(a, b), sub(a, b)),                    # (a+b) + (a-b)
    add(add(a, b), add(a, neg(b))),               # (a+b) + (a+(-b))        def_complex_difference
    add(add(add(a, b), a), neg(b)),               # ((a+b)+a) + (-b)        加法の結合律を右辺から左辺へ
    add(add(a, add(b, a)), neg(b)),               # (a+(b+a)) + (-b)        加法の結合律
    add(add(a, add(a, b)), neg(b)),               # (a+(a+b)) + (-b)        加法の可換律
    add(add(add(a, a), b), neg(b)),               # ((a+a)+b) + (-b)        加法の結合律を右辺から左辺へ
    add(add(a, a), add(b, neg(b))),               # (a+a) + (b+(-b))        加法の結合律
    add(add(a, a), zero),                         # (a+a) + 0_C             加法の逆元
    add(a, a),                                    # a + a                   加法の単位元
    add(mul(one, a), mul(one, a)),                # 1_C a + 1_C a           積の単位元
    mul(add(one, one), a),                        # (1_C + 1_C) a           右からの分配律
    mul(two, a),                                  # 2_C a                   one_plus_one_is_two_in_cc
]
assert len(chain) == 12
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 対照: 7 行目の b + (-b) を 0_C でなく b に替えると鎖が切れる／結論の 2_C a を 2_C b に替えると一致しない
assert add(add(a, a), b) != chain[6]
assert chain[0] != mul(two, b)
print("checked the chain of 12 terms over QQ[a0, a1, b0, b1] pairs")
print("RESULT: PASS")
