# 対象ラベル: euler_formula_cos_sin
# 証明の、差・符号反転を開く行と、sum_plus_difference_is_twice_first_in_cc・sum_minus_difference_is_twice_second_in_cc を引く行を確かめる。
#   準備の鎖の最後の 2 行: cos θ + i(-sin θ) = cos θ + (-(i sin θ)) = cos θ - i sin θ
#     （根拠は i_times_negated_real_is_negation_of_i_times（θ → sin θ）と def_complex_difference を右辺から左辺へ）
#   第 1 の等式の鎖の 6 行目の分子: 2_C cos θ = (cos θ + i sin θ) + (cos θ - i sin θ)
#     （sum_plus_difference_is_twice_first_in_cc（a → cos θ、b → i sin θ）を右辺から左辺へ）
#   第 2 の等式の鎖の 6・7 行目の分子: (2_C i) sin θ = 2_C (i sin θ) = (cos θ + i sin θ) - (cos θ - i sin θ)
#     （積の結合律、sum_minus_difference_is_twice_second_in_cc（同じ置き換え）を右辺から左辺へ）
# 分母（2_C、2_C i）は隣り合う行で同じなので、分子が等しいことを見れば商も等しい（def_complex_quotient の z w^{-1}）。
# ℂ を実数の対として持ち（definition_of_cc）、和は成分ごと、積は definition_of_cc の式、r_C := (r, 0)（inclusion_rr_to_cc）、
# -z := (-1_C) z（multiply_by_minus_one）、z - w := z + (-w)（def_complex_difference）、i = (0, 1)（def_imaginary_unit）。
# (cos θ)_C・(sin θ)_C の実数 cos θ・sin θ は不定元 c・s（全実数上の cos・sin は本文で未整備なので値は組まない）。
# ℝ の符号反転 -sin θ は -s。帰属: 成分はすべて QQ[c, s] の元。浮動小数点と RR / CC への脱出はない。
P.<c, s> = PolynomialRing(QQ)

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (P(r), P(0))

def mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def add(z, w):
    """definition_of_cc の和。"""
    return (z[0] + w[0], z[1] + w[1])

m1 = incl(-1)
two = incl(2)
iC = (P(0), P(1))

def neg(z):
    """multiply_by_minus_one: -z := (-1_C) z。"""
    return mul(m1, z)

def sub(z, w):
    """def_complex_difference: z - w := z + (-w)。"""
    return add(z, neg(w))

C = incl(c)                 # (cos θ)_C
S = incl(s)                 # (sin θ)_C
iS = mul(iC, S)             # i sin θ
# 準備の鎖の最後の 2 行
prep = [
    add(C, mul(iC, incl(-s))),          # cos θ + i(-sin θ)_C
    add(C, neg(iS)),                    # cos θ + (-(i sin θ))
    sub(C, iS),                         # cos θ - i sin θ
]
for k in range(len(prep) - 1):
    assert prep[k] == prep[k + 1], ("prep", k)
# 第 1 の等式の鎖の 6 行目の分子
assert mul(two, C) == add(add(C, iS), sub(C, iS))
# 第 2 の等式の鎖の 6・7 行目の分子
sin_lines = [
    mul(mul(two, iC), S),               # (2_C i) sin θ
    mul(two, mul(iC, S)),               # 2_C (i sin θ)
    sub(add(C, iS), sub(C, iS)),        # (cos θ + i sin θ) - (cos θ - i sin θ)
]
for k in range(len(sin_lines) - 1):
    assert sin_lines[k] == sin_lines[k + 1], ("sin", k)
# 対照: 準備の鎖で -sin θ の符号を落とすと一致しない／第 1 の等式の分子で和を差にすると一致しない
assert add(C, mul(iC, S)) != prep[2]
assert mul(two, C) != sub(add(C, iS), sub(C, iS))
print("checked the 2 prep lines, the cos numerator line and the 2 sin numerator lines over QQ[c, s] pairs")
print("RESULT: PASS")
