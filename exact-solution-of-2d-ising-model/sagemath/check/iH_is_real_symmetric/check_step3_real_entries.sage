# 対象ラベル: iH_is_real_symmetric
# Step 3 の成分の実性のうち σ_m^x・σ_m^zσ_{m+1}^z の 2 段落を、M_col = 2..7 について QQ[i] の厳密計算で確かめる。
# 各段落は (1) 本文の定義（def_site_pauli_matrices のサイト行列とその左から掛けた積）で組んだ行列が、
# 段落の因子の並び（I⊠⋯⊠σ^x⊠⋯⊠I、I⊠⋯⊠I⊠σ^z⊠σ^z⊠I⊠⋯⊠I）のクロネッカー積に等しいこと、
# (2) 因子 I・σ^x・σ^z の成分がすべて ι(r)（虚部 0）であること（identity_matrix_of_order_two_has_real_entries・
# pauli_x_has_real_entries・pauli_z_has_real_entries）、(3) kronecker_of_real_entry_matrices_has_real_entries の結論として、
# 積の全成分が r := ∏_k r_k の ι(r) であること、の 3 点である。浮動小数点は使わない。
K.<i> = QuadraticField(-1)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]]); SZ = M2([[1, 0], [0, -1]])   # def_pauli_matrices
def kron(factors):                      # def_kronecker
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):                     # def_site_pauli_matrices
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def real_matrix_of(A):                  # 各成分の r（虚部 0 を確かめてから実部を取る）
    assert all(A[p, q].imag() == 0 for p in range(A.nrows()) for q in range(A.ncols()))
    return matrix(QQ, A.nrows(), A.ncols(), lambda p, q: A[p, q].real())
def iota(R):                            # ι_{R→C} を成分ごとに
    return matrix(K, R.nrows(), R.ncols(), lambda p, q: K([R[p, q], 0]))
RI, RX, RZ = real_matrix_of(I2), real_matrix_of(SX), real_matrix_of(SZ)
assert iota(RI) == I2 and iota(RX) == SX and iota(RZ) == SZ
count = 0
negatives = 0
for Mc in range(2, 8):
    for m in range(1, Mc + 1):
        sx = site(Mc, m, SX)
        factors = [SX if j == m else I2 for j in range(1, Mc + 1)]
        reals = [RX if j == m else RI for j in range(1, Mc + 1)]
        assert sx == kron(factors)                          # def_site_pauli_matrices の表示
        R = matrix(QQ, 1, 1, [1])
        for A in reals:
            R = R.tensor_product(A)                         # r := ∏_k r_k を成分ごとに
        assert sx == iota(R)                                # 全成分が ι(r)
        count += 1
    for m in range(1, Mc):
        zz = site(Mc, m, SZ) * site(Mc, m + 1, SZ)
        factors = [I2] * (m - 1) + [SZ, SZ] + [I2] * (Mc - m - 1)
        reals = [RI] * (m - 1) + [RZ, RZ] + [RI] * (Mc - m - 1)
        assert zz == kron(factors)                          # Step 2 の準備の表示
        R = matrix(QQ, 1, 1, [1])
        for A in reals:
            R = R.tensor_product(A)
        assert zz == iota(R)
        count += 1
    # 否定コントロール: σ^y を 1 個だけ含む因子の並びは虚部 0 でない成分を持つ
    Y1 = site(Mc, 1, SY)
    assert any(Y1[p, q].imag() != 0 for p in range(2**Mc) for q in range(2**Mc))
    negatives += 1
print(f"  {count} 個の行列（σ_m^x と σ_m^zσ_{{m+1}}^z、M_col = 2..7）の全成分が ι(r) の形（QQ[i] の厳密計算）")
print(f"  否定コントロール {negatives} 件: σ_1^y は虚部 0 でない成分を持つ")
print("RESULT: PASS")
