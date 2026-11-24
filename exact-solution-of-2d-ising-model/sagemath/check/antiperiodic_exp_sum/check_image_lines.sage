# 対象ラベル: antiperiodic_exp_sum
# 証明の最初の準備の鎖（(2n)_Z = 2_Z n_Z、(2_Z a)_R = 2_R a_R、2μ - 1 の差と (2μ - 1)_Z・((2μ - 1)_Z)_R・((2μ)_Z)_R）と、
# 自然数の項数と整数の格子幅の像の 7 式を厳密に確かめる。
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


# 準備の鎖 (2n)_Z = 2_Z·n_Z（n ∈ N）の 10 行。ι_{N→Z} は inclusion_nn_to_zz の二つの式だけで組んだ iota_rec でも確かめる。
for n in range(0, 81):
    nN = Integer(n)
    L = [iota_NZ(2 * nN),                                  # (2n)_Z
         iota_rec(2 * nN),                                 # 略記 n_Z := ι(n)
         iota_rec(2) * iota_rec(nN),                       # inclusion_nn_to_zz_preserves_product（x -> 2, y -> n）
         iota_rec(1 + 1) * iota_rec(nN),                   # N の数字 2 := 1 + 1
         (iota_rec(1) + 1) * iota_rec(nN),                 # ι(m + 1) := ι(m) + 1（m -> 1_N）
         (iota_rec(0 + 1) + 1) * iota_rec(nN),             # N の加法の単位元 0 + x = x（x -> 1_N）を右辺から左辺へ
         ((iota_rec(0) + 1) + 1) * iota_rec(nN),           # ι(m + 1) := ι(m) + 1（m -> 0_N）
         ((ZZ(0) + 1) + 1) * iota_rec(nN),                 # ι(0_N) := 0_Z
         (ZZ(1) + ZZ(1)) * iota_rec(nN),                   # Z の和の単位元 0 + x = x（x -> 1_Z）
         ZZ(2) * iota_rec(nN),                             # def_power_of_integer の 2_Z := 1_Z + 1_Z を右辺から左辺へ
         ZZ(2) * iota_NZ(nN)]                              # 略記 n_Z を右辺から左辺へ
    for a, b in zip(L, L[1:]):
        assert a == b

# 準備の鎖 (2_Z·a)_R = 2_R·a_R（a ∈ Z）の 5 行
for a in range(-80, 81):
    a = ZZ(a)
    L = [iota_ZR(ZZ(2) * a),                               # (2_Z·a)_R
         iota_ZR(ZZ(2)) * iota_ZR(a),                      # inclusion_zz_to_rr_preserves_product
         iota_ZR(ZZ(1) + ZZ(1)) * iota_ZR(a),              # def_power_of_integer の 2_Z := 1_Z + 1_Z
         (iota_ZR(ZZ(1)) + iota_ZR(ZZ(1))) * iota_ZR(a),   # inclusion_zz_to_rr_preserves_sum
         (QQ(1) + QQ(1)) * iota_ZR(a),                     # inclusion_zz_to_rr_of_one を 2 か所へ
         QQ(2) * iota_ZR(a)]                               # def_real_two の 2 := 1 + 1 を右辺から左辺へ
    for x, y in zip(L, L[1:]):
        assert x == y

# μ ∈ N、1 ≤ μ について 2μ = 1 + (d + μ)（1 + d = μ）、(2μ - 1) + 1 = 2μ、
# (2μ - 1)_Z = 2_Z μ_Z - 1_Z の 7 行、((2μ - 1)_Z)_R = 2_R (μ_Z)_R - 1_R の 4 行、((2μ)_Z)_R = 2_R (μ_Z)_R の 2 行
for mu in range(1, 81):
    mu = Integer(mu)
    d = mu - 1                                             # 1 + d = μ を満たす d ∈ N
    assert 1 + d == mu and d >= 0
    L = [2 * mu, (1 + 1) * mu, 1 * mu + 1 * mu, mu + mu, (1 + d) + mu, 1 + (d + mu)]
    for x, y in zip(L, L[1:]):
        assert x == y
    assert 1 <= 2 * mu                                     # 順序と和の行により 1 ≤ 2μ（1 + (d + μ) = 2μ）
    diff = 2 * mu - 1                                      # N の差 2μ - 1（1 + diff = 2μ を満たす一意な元）
    assert diff >= 0 and 1 + diff == 2 * mu
    assert diff + 1 == 1 + diff == 2 * mu                  # 加法の交換律と差の定義
    L = [iota_rec(diff),                                   # (2μ - 1)_Z
         iota_rec(diff) + ZZ(0),                           # Z の和の単位元
         iota_rec(diff) + (ZZ(1) + (-ZZ(1))),              # Z の加法の逆元
         (iota_rec(diff) + ZZ(1)) + (-ZZ(1)),              # Z の加法の結合律
         iota_rec(diff + 1) + (-ZZ(1)),                    # ι(m + 1) := ι(m) + 1（m -> 2μ - 1）を右辺から左辺へ
         iota_rec(2 * mu) + (-ZZ(1)),                      # (2μ - 1) + 1 = 2μ
         ZZ(2) * iota_rec(mu) + (-ZZ(1)),                  # 準備の鎖 (2n)_Z = 2_Z n_Z（n -> μ）
         ZZ(2) * iota_rec(mu) - ZZ(1)]                     # def_int_difference を右辺から左辺へ
    for x, y in zip(L, L[1:]):
        assert x == y
    muZ = iota_NZ(mu)
    L = [iota_ZR(iota_NZ(diff)),                           # ((2μ - 1)_Z)_R
         iota_ZR(ZZ(2) * muZ - ZZ(1)),                     # 直前の鎖
         iota_ZR(ZZ(2) * muZ) - iota_ZR(ZZ(1)),            # inclusion_zz_to_rr_preserves_difference
         QQ(2) * iota_ZR(muZ) - iota_ZR(ZZ(1)),            # 準備の鎖 (2_Z a)_R = 2_R a_R（a -> μ_Z）
         QQ(2) * iota_ZR(muZ) - QQ(1)]                     # inclusion_zz_to_rr_of_one
    for x, y in zip(L, L[1:]):
        assert x == y
    L = [iota_ZR(iota_NZ(2 * mu)), iota_ZR(ZZ(2) * muZ), QQ(2) * iota_ZR(muZ)]
    for x, y in zip(L, L[1:]):
        assert x == y

