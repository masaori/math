# 対象ラベル: iH_is_real_symmetric
# Step 3 の転置の 3 本の鎖（(σ_m^x)^⊤ = σ_m^x の 5 行、(σ_m^zσ_{m+1}^z)^⊤ = σ_m^zσ_{m+1}^z の 5 行、G^⊤ = G の 11 行）を、
# M_col = 2..7 について、ガウス有理数体 QQ[i] の厳密計算で 1 行ずつ確かめる（浮動小数点は使わない）。
# 左辺の σ_m^x・σ_m^zσ_{m+1}^z・G は本文の定義どおり（def_site_pauli_matrices のサイト行列と、その左から掛けた積）で組み、
# 各行の行列は本文の字面どおり 2×2 の因子の並びのクロネッカー積（転置は因子ごとに付けた形）として組む。
K.<i> = QuadraticField(-1)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]]); SZ = M2([[1, 0], [0, -1]])   # def_pauli_matrices
m1 = K(-1)
def kron(factors):                      # def_kronecker: A_1 ⊠ ⋯ ⊠ A_M（左の因子が上位の桁）
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):                     # def_site_pauli_matrices: σ_k^a（k は 1 始まり）
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def left_product(mats):
    P = mats[0]
    for X in mats[1:]:
        P = P * X
    return P
T = lambda A: A.transpose()             # def_matrix_transpose
count = 0
def check_chain(name, rows):
    global count
    for k in range(1, len(rows)):
        assert rows[k] == rows[k-1], (name, k)
        count += 1
# 引く 2×2 の主張（transpose_of_* は sagemath/check/transpose_of_* で一行ずつ確かめた鎖の両端）
assert T(I2) == I2 and T(SX) == SX and T(SZ) == SZ and T(SY) == -SY
assert -SY == m1 * SY                   # negation_is_scalar_multiple_by_minus_one
assert m1 * m1 == 1
negatives = 0
for Mc in range(2, 8):
    mid = Mc - 2
    for m in range(1, Mc + 1):
        sx = site(Mc, m, SX)
        f = lambda A, B: [A if j == m else B for j in range(1, Mc + 1)]
        check_chain(f"(σ_{m}^x)^T", [
            T(sx),
            T(kron(f(SX, I2))),
            kron(f(T(SX), T(I2))),
            kron(f(T(SX), I2)),
            kron(f(SX, I2)),
            sx,
        ])
    for m in range(1, Mc):
        zz = site(Mc, m, SZ) * site(Mc, m + 1, SZ)
        g = lambda A, B: [I2] * (m - 1) + [A, A] + [B] * (Mc - m - 1)
        check_chain(f"(σ_{m}^zσ_{m+1}^z)^T", [
            T(zz),
            T(kron(g(SZ, I2))),
            kron([T(I2)] * (m - 1) + [T(SZ), T(SZ)] + [T(I2)] * (Mc - m - 1)),
            kron(g(T(SZ), I2)),
            kron(g(SZ, I2)),
            zz,
        ])
        # 否定コントロール: 第 m+1 因子の σ^z を I に替えた行列は σ_m^zσ_{m+1}^z と違う
        assert zz != kron([I2] * (m - 1) + [SZ, I2] + [I2] * (Mc - m - 1))
        negatives += 1
    G = left_product([site(Mc, 1, SY)] + [site(Mc, j, SX) for j in range(2, Mc)] + [site(Mc, Mc, SY)])  # 主張の G の定義
    Gk = kron([SY] + [SX] * mid + [SY])
    check_chain("G^T", [
        T(G),
        T(Gk),
        kron([T(SY)] + [T(SX)] * mid + [T(SY)]),
        kron([T(SY)] + [SX] * mid + [T(SY)]),
        kron([-SY] + [SX] * mid + [-SY]),
        kron([m1 * SY] + [SX] * mid + [m1 * SY]),
        m1 * kron([SY] + [SX] * mid + [m1 * SY]),
        m1 * (m1 * kron([SY] + [SX] * mid + [SY])),
        (m1 * m1) * kron([SY] + [SX] * mid + [SY]),
        K(1) * kron([SY] + [SX] * mid + [SY]),
        kron([SY] + [SX] * mid + [SY]),
        G,
    ])
    # 否定コントロール: σ^y が 1 個だけ（第 M_col 因子を σ^x に替えた）なら転置は −1 倍で、対称にならない
    H = kron([SY] + [SX] * mid + [SX])
    assert T(H) == -H and T(H) != H
    # 否定コントロール: σ_m^y は転置で符号が変わる
    assert T(site(Mc, 1, SY)) != site(Mc, 1, SY)
    negatives += 2
print(f"判定 {count} 段（M_col = 2..7）、否定コントロール {negatives} 件")
print("ALL PASS")
