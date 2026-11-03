# 対象ラベル: iH_is_real_symmetric
# Step 1 の準備（Z_m・Y_m のクロネッカー積表示の各 2 行）と Z_mY_m = (-i)σ_m^x の 8 行の鎖を、
# M_col = 1..5 の全ての m について、ガウス有理数体 QQ[i] の厳密計算で 1 行ずつ確かめる（浮動小数点は使わない）。
# 左辺の Z_m・Y_m は本文の定義どおりサイト行列の左から掛けた積で組み（def_site_pauli_matrices は σ^a を k 番目に置いた
# クロネッカー積）、各行の行列は本文の字面どおり 2×2 の因子の並びのクロネッカー積として組む。
K.<i> = QuadraticField(-1)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]]); SZ = M2([[1, 0], [0, -1]])   # pauli_matrix_products
mi = -i
def kron(factors):                      # def_kronecker: A_1 ⊠ ⋯ ⊠ A_M（左の因子が上位の桁）
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):                     # def_site_pauli_matrices: σ_k^a（k は 1 始まり）
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def left_product(mats):                 # 左から掛けた積（site_pauli_prefix_product_kronecker_form の P_r）
    P = mats[0]
    for X in mats[1:]:
        P = P * X
    return P
count = 0
def check_chain(name, rows):
    global count
    for k in range(1, len(rows)):
        assert rows[k] == rows[k-1], (name, k)
        count += 1
# Step 0 の σ^zσ^y = (-i)σ^x（check_37 で一行ずつ確かめた鎖の両端）
assert SZ * SY == mi * SX
for Mc in range(1, 6):
    for m in range(1, Mc + 1):
        Zm = left_product([site(Mc, j, SX) for j in range(1, m)] + [site(Mc, m, SZ)])   # def_jordan_wigner_Z_matrices
        Ym = left_product([site(Mc, j, SX) for j in range(1, m)] + [site(Mc, m, SY)])   # def_jordan_wigner_Y_matrices
        Zk = kron([SX] * (m - 1) + [SZ] + [I2] * (Mc - m))
        Yk = kron([SX] * (m - 1) + [SY] + [I2] * (Mc - m))
        check_chain("準備の Z_m", [Zm, Zk])
        check_chain("準備の Y_m", [Ym, Yk])
        check_chain("Z_mY_m", [
            Zm * Ym,
            Zk * Ym,
            Zk * Yk,
            kron([SX * SX] * (m - 1) + [SZ * SY] + [I2 * I2] * (Mc - m)),
            kron([I2] * (m - 1) + [SZ * SY] + [I2 * I2] * (Mc - m)),
            kron([I2] * (m - 1) + [SZ * SY] + [I2] * (Mc - m)),
            kron([I2] * (m - 1) + [mi * SX] + [I2] * (Mc - m)),
            mi * kron([I2] * (m - 1) + [SX] + [I2] * (Mc - m)),
            mi * site(Mc, m, SX),
        ])
        # 否定コントロール: スカラーの符号を取り違えると偽。σ^x を置くサイトを取り違えると偽（Mc ≥ 2）
        assert Zm * Ym != i * site(Mc, m, SX)
        if Mc >= 2:
            other = m % Mc + 1
            assert Zm * Ym != mi * site(Mc, other, SX)
print(f"判定 {count} 段（M_col = 1..5、全ての m）")
print("ALL PASS")
