# 対象ラベル: iH_is_real_symmetric
# Step 2 の境界項の準備（Y_{M_col}・Z_1・G のクロネッカー積表示の各 2 行）と
# Y_{M_col}Z_1 = (-i)G の 8 行の鎖を、M_col = 2..7 について、
# ガウス有理数体 QQ[i] の厳密計算で 1 行ずつ確かめる（浮動小数点は使わない）。
# 左辺の Y_{M_col}・Z_1・G は本文の定義どおりサイト行列の左から掛けた積で組み（def_site_pauli_matrices は σ^a を k 番目に置いた
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
# Step 0 の σ^xσ^z = (-i)σ^y（check_37 で一行ずつ確かめた鎖の両端）
assert SX * SZ == mi * SY
negatives = 0
for Mc in range(2, 8):
    mid = Mc - 2
    YM = left_product([site(Mc, j, SX) for j in range(1, Mc)] + [site(Mc, Mc, SY)])                  # def_jordan_wigner_Y_matrices (m → M_col)
    Z1 = site(Mc, 1, SZ)                                                                              # def_jordan_wigner_Z_matrices (m → 1)
    G = left_product([site(Mc, 1, SY)] + [site(Mc, j, SX) for j in range(2, Mc)] + [site(Mc, Mc, SY)])  # 主張の G の定義
    Yk = kron([SX] + [SX] * mid + [SY])
    Zk = kron([SZ] + [I2] * mid + [I2])
    Gk = kron([SY] + [SX] * mid + [SY])
    check_chain("準備の Y_{M_col}", [YM, Yk])
    check_chain("準備の Z_1", [Z1, Zk])
    check_chain("準備の G", [G, Gk])
    check_chain("Y_{M_col}Z_1", [
        YM * Z1,
        Yk * Z1,
        Yk * Zk,
        kron([SX * SZ] + [SX * I2] * mid + [SY * I2]),
        kron([SX * SZ] + [SX] * mid + [SY * I2]),
        kron([SX * SZ] + [SX] * mid + [SY]),
        kron([mi * SY] + [SX] * mid + [SY]),
        mi * kron([SY] + [SX] * mid + [SY]),
        mi * G,
    ])
    # 否定コントロール: スカラーの符号を取り違えると偽。境界の σ^y を σ^x に替えると偽。
    assert YM * Z1 != i * G
    assert YM * Z1 != mi * kron([SX] + [SX] * mid + [SY])
    negatives += 2
print(f"判定 {count} 段（M_col = 2..7）、否定コントロール {negatives} 件")
print("ALL PASS")
