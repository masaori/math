# 対象ラベル: antiperiodic_exp_sum
# 証明の最初の鎖（自然数の項数と整数の格子幅の像）の 6 式（うち (2(M)_N)_Z = 2_Z·M は 11 行の鎖）を M_col = 2..40 で厳密に確かめる。
# (M_col)_N は ((M_col)_N)_Z = M_col を満たす一意な自然数。ι_{N→Z} = ZZ、ι_{Z→R} = QQ（ℝ の有理数の部分）。
load("_prelude.sage")
iota_NZ = lambda n: ZZ(n)
iota_ZR = lambda a: QQ(a)


def iota_rec(n):
    # inclusion_nn_to_zz の二つの式 ι(0_N) := 0_Z、ι(n + 1_N) := ι(n) + 1_Z だけで値を作る
    v = ZZ(0)
    for _ in range(n):
        v = v + ZZ(1)
    return v


for M in range(2, 41):
    MN = Integer(M)  # (M_col)_N ∈ N_{≥2}
    assert MN >= 2 and iota_NZ(MN) == M
    # (2(M)_N)_Z = 2_Z·M の 11 行。ι_{N→Z} は inclusion_nn_to_zz の二つの式だけで組んだ iota_rec でも確かめる。
    L = [iota_NZ(2 * MN),                                  # (2(M)_N)_Z
         iota_rec(2 * MN),                                 # 略記 n_Z := ι(n)
         iota_rec(2) * iota_rec(MN),                       # inclusion_nn_to_zz_preserves_product（x -> 2, y -> (M)_N）
         iota_rec(1 + 1) * iota_rec(MN),                   # N の数字 2 := 1 + 1
         (iota_rec(1) + 1) * iota_rec(MN),                 # ι(n + 1) := ι(n) + 1（n -> 1_N）
         (iota_rec(0 + 1) + 1) * iota_rec(MN),             # N の加法の単位元 0 + x = x（x -> 1_N）を右辺から左辺へ
         ((iota_rec(0) + 1) + 1) * iota_rec(MN),           # ι(n + 1) := ι(n) + 1（n -> 0_N）
         ((ZZ(0) + 1) + 1) * iota_rec(MN),                 # ι(0_N) := 0_Z
         (ZZ(1) + ZZ(1)) * iota_rec(MN),                   # Z の和の単位元 0 + x = x（x -> 1_Z）
         ZZ(2) * iota_rec(MN),                             # def_power_of_integer の 2_Z := 1_Z + 1_Z を右辺から左辺へ
         ZZ(2) * iota_NZ(MN),                              # 略記 n_Z を右辺から左辺へ
         ZZ(2) * M]                                        # (M)_N の定義 ((M)_N)_Z = M
    for a, b in zip(L, L[1:]):
        assert a == b
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
