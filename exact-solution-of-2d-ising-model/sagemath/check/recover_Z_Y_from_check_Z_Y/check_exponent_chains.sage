# 対象ラベル: recover_Z_Y_from_check_Z_Y
# 準備 2 の二つの鎖を一行ずつ確かめる。
# - 実数の鎖（4 等号）: x・j・k を不定元にした QQ 上の有理関数体で各行を組み、隣と比べる。j_R・k_R は (j_Z)_R・(k_Z)_R と同じ不定元で、
#   ι_{Z→R} が差を保つ最後の行は (j - k)_R を j - k として作るので作り方で自明である。有理関数体は分配律・
#   -(ab) = (-a)b で並べ替えた式を同じ元にするので、この鎖の比較は中身を持たず、値が通ることを見るだけである。
# - 複素数の鎖（5 等号）: ℂ を本文どおり実数の対で持ち（complex_as_real_pairs.sage）、同じ有理関数体の上で各行を組み、隣と比べる。
#   -i は multiply_by_minus_one どおり (-1_C)i、-1_C は inclusion_rr_to_cc の像 (-1)_C として作る。
#   1 行目の negative_i_times_complex_is_negation_of_i_times（z → (k_R x)_C）と 2 行目の i_times_negated_real_is_negation_of_i_times
#   （θ → k_R x）は、参照先の主張そのものを、この鎖で当てる値で両辺の対として別に確かめる。
# 対照: -i の符号を落とすと（i(k_R x)_C を足すと）右辺 i((j-k)_R x)_C と一致しない。
load("../../_shared/complex_as_real_pairs.sage")

F = FractionField(PolynomialRing(QQ, ['x', 'j', 'k']))
x, j, k = F.gens()

real_lines = [
    j * x + (-(k * x)),
    j * x + (-k) * x,
    (j + (-k)) * x,
    (j - k) * x,
    (j - k) * x,
]
assert len(real_lines) == 5   # 証明の 4 等号
for t in range(len(real_lines) - 1):
    assert real_lines[t] == real_lines[t + 1], ("real", t)
print("  real chain: 4 equalities hold in QQ(x, j, k)")

iF = (F(0), F(1))
minus_one = iota(-1, F)                            # -1_C = (-1)_C（inclusion_rr_to_cc の略記）
oneF = iota(1, F)
assert cc_add(oneF, minus_one) == (F(0), F(0))     # 1_C の加法の逆元でもある
minus_i = cc_mul(minus_one, iF)                    # multiply_by_minus_one: -i := (-1_C)i
def neg(z):                                        # multiply_by_minus_one: -z := (-1_C)z
    return cc_mul(minus_one, z)
jx, kx = iota(j * x, F), iota(k * x, F)
# 参照先の主張を、この鎖で当てる値で確かめる
assert cc_mul(minus_i, kx) == neg(cc_mul(iF, kx))                 # negative_i_times_complex_is_negation_of_i_times (z -> (k_R x)_C)
assert cc_mul(iF, iota(-(k * x), F)) == neg(cc_mul(iF, kx))       # i_times_negated_real_is_negation_of_i_times (theta -> k_R x)
cx_lines = [
    cc_add(cc_mul(iF, jx), cc_mul(minus_i, kx)),
    cc_add(cc_mul(iF, jx), neg(cc_mul(iF, kx))),
    cc_add(cc_mul(iF, jx), cc_mul(iF, iota(-(k * x), F))),
    cc_mul(iF, cc_add(jx, iota(-(k * x), F))),
    cc_mul(iF, iota(j * x + (-(k * x)), F)),
    cc_mul(iF, iota((j - k) * x, F)),
]
assert len(cx_lines) == 6   # 証明の 5 等号
for t in range(len(cx_lines) - 1):
    assert cx_lines[t] == cx_lines[t + 1], ("complex", t)
# 対照
assert cc_add(cc_mul(iF, jx), cc_mul(iF, kx)) != cx_lines[-1]
print("  complex chain: 5 equalities hold on real pairs over QQ(x, j, k)")
print("RESULT: PASS")
