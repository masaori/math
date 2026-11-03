# 対象ラベル: recover_Z_Y_from_check_Z_Y
# 準備 2 の二つの鎖を一行ずつ確かめる。
# - 実数の鎖（5 等号）: x・j・k を不定元にした QQ 上の有理関数体で各行を組み、隣と比べる。j_R・k_R は (j_Z)_R・(k_Z)_R と同じ不定元で、
#   ι_{Z→R} が差を保つ最後の行は (j - k)_R を j - k として作るので作り方で自明である。有理関数体は結合律・分配律・
#   (-1)y = -y で並べ替えた式を同じ元にするので、この鎖の比較は中身を持たず、値が通ることを見るだけである。
# - 複素数の鎖（8 等号）: ℂ を本文どおり実数の対で持ち（complex_as_real_pairs.sage）、同じ有理関数体の上で各行を組み、隣と比べる。
#   -1_C は 1_C + w = 0_C の解として作り、(-1_R)_C と比べる。
# 対照: -i の符号を落とすと（i(k_R x)_C を足すと）右辺 i((j-k)_R x)_C と一致しない。
load("../../_shared/complex_as_real_pairs.sage")

F = FractionField(PolynomialRing(QQ, ['x', 'j', 'k']))
x, j, k = F.gens()

real_lines = [
    j * x + (-1) * (k * x),
    j * x + ((-1) * k) * x,
    j * x + (-k) * x,
    (j + (-k)) * x,
    (j - k) * x,
    (j - k) * x,
]
assert len(real_lines) == 6   # 証明の 5 等号
for t in range(len(real_lines) - 1):
    assert real_lines[t] == real_lines[t + 1], ("real", t)
print("  real chain: 5 equalities hold in QQ(x, j, k)")

iF = (F(0), F(1))
oneF = iota(1, F)
minus_one = (F(-1) - F(0), F(0) - F(0))          # 1_C + w = 0_C の解
assert cc_add(oneF, minus_one) == (F(0), F(0))
assert minus_one == iota(-1, F)                    # (-1_R)_C = -1_C
minus_i = cc_mul(minus_one, iF)                    # multiply_by_minus_one: -i := (-1_C)i
jx, kx = iota(j * x, F), iota(k * x, F)
cx_lines = [
    cc_add(cc_mul(iF, jx), cc_mul(minus_i, kx)),
    cc_add(cc_mul(iF, jx), cc_mul(cc_mul(minus_one, iF), kx)),
    cc_add(cc_mul(iF, jx), cc_mul(cc_mul(iF, minus_one), kx)),
    cc_add(cc_mul(iF, jx), cc_mul(iF, cc_mul(minus_one, kx))),
    cc_mul(iF, cc_add(jx, cc_mul(minus_one, kx))),
    cc_mul(iF, cc_add(jx, cc_mul(iota(-1, F), kx))),
    cc_mul(iF, cc_add(jx, iota((-1) * (k * x), F))),
    cc_mul(iF, iota(j * x + (-1) * (k * x), F)),
    cc_mul(iF, iota((j - k) * x, F)),
]
assert len(cx_lines) == 9   # 証明の 8 等号
for t in range(len(cx_lines) - 1):
    assert cx_lines[t] == cx_lines[t + 1], ("complex", t)
# 対照
assert cc_add(cc_mul(iF, jx), cc_mul(iF, kx)) != cx_lines[-1]
print("  complex chain: 8 equalities hold on real pairs over QQ(x, j, k)")
print("RESULT: PASS")
