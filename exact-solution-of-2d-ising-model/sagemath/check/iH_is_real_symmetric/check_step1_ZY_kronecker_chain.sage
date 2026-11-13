# 対象ラベル: iH_is_real_symmetric
# Step 1 の準備（a_j^{(z)}・a_j^{(y)} を置いた (k) の F_j = σ_j^{a_j} と、Z_m・Y_m のクロネッカー積表示の各 4 行
# （定義の有限積 Π F_j → (k) → site_pauli_prefix_product_kronecker_form → a_j の定義））と Z_mY_m = (-i)σ_m^x の 8 行の鎖を、
# M_col = 1..5 の全ての m について、ガウス有理数体 QQ[i] の厳密計算で 1 行ずつ確かめる（浮動小数点は使わない）。
# 左辺の Z_m・Y_m は本文の定義どおり因子 F_j の def_finite_product_of_matrices の有限積（左から掛ける）で組み（def_site_pauli_matrices は σ^a を k 番目に置いた
# クロネッカー積）、各行の行列は本文の字面どおり 2×2 の因子の並びのクロネッカー積として組む。
K.<i> = QuadraticField(-1)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]]); SZ = M2([[1, 0], [0, -1]])   # def_pauli_matrices
SIG = {'x': SX, 'y': SY, 'z': SZ}
mi = -i
def kron(factors):                      # def_kronecker: A_1 ⊠ ⋯ ⊠ A_M（左の因子が上位の桁）
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):                     # def_site_pauli_matrices: σ_k^a（k は 1 始まり）
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def left_product(mats):                 # def_finite_product_of_matrices: Π_{j=1}^{1} A_j := A_1、Π_{j=1}^{r+1} A_j := (Π_{j=1}^{r} A_j)A_{r+1}
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
# Step 0 の σ^zσ^y = (-i)σ^x（check_step0_pauli_product_chains.sage で一行ずつ確かめた鎖の両端）
assert SZ * SY == mi * SX
for Mc in range(1, 6):
    for m in range(1, Mc + 1):
        Fz = [site(Mc, j, SX) for j in range(1, m)] + [site(Mc, m, SZ)]   # def_jordan_wigner_Z_matrices の F_j^{(z)}
        Fy = [site(Mc, j, SX) for j in range(1, m)] + [site(Mc, m, SY)]   # def_jordan_wigner_Y_matrices の F_j^{(y)}
        az = ['x'] * (m - 1) + ['z']                                      # a_j^{(z)} の定義
        ay = ['x'] * (m - 1) + ['y']                                      # a_j^{(y)} の定義
        for j in range(1, m + 1):                                         # (k)
            check_chain("(k) F_j^{(z)}", [Fz[j-1], site(Mc, j, SIG[az[j-1]])])
            check_chain("(k) F_j^{(y)}", [Fy[j-1], site(Mc, j, SIG[ay[j-1]])])
        Zm = left_product(Fz)
        Ym = left_product(Fy)
        Zk = kron([SX] * (m - 1) + [SZ] + [I2] * (Mc - m))
        Yk = kron([SX] * (m - 1) + [SY] + [I2] * (Mc - m))
        check_chain("準備の Z_m", [
            Zm,
            left_product([site(Mc, j, SIG[az[j-1]]) for j in range(1, m + 1)]),
            kron([SIG[a] for a in az] + [I2] * (Mc - m)),
            Zk,
        ])
        check_chain("準備の Y_m", [
            Ym,
            left_product([site(Mc, j, SIG[ay[j-1]]) for j in range(1, m + 1)]),
            kron([SIG[a] for a in ay] + [I2] * (Mc - m)),
            Yk,
        ])
        # 否定コントロール: 第 m 因子の文字を取り違えた並び（a_m = y）は Z_m と一致しない
        assert kron([SX] * (m - 1) + [SY] + [I2] * (Mc - m)) != Zm
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
