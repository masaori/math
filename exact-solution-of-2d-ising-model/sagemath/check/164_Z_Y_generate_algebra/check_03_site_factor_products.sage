# 対象ラベル: Z_Y_generate_algebra
# Step 3 の後半: e_1,...,e_M ∈ B = {I, σ^x, σ^y, σ^z} について E_k := I⊠…⊠e_k(第 k 因子)⊠…⊠I と置くとき、
# (1) e_k = I なら E_k = I_{Mat(2^M,C)}（kronecker_product_rule (2)）、
# (2) e_k = σ^x, σ^y, σ^z なら E_k = σ_k^x, σ_k^y, σ_k^z（def_site_pauli_matrices）。
#     σ_k^a はクロネッカー積を使わず、成分 (σ_k^a)_{s,t} = (σ^a)_{s_k,t_k} ∏_{j≠k} δ_{s_j,t_j} から独立に組み立てる。
# (3) P_1 := E_1, P_{s+1} := P_s E_{s+1} について、P_1 の鎖（2 行）と帰納の一段の鎖（6 行）を一行ずつ。
# を M = 1, 2, 3 と B^M の全ての組で確かめる。行列は QQ(i) 上で厳密に計算する。浮動小数点なし。
import sys, itertools

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
I2 = identity_matrix(K0, 2)
sx = matrix(K0, [[0, 1], [1, 0]])
sy = matrix(K0, [[0, -i], [i, 0]])
sz = matrix(K0, [[1, 0], [0, -1]])
B = [("I", I2), ("x", sx), ("y", sy), ("z", sz)]
pauli = dict(x=sx, y=sy, z=sz)

def kron(mats):  # def_kronecker: A_1 ⊠ … ⊠ A_M（Sage の tensor_product は第 1 因子が最上位の桁）
    out = mats[0]
    for m in mats[1:]:
        out = out.tensor_product(m)
    return out

def site(M, k, e):  # E_k: 第 k 因子だけが e（k は 0 始まり）
    return kron([e if j == k else I2 for j in range(M)])

def digits(M, s):  # 行番号 s の各因子の添字（第 1 因子が最上位の桁）
    return [(s >> (M - 1 - j)) & 1 for j in range(M)]

def sigma_site_entrywise(M, k, name):  # def_site_pauli_matrices の σ_k^a を成分から
    a = pauli[name]
    def entry(s, t):
        ds, dt = digits(M, s), digits(M, t)
        if any(ds[j] != dt[j] for j in range(M) if j != k):
            return K0(0)
        return a[ds[k], dt[k]]
    return matrix(K0, 2^M, 2^M, entry)

for M in (1, 2, 3):
    IM = identity_matrix(K0, 2^M)
    for k in range(M):
        check(site(M, k, I2) == IM, f"M={M} k={k+1}: e_k = I なら E_k = I_Mat(2^M)")
        for name, e in B[1:]:
            check(site(M, k, e) == sigma_site_entrywise(M, k, name), f"M={M} k={k+1}: e_k = σ^{name} なら E_k = σ_k^{name}")
    for es in itertools.product(B, repeat=M):
        e = [m for _, m in es]
        tag = "".join(n for n, _ in es)
        E = [site(M, k, e[k]) for k in range(M)]
        # P_1 の鎖: P_1 = E_1 = e_1⊠I⊠…⊠I
        P = E[0]
        chain_check([P, E[0], kron([e[0]] + [I2] * (M - 1))], f"M={M} e={tag} P_1")
        for s in range(1, M):  # P_s から P_{s+1}（s は 1 始まりの個数）
            hyp = kron(e[:s] + [I2] * (M - s))
            check(P == hyp, f"M={M} e={tag} 帰納法の仮定 P_{s}")
            lines = [
                P * E[s],
                hyp * kron([I2] * s + [e[s]] + [I2] * (M - s - 1)),
                kron([e[j] * I2 for j in range(s)] + [I2 * e[s]] + [I2 * I2] * (M - s - 1)),
                kron(e[:s] + [I2 * e[s]] + [I2 * I2] * (M - s - 1)),
                kron(e[:s] + [e[s]] + [I2 * I2] * (M - s - 1)),
                kron(e[:s + 1] + [I2] * (M - s - 1)),
            ]
            chain_check(lines, f"M={M} e={tag} P_{s+1}")
            P = P * E[s]
        check(P == prod(E, IM) and P == kron(e), f"M={M} e={tag}: P_M = E_1…E_M = e_1⊠…⊠e_M")

# 否定の対照（人手の行の書き間違いを入れると落ちること）
M = 2
e = [sx, sz]
E = [site(M, 0, e[0]), site(M, 1, e[1])]
check(E[1] * E[0] == E[0] * E[1] and kron([e[1], e[0]]) != E[0] * E[1],
      "否定の対照: 因子の順を逆にした e_2⊠e_1 は P_2 にならない")
check(kron([e[0], I2]) * kron([e[1], I2]) != E[0] * E[1],
      "否定の対照: E_2 の e_2 を第 1 因子へずらすと P_2 にならない")
check(sigma_site_entrywise(2, 0, "x") != site(2, 1, sx),
      "否定の対照: 第 2 因子の σ^x は σ_1^x ではない")
check(sigma_site_entrywise(2, 0, "y") != site(2, 0, sy).transpose(),
      "否定の対照: σ^y を転置すると σ_1^y ではない")

print(f"-- Z_Y_generate_algebra の Step 3 後半の E_k と積の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
