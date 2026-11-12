# 対象ラベル: Z_Y_generate_algebra
# Step 2 の鎖を一行ずつ確かめる。
# (1) P_0 := I、P_r := P_{r-1}σ_r^x（1 ≤ r ≤ M）の積の表示 P_r = ∏_{j=1}^{r} σ_j^x: r = 1 の 4 行と一段の 3 行。
# (2) 可換の式 σ_k^xP_r = P_rσ_k^x（r ∈ {0,…,k-1}）: r = 0 の 4 行と、一段（r+1 ≤ k-1）の 7 行。
# (3) 二乗の式 P_rP_r = I（r ∈ {0,…,M}）: r = 0 の 2 行と、一段（r+1 ≤ M）の 8 行。
# (4) Z_m = P_{m-1}σ_m^z・Y_m = P_{m-1}σ_m^y の 4 行と P_{m-1}Z_m = σ_m^z・P_{m-1}Y_m = σ_m^y の 4 行（m ≥ 2）。
# (5) m = 1 の段の Z_1 = σ_1^z・Y_1 = σ_1^y と σ_1^x の 2 行。
# M = 1, 2, 3 と全ての k, r, m で。σ_k^a はクロネッカー積を使わず成分から独立に組み立てる。
# 行列は QQ(i) 上で厳密に計算する。浮動小数点なし。

import sys

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

K0.<i> = QuadraticField(-1)
sx = matrix(K0, [[0, 1], [1, 0]])
sy = matrix(K0, [[0, -i], [i, 0]])
sz = matrix(K0, [[1, 0], [0, -1]])
pauli = dict(x=sx, y=sy, z=sz)

def digits(M, s):
    return [(s >> (M - 1 - j)) & 1 for j in range(M)]

def sigma(M, k, name):  # def_site_pauli_matrices の σ_k^a（k は 1 始まり）を成分から
    a = pauli[name]
    def entry(s, t):
        ds, dt = digits(M, s), digits(M, t)
        if any(ds[j] != dt[j] for j in range(M) if j != k - 1):
            return K0(0)
        return a[ds[k - 1], dt[k - 1]]
    return matrix(K0, 2^M, 2^M, entry)

