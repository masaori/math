# 対象ラベル: iH_is_real_symmetric
# Step 3 の G の成分の実性の 7 行の鎖
#   G = σ^y⊠σ^x⊠⋯⊠σ^x⊠σ^y = (iR^y)⊠σ^x⊠⋯⊠σ^x⊠(iR^y) = i(R^y⊠⋯⊠(iR^y)) = i(i(R^y⊠⋯⊠R^y))
#     = (i·i)(R^y⊠⋯⊠R^y) = (-1_C)(R^y⊠⋯⊠R^y) = (-1)_C(R^y⊠⋯⊠R^y)
# と、続く段落（R^y・σ^x の成分が ι(r) → kronecker_of_real_entry_matrices_has_real_entries → real_scalar_multiple_of_real_entry_matrix_has_real_entries）を、
# M_col = 2..7 について QQ[i] の厳密計算で確かめる。G は主張の定義どおり σ_1^y σ_2^x ⋯ σ_{M_col-1}^x σ_{M_col}^y を左から掛けて組み、
# 1 行目の Step 2 の準備の表示（クロネッカー積）と一致することも確かめる。浮動小数点は使わない。
K.<i> = QuadraticField(-1)
M2 = MatrixSpace(K, 2, 2)
I2 = M2(1)
SX = M2([[0, 1], [1, 0]]); SY = M2([[0, -i], [i, 0]])        # pauli_matrix_products
RY = M2([[0, -1], [1, 0]])                                   # def_real_factor_of_pauli_y
def kron(factors):                      # def_kronecker
    out = matrix(K, 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out
def site(Mc, k, A):                     # def_site_pauli_matrices
    return kron([A if j == k else I2 for j in range(1, Mc + 1)])
def iota_scalar(r):
    return K([QQ(r), 0])
def has_real_entries(A):
    return all(A[p, q].imag() == 0 for p in range(A.nrows()) for q in range(A.ncols()))
count = 0
negatives = 0
for Mc in range(2, 8):
    G = site(Mc, 1, SY)
    for k in range(2, Mc):
        G = G * site(Mc, k, SX)
    G = G * site(Mc, Mc, SY)                                 # 主張の G の定義
    mid = [SX] * (Mc - 2)
    lines = [
        G,
        kron([SY] + mid + [SY]),                             # Step 2 の準備の G の表示
        kron([i * RY] + mid + [i * RY]),                     # pauli_y_is_i_times_real_factor を第 1・第 M_col 因子へ
        i * kron([RY] + mid + [i * RY]),                     # kronecker_multilinear（j → 1, c → i）
        i * (i * kron([RY] + mid + [RY])),                   # kronecker_multilinear（j → M_col, c → i）
        (i * i) * kron([RY] + mid + [RY]),                   # scalar_multiple_is_associative
        K(-1) * kron([RY] + mid + [RY]),                     # ℂ で i·i = -1
        iota_scalar(-1) * kron([RY] + mid + [RY]),           # inclusion_rr_to_cc の略記 -1_C = ι(-1)
    ]
    for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
        assert a == b, f"M_col = {Mc}: 第 {k} 行と第 {k+1} 行が一致しない"
        count += 1
    # 続く段落: 因子 R^y・σ^x の成分は実 → クロネッカー積の成分は実 → (-1)_C 倍も実 → G の成分は実
    assert has_real_entries(RY) and has_real_entries(SX)
    P = kron([RY] + mid + [RY])
    assert has_real_entries(P)
    assert has_real_entries(iota_scalar(-1) * P)
    assert has_real_entries(G)
    # 否定コントロール: σ^y を第 1 因子だけに置いた並びは虚部 0 でない成分を持つ
    assert not has_real_entries(kron([SY] + mid + [SX]))
    negatives += 1
print(f"  {count} 段（M_col = 2..7 の 7 行の鎖）と、G・R^y⊠σ^x⊠⋯⊠σ^x⊠R^y の全成分の虚部 0（QQ[i] の厳密計算）")
print(f"  否定コントロール {negatives} 件: σ^y を 1 個だけ含む並びは虚部 0 でない成分を持つ")
print("RESULT: PASS")
