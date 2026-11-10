# 対象ラベル: real_inclusion_preserves_difference
# 証明の七つの項（六つの等号）:
#   y_C - z_C = y_C + (-z_C) = y_C + (-1_C) z_C = y_C + (-1)_C z_C = y_C + ((-1)z)_C = (y + (-1)z)_C = (y - z)_C
# ℂ は definition_of_cc どおり実数の対で持ち（complex_as_real_pairs.sage）、y, z を QQ 上の多項式環の不定元に置く。
# 不定元の多項式の等号は厳密に決まり、任意の実数を代入しても保たれる（代入は環準同型）。帰属: QQ[y,z]。
load("../../_shared/complex_as_real_pairs.sage")


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label


S = PolynomialRing(QQ, ['y', 'z'])
y, z = S.gens()
yC, zC = iota(y, S), iota(z, S)
lines = [
    ("y_C - z_C", cc_sub(yC, zC, S)),                          # 左辺の差は def_complex_difference
    ("y_C + (-z_C)", cc_add(yC, cc_neg(zC, S))),               # def_complex_difference
    ("y_C + (-1_C) z_C", cc_add(yC, cc_mul(iota(-1, S), zC))), # multiply_by_minus_one
    ("y_C + (-1)_C z_C", cc_add(yC, cc_mul(iota(S(-1), S), zC))),  # inclusion_rr_to_cc の -1_C = (-1)_C
    ("y_C + ((-1)z)_C", cc_add(yC, iota((-1) * z, S))),        # real_inclusion_preserves_product
    ("(y + (-1)z)_C", iota(y + (-1) * z, S)),                  # real_inclusion_preserves_sum
    ("(y - z)_C", iota(y - z, S)),                             # 実数の四則
]
for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
    report(v0 == v1, f"「{n0}」=「{n1}」")
# 主張そのもの（両端）
report(cc_sub(yC, zC, S) == iota(y - z, S), "主張 y_C - z_C = (y - z)_C")
# 独立な経路: QQ(i)[y,z] で y - z を計算し、虚部が 0 で実部が y - z
K.<I> = QuadraticField(-1)
T.<Y, Z> = PolynomialRing(K)
p = (Y + 0 * I) - (Z + 0 * I)
re = sum(c.real() * m for c, m in zip(p.coefficients(), p.monomials()))
im = sum(c.imag() * m for c, m in zip(p.coefficients(), p.monomials()))
report(re == Y - Z and im == 0, "独立な経路: QQ(i)[Y,Z] の差の実部が Y - Z、虚部が 0")
# 対照: 差を和に取り違えると成り立たない。虚部が 0 でない数どうしでは差の虚部が残る
report(cc_sub(yC, zC, S) != iota(y + z, S), "対照: y_C - z_C ≠ (y + z)_C")
report(cc_sub((y, S(1)), (z, S(0)), S) != iota(y - z, S), "対照: 虚部が 1 の数から引くと実数の像にならない")
print("RESULT: PASS")
