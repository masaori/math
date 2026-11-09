# 対象ラベル: def_rayleigh_sup
# 𝓡 ⊆ ℝ_{>0} の段の x ≠ 0 は unit_norm_vector_is_nonzero を引くので、その 6 行の鎖は unit_norm_vector_is_nonzero/ が受け持つ。
# c(M_col) > 0 の段（項ごとの値の 3 行の鎖 2 本と ‖e_1‖ = 1 の 4 行の鎖、e_1^⊤W_ℝe_1 ∈ 𝓡、
# e_1^⊤W_ℝe_1 > 0）を厳密に（QQ・AA）確かめる。上限 sup 𝓡 そのものは作らない（ℝ の完備性による値なので、
# 鎖の 2 行目「上限は 𝓡 の上界」は検算の対象外）。
load("../W_real_is_symmetric/_W_exact.sage")


def absR(q):
    """def_real_absolute_value: q ≥ 0 なら q、q < 0 なら −q。"""
    return q if q >= 0 else -q


def sqrt_nonneg(x):
    """definition_of_sqrt_r_positive: y ≥ 0 かつ y^2 = x を満たす y（AA で厳密）。"""
    y = AA(x).sqrt()
    assert y >= 0 and y**2 == x
    return y


count = 0
for M in [1, 2, 3, 4]:
    d = 2**M
    S = range(d)
    # e_1 の置き方
    e1 = [AA(1)] + [AA(0)] * (d - 1)
    # 項ごとの値の 3 行の鎖 2 本（i ≥ 2 と i = 1）
    for i in range(1, d):
        assert absR(e1[i])**2 == absR(AA(0))**2 == AA(0)**2 == 0
    assert absR(e1[0])**2 == absR(AA(1))**2 == AA(1)**2 == 1
    # ‖e_1‖ = 1 の 4 行: 項の値を代入し（1 + 0 + ⋯ + 0）、和を左から順に足す（def_finite_sum_of_real_numbers、1 + 0 = 1）
    acc = absR(e1[0])**2
    for i in range(1, d):
        acc = acc + absR(e1[i])**2
        assert acc == 1                                                    # 1 + 0 = 1
    m1 = sqrt_nonneg(sum(absR(e1[i])**2 for i in S))
    m2 = sqrt_nonneg(sum([AA(1)] + [AA(0)] * (d - 1)))
    m3 = sqrt_nonneg(AA(1))
    m4 = AA(1)
    assert m1 == m2 == m3 == m4
    count += 1
    if M >= 2 and M <= 3:
        for xx in [QQ(2), QQ(3)]:
            for y in [QQ(2), QQ(3)]:
                WC, WR = W_complex_and_real(M, xx, y)
                q = sum(e1[k] * WR[k, l] * e1[l] for k in S for l in S)   # e_1^⊤W_ℝe_1（def_real_bilinear_value）
                assert q == WR[0, 0] and q > 0                         # 𝓡 ⊆ ℝ_{>0} の元として正
                count += 1
# 否定コントロール: ‖e_1‖ = 1 の鎖は e_1 の成分の値に依る。成分を 2 にした 2e_1 ではノルムが 1 でない（M_col = 1..4）
for M in [1, 2, 3, 4]:
    d = 2**M
    assert sqrt_nonneg(sum(absR(t)**2 for t in [AA(2)] + [AA(0)] * (d - 1))) != 1
print(f"{count} 件で ‖e_1‖ = 1 の鎖と e_1^⊤W_ℝe_1 > 0 を確かめた。否定コントロール 4 件")
print("RESULT: PASS")