# 前置きの (2_Z)_R = 2_R の 4 行と、N_R ≥ 1_R の前の ((1_N)_Z)_R = 1_R の 6 行
L = [iota_ZR(ZZ(2)), iota_ZR(ZZ(1) + ZZ(1)), iota_ZR(ZZ(1)) + iota_ZR(ZZ(1)), QQ(1) + QQ(1), QQ(2)]
for x, y in zip(L, L[1:]):
    assert x == y
L = [iota_ZR(iota_NZ(1)), iota_ZR(iota_rec(1)), iota_ZR(iota_rec(0 + 1)), iota_ZR(iota_rec(0) + ZZ(1)), iota_ZR(ZZ(0) + ZZ(1)), iota_ZR(ZZ(1)), QQ(1)]
for x, y in zip(L, L[1:]):
    assert x == y
# 前置きの ι_{N→Z}(2) = 2_Z の 7 行（ι_{N→Z} は inclusion_nn_to_zz の二つの式だけで組んだ iota_rec）
L = [iota_rec(2), iota_rec(1 + 1), iota_rec(1) + ZZ(1), iota_rec(0 + 1) + ZZ(1), (iota_rec(0) + ZZ(1)) + ZZ(1),
     (ZZ(0) + ZZ(1)) + ZZ(1), ZZ(1) + ZZ(1), ZZ(2)]
for x, y in zip(L, L[1:]):
    assert x == y
for N in range(1, 81):
    # 1_N ≤ N から inclusion_nn_to_zz_preserves_order で (1_N)_Z ≤ N_Z、inclusion_nn_to_zz_image_is_nonnegative で両辺 ≥ 0、
    # inclusion_zz_to_rr_is_monotone_on_nonnegatives で ((1_N)_Z)_R ≤ N_R
    assert 1 <= N and iota_rec(1) <= iota_rec(N) and 0 <= iota_rec(1) and 0 <= iota_rec(N)
    assert iota_ZR(iota_rec(1)) <= iota_ZR(iota_rec(N))
    assert iota_ZR(iota_NZ(N)) >= iota_ZR(iota_NZ(1)) == 1 > 0   # N_R ≥ ((1_N)_Z)_R = 1_R > 0_R

for M in range(2, 41):
    MN = Integer(M)  # (M_col)_N ∈ N_{≥2}
    assert MN >= 2 and iota_NZ(MN) == M
    # (2(M)_N)_Z = 2_Z((M)_N)_Z = 2_Z·M
    assert iota_NZ(2 * MN) == ZZ(2) * iota_NZ(MN) == ZZ(2) * M
    # ((M)_N)_R = (M)_R
    assert iota_ZR(iota_NZ(MN)) == iota_ZR(M)
    # (2M)_R = 2(M)_R
    assert iota_ZR(2 * M) == 2 * iota_ZR(M)
    # (2(M)_N)_R = ((2(M)_N)_Z)_R = (2_Z·M)_R = 2(M)_R
    assert iota_ZR(iota_NZ(2 * MN)) == iota_ZR(ZZ(2) * M) == 2 * iota_ZR(M)
    # ((M)_N)_C = (M)_C
    assert UCF(iota_ZR(iota_NZ(MN))) == to_C(M)
    # (2(M)_N)_C = (2M)_C
    assert UCF(iota_ZR(iota_NZ(2 * MN))) == to_C(2 * M)
    # 前置きの 3 行の鎖 (2_Z)_R = (ι_{N→Z}(2))_R ≤ (ι_{N→Z}((M)_N))_R = (M)_R
    # （(M)_N ≥ 2 から inclusion_nn_to_zz_preserves_order、両辺 ≥ 0 は inclusion_nn_to_zz_image_is_nonnegative）
    assert iota_rec(2) <= iota_rec(MN) and 0 <= iota_rec(2) and 0 <= iota_rec(MN)
    assert iota_ZR(ZZ(2)) == iota_ZR(iota_rec(2)) <= iota_ZR(iota_rec(MN)) == iota_ZR(M)
    # 主張の前提: (M)_R ≥ (2_Z)_R = 2_R > 0_R、2(M)_R ≠ 0_R
    assert iota_ZR(M) >= iota_ZR(ZZ(2)) == 2 and 2 > 0 and 2 * iota_ZR(M) != 0
print("  n = 0..80、a = -80..80、μ = 1..80: 準備の鎖 (2n)_Z、(2_Z a)_R、(2μ-1)_Z、((2μ-1)_Z)_R、((2μ)_Z)_R が成り立つ")
print("  ι_{N→Z}(2) = 2_Z、(2_Z)_R = 2_R、((1_N)_Z)_R = 1_R の鎖と N = 1..80 の ((1_N)_Z)_R ≤ N_R、N_R ≥ 1_R > 0_R が成り立つ")
print("  M_col = 2..40: 像の 7 式、(2_Z)_R ≤ (M_col)_R の 3 行と (M_col)_R ≥ 2 > 0、2(M_col)_R ≠ 0 が成り立つ")
print("RESULT: PASS")
