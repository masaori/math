# 対象ラベル: conjugate_index_of_check_Z_Y
# (2) の準備の第二の鎖 (-i)(-(j_R θ̃_μ))_C = ⋯ = i(j_R θ̃_μ)_C の 7 等号を、ℂ を本文 definition_of_cc どおり実数の対で持って
# （sagemath/_shared/complex_as_real_pairs.sage）、実数 x := j_R θ̃_μ を QQ[x] の不定元に置いて各行を組み、隣と厳密に比べる。
# - i := (0_R, 1_R)、-i := (-1_C)i（multiply_by_minus_one）、r_C := (r, 0)（inclusion_rr_to_cc）、積と和は definition_of_cc。
# - -1_C は 1_C の加法の逆元として、1_C + w = 0_C を満たす対 w を解いて作り、(-1_R)_C と比べる（第 3 等号の根拠）。
# - 1_C は積の単位元として、1_C z = z を一般の対 z で確かめる（第 6 等号の根拠）。
# 第 1 等号（-x = (-1_R)x。多項式環では同じ元）と第 4 等号（-i := (-1_C)i。minus_i をこの形で作る）の比較は作り方で自明で、
# 中身を持つのは第 2・3・5・6・7 等号である。
# 対照: x の符号を落とした (-i)(x)_C は i(x)_C と一致しない。
load("../../_shared/complex_as_real_pairs.sage")
R.<x, a, b> = PolynomialRing(QQ)
iC = (R(0), R(1))
oneC = iota(1, R)
zeroC = iota(0, R)
w = (-oneC[0], -oneC[1])                       # 1_C + w = 0_C を解いた加法の逆元
assert cc_add(oneC, w) == zeroC
neg1C = w
assert iota(-1, R) == neg1C                    # (-1_R)_C = -1_C
minus_i = cc_mul(neg1C, iC)                    # -i := (-1_C) i
assert cc_mul(oneC, (a, b)) == (a, b)          # 1_C は積の単位元
assert cc_mul(neg1C, neg1C) == oneC            # (-1_C)(-1_C) = 1_C
lines = [
    ("(-i)(-(x))_C", cc_mul(minus_i, iota(-x, R))),
    ("(-i)((-1_R)x)_C", cc_mul(minus_i, iota((-1) * x, R))),
    ("(-i)((-1_R)_C x_C)", cc_mul(minus_i, cc_mul(iota(-1, R), iota(x, R)))),
    ("(-i)((-1_C) x_C)", cc_mul(minus_i, cc_mul(neg1C, iota(x, R)))),
    ("((-1_C)i)((-1_C) x_C)", cc_mul(cc_mul(neg1C, iC), cc_mul(neg1C, iota(x, R)))),
    ("((-1_C)(-1_C))(i x_C)", cc_mul(cc_mul(neg1C, neg1C), cc_mul(iC, iota(x, R)))),
    ("1_C(i x_C)", cc_mul(oneC, cc_mul(iC, iota(x, R)))),
    ("i x_C", cc_mul(iC, iota(x, R))),
]
for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
    assert v0 == v1, f"{n0} ≠ {n1}"
# 第 2 等号の real_inclusion_preserves_product: a_C b_C = (ab)_C を一般の a, b で
assert cc_mul(iota(a, R), iota(b, R)) == iota(a * b, R)
assert cc_mul(minus_i, iota(x, R)) != lines[-1][1]
print("  第二の鎖の 7 等号が実数の対の多項式環で厳密に成り立つ。(-1_R)_C = -1_C、(-1_C)(-1_C) = 1_C、a_C b_C = (ab)_C も成り立つ")
print("  対照: (-i)(x)_C ≠ i x_C")
print("RESULT: PASS")
