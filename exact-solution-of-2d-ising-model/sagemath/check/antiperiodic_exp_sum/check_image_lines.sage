# 対象ラベル: antiperiodic_exp_sum
# 証明の最初の鎖（自然数の項数と整数の格子幅の像）の 6 行を M_col = 2..40 で厳密に確かめる。
# (M_col)_N は ((M_col)_N)_Z = M_col を満たす一意な自然数。ι_{N→Z} = ZZ、ι_{Z→R} = QQ（ℝ の有理数の部分）。
load("_prelude.sage")
iota_NZ = lambda n: ZZ(n)
iota_ZR = lambda a: QQ(a)
for M in range(2, 41):
    MN = Integer(M)  # (M_col)_N ∈ N_{≥2}
    assert MN >= 2 and iota_NZ(MN) == M
    # (2(M)_N)_Z = 2M
    assert iota_NZ(2 * MN) == 2 * M
    # ((M)_N)_R = (M)_R
    assert iota_ZR(iota_NZ(MN)) == iota_ZR(M)
    # (2(M)_N)_R = 2(M)_R
    assert iota_ZR(iota_NZ(2 * MN)) == 2 * iota_ZR(M)
    # (2M)_R = 2(M)_R
    assert iota_ZR(2 * M) == 2 * iota_ZR(M)
    # ((M)_N)_C = (M)_C
    assert UCF(iota_ZR(iota_NZ(MN))) == to_C(M)
    # (2(M)_N)_C = (2M)_C
    assert UCF(iota_ZR(iota_NZ(2 * MN))) == to_C(2 * M)
    # 主張の前提: (M)_R ≥ 2_R > 0_R、2(M)_R ≠ 0_R
    assert iota_ZR(M) >= 2 and 2 * iota_ZR(M) != 0
print("  M_col = 2..40: 像の 6 行と (M_col)_R ≥ 2 > 0、2(M_col)_R ≠ 0 が成り立つ")
print("RESULT: PASS")
