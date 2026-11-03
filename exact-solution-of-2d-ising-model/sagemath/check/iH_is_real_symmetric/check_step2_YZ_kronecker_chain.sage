# 対象ラベル: iH_is_real_symmetric
# Step 2 の準備（Y_m・Z_{m+1} のクロネッカー積表示の各 2 行と、σ_m^zσ_{m+1}^z のクロネッカー積表示の 6 行）と
# Y_mZ_{m+1} = (-i)σ_m^zσ_{m+1}^z の 9 行の鎖を、M_col = 2..6 の全ての m ∈ {1,…,M_col-1} について、
# ガウス有理数体 QQ[i] の厳密計算で 1 行ずつ確かめる（浮動小数点は使わない）。
# 左辺の Y_m・Z_{m+1} は本文の定義どおりサイト行列の左から掛けた積で組み（def_site_pauli_matrices は σ^a を k 番目に置いた
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
# Step 0 の σ^yσ^x = (-i)σ^z（check_step0_pauli_product_chains.sage で一行ずつ確かめた鎖の両端）
assert SY * SX == mi * SZ
negatives = 0
for Mc in range(2, 7):
    for m in range(1, Mc):
        Ym = left_product([site(Mc, j, SX) for j in range(1, m)] + [site(Mc, m, SY)])         # def_jordan_wigner_Y_matrices
        Zn = left_product([site(Mc, j, SX) for j in range(1, m + 1)] + [site(Mc, m + 1, SZ)])  # def_jordan_wigner_Z_matrices (m → m+1)
        Yk = kron([SX] * (m - 1) + [SY] + [I2] * (Mc - m))
        Zk = kron([SX] * m + [SZ] + [I2] * (Mc - m - 1))
        ZZ = site(Mc, m, SZ) * site(Mc, m + 1, SZ)
        check_chain("準備の Y_m", [Ym, Yk])
        check_chain("準備の Z_{m+1}", [Zn, Zk])
        rest = Mc - m - 1
        check_chain("準備の σ_m^zσ_{m+1}^z", [
            ZZ,
            kron([I2] * (m - 1) + [SZ] + [I2] + [I2] * rest) * site(Mc, m + 1, SZ),
            kron([I2] * (m - 1) + [SZ] + [I2] + [I2] * rest) * kron([I2] * (m - 1) + [I2] + [SZ] + [I2] * rest),
            kron([I2 * I2] * (m - 1) + [SZ * I2] + [I2 * SZ] + [I2 * I2] * rest),
            kron([I2 * I2] * (m - 1) + [SZ] + [I2 * SZ] + [I2 * I2] * rest),
            kron([I2 * I2] * (m - 1) + [SZ] + [SZ] + [I2 * I2] * rest),
            kron([I2] * (m - 1) + [SZ] + [SZ] + [I2] * rest),
        ])
        check_chain("Y_mZ_{m+1}", [
            Ym * Zn,
            Yk * Zn,
            kron([SX] * (m - 1) + [SY] + [I2] + [I2] * rest) * kron([SX] * (m - 1) + [SX] + [SZ] + [I2] * rest),
            kron([SX * SX] * (m - 1) + [SY * SX] + [I2 * SZ] + [I2 * I2] * rest),
            kron([I2] * (m - 1) + [SY * SX] + [I2 * SZ] + [I2 * I2] * rest),
            kron([I2] * (m - 1) + [SY * SX] + [SZ] + [I2 * I2] * rest),
            kron([I2] * (m - 1) + [SY * SX] + [SZ] + [I2] * rest),
            kron([I2] * (m - 1) + [mi * SZ] + [SZ] + [I2] * rest),
            mi * kron([I2] * (m - 1) + [SZ] + [SZ] + [I2] * rest),
            mi * ZZ,
        ])
        # 否定コントロール: スカラーの符号を取り違えると偽。σ^z を置く 2 サイトを 1 つずらすと偽（Mc ≥ 3）
        assert Ym * Zn != i * ZZ
        negatives += 1
        if Mc >= 3:
            a = m % Mc + 1; b = a % Mc + 1
            assert Ym * Zn != mi * site(Mc, a, SZ) * site(Mc, b, SZ)
            negatives += 1
print(f"判定 {count} 段（M_col = 2..6、全ての m ∈ {{1,…,M_col-1}}）、否定コントロール {negatives} 件")
print("ALL PASS")