for M in [1, 2, 3]:
    I = identity_matrix(K0, 2^M)
    sX = {k: sigma(M, k, "x") for k in range(1, M + 1)}
    # (1) P_r の再帰の定義と、積の表示 P_r = ∏_{j=1}^{r} σ_j^x（def_finite_product_of_matrices: ∏^1 := A_1、∏^{r+1} := (∏^r)A_{r+1}）
    P = {0: I}
    for r in range(1, M + 1):
        P[r] = P[r - 1] * sX[r]
    prodX = {1: sX[1]}  # def_finite_product_of_matrices の初項（I から始めない）
    for r in range(1, M):
        prodX[r + 1] = prodX[r] * sX[r + 1]
    chain_check([P[1], P[0] * sX[1], I * sX[1], sX[1], prodX[1]], f"M={M} 積の表示 r=1")
    for r in range(1, M):
        chain_check([P[r + 1], P[r] * sX[r + 1], prodX[r] * sX[r + 1], prodX[r + 1]],
                    f"M={M} 積の表示 一段 r={r}")
        check(P[r] == prodX[r], f"M={M} r={r}: 帰納法の仮定（積の表示）")
    # (2) 可換の式
    for k in range(1, M + 1):
        chain_check([sX[k] * P[0], sX[k] * I, sX[k], I * sX[k], P[0] * sX[k]],
                    f"M={M} k={k} 可換の式 r=0")
        for r in range(0, k - 1):  # r+1 ≤ k-1
            check(r + 1 != k, f"M={M} k={k} r={r}: r+1 ≠ k")
            chain_check([
                sX[k] * P[r + 1],
                sX[k] * (P[r] * sX[r + 1]),
                (sX[k] * P[r]) * sX[r + 1],
                (P[r] * sX[k]) * sX[r + 1],
                P[r] * (sX[k] * sX[r + 1]),
                P[r] * (sX[r + 1] * sX[k]),
                (P[r] * sX[r + 1]) * sX[k],
                P[r + 1] * sX[k],
            ], f"M={M} k={k} 可換の式 一段 r={r}")
            check(sX[k] * P[r] == P[r] * sX[k], f"M={M} k={k} r={r}: 帰納法の仮定（可換の式）")
            check(sX[k] * sX[r + 1] == sX[r + 1] * sX[k],
                  f"M={M} k={k} r={r}: 引いた distinct_site_pauli_matrices_commute の場合")
    # (3) 二乗の式
    chain_check([P[0] * P[0], I * I, I], f"M={M} 二乗の式 r=0")
    for r in range(0, M):  # r+1 ≤ M
        chain_check([
            P[r + 1] * P[r + 1],
            (P[r] * sX[r + 1]) * (P[r] * sX[r + 1]),
            P[r] * (sX[r + 1] * (P[r] * sX[r + 1])),
            P[r] * ((sX[r + 1] * P[r]) * sX[r + 1]),
            P[r] * ((P[r] * sX[r + 1]) * sX[r + 1]),
            P[r] * (P[r] * (sX[r + 1] * sX[r + 1])),
            P[r] * (P[r] * I),
            P[r] * P[r],
            I,
        ], f"M={M} 二乗の式 一段 r={r}")
        check(sX[r + 1] * sX[r + 1] == I, f"M={M} r={r}: 引いた Step 1 の σ_k^xσ_k^x = I（k → r+1）")
    # (4) Z_m = P_{m-1}σ_m^z・Y_m = P_{m-1}σ_m^y の 4 行と、P_{m-1}Z_m・P_{m-1}Y_m の 4 行（m ≥ 2）。
    #     Z_m・Y_m はクロネッカー積 σ^x⊠⋯⊠σ^x⊠σ^a⊠I⊠⋯⊠I を Sage の tensor_product で組み（σ_k^a の成分の組み立てとは独立）、
    #     ∏_{j=1}^{m} A_j（A_j = σ_j^x (j < m)、A_m = σ_m^a）と一致することを確かめる。
    for m in range(2, M + 1):
        for name in ["z", "y"]:
            sA = sigma(M, m, name)
            facs = [sx] * (m - 1) + [pauli[name]] + [identity_matrix(K0, 2)] * (M - m)
            JW = facs[0]
            for f in facs[1:]:
                JW = JW.tensor_product(f)
            A = {j: (sX[j] if j < m else sA) for j in range(1, m + 1)}
            prodA = {1: A[1]}
            for r in range(1, m):
                prodA[r + 1] = prodA[r] * A[r + 1]
            chain_check([JW, prodA[m], prodA[m - 1] * A[m], prodX[m - 1] * sA, P[m - 1] * sA],
                        f"M={M} m={m} σ^{name}: Jordan–Wigner 行列 = P_(m-1)σ_m")
            chain_check([P[m - 1] * JW, P[m - 1] * (P[m - 1] * sA), (P[m - 1] * P[m - 1]) * sA, I * sA, sA],
                        f"M={M} m={m} P_(m-1)·(σ^{name} の Jordan–Wigner 行列)")

# (5) m = 1 の段: Z_1 = σ_1^z・Y_1 = σ_1^y（def_jordan_wigner_*_matrices の m = 1 の規約。Z_1・Y_1 は tensor_product で独立に組む）と、
#     σ_1^x = (-i)(σ_1^yσ_1^z) = (-i)(Y_1Z_1) の 2 行を M = 1, 2, 3 で。
for M in [1, 2, 3]:
    def jw1(a):
        out = a
        for _ in range(M - 1):
            out = out.tensor_product(identity_matrix(K0, 2))
        return out
    Z1, Y1 = jw1(sz), jw1(sy)
    s1x, s1y, s1z = sigma(M, 1, "x"), sigma(M, 1, "y"), sigma(M, 1, "z")
    check(Z1 == s1z, f"M={M}: Z_1 = σ_1^z")
    check(Y1 == s1y, f"M={M}: Y_1 = σ_1^y")
    chain_check([s1x, (-i) * (s1y * s1z), (-i) * (Y1 * Z1)], f"M={M} m=1 の σ_1^x")

# 否定の対照（人手の行の書き間違いを入れると落ちること）
M = 2
I = identity_matrix(K0, 4)
s1, s2 = sigma(M, 1, "x"), sigma(M, 2, "x")
check(s1 * sigma(M, 1, "z") != sigma(M, 1, "z") * s1,
      "否定の対照: 可換の式を同じサイトの σ^x と σ^z に当てると成り立たない")
check((s1 * s2) * (s1 * sigma(M, 2, "z")) != sigma(M, 2, "z"),
      "否定の対照: P_1 の代わりに P_2 を掛けると σ_2^z に戻らない（P_(m-1) の添字を誤る）")
check((s1 * sigma(M, 1, "z")) * (s1 * sigma(M, 1, "z")) != I,
      "否定の対照: 可換でない 2 つの対合（同じサイトの σ^x と σ^z）の積では二乗の式が成り立たない（可換性の仮定を外すと偽になる例）")
print(f"-- Z_Y_generate_algebra の Step 2 の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
