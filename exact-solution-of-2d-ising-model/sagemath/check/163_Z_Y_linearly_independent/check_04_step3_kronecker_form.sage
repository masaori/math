# 対象ラベル: Z_Y_linearly_independent
# Step 3（Z_m・Y_m のクロネッカー積による表示）を一行ずつ確かめる。行は等号の行で数える。
# (1) (h): r ∈ {1..M}、a_1..a_r ∈ {x,y,z} の全ての組について、s ∈ {1..r} の Π_{j=1}^{s} σ_j^{a_j} = P_s の鎖
#     （s = 1 の 2 行、s → s+1 の 3 行）。Π は def_finite_product_of_matrices（Π^1 := A_1、Π^{s+1} := (Π^s)A_{s+1}）、
#     P_s は site_pauli_prefix_product_kronecker_form の P_1 := σ_1^{a_1}、P_{s+1} := P_sσ_{s+1}^{a_{s+1}} で、別々に組む。
# (2) (k): m ∈ {1..M}、j ∈ {1..m} の F_j^{(z)} = σ_j^{a_j^{(z)}}・F_j^{(y)} = σ_j^{a_j^{(y)}} の各 2 行の鎖
#     （F_j は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の因子、a_j^{(z)}・a_j^{(y)} は Step 3 の定義）。
# (3) Z_m・Y_m の各 5 行の鎖。Z_m・Y_m は定義どおり Π_{j=1}^{m}F_j で組み、site_pauli_prefix_product_kronecker_form の行の右辺は
#     def_kronecker の成分の式で組む（Sage の tensor_product とも比べる）。
# σ_k^a は def_site_pauli_matrices（第 k 因子だけ σ^a、他は I）を def_kronecker の成分の式で組む。M = 1, 2, 3, 4。QQ(i) で厳密。
# 否定の対照: (k) で a_m^{(z)} を x と読むと F_m^{(z)} と合わない、Z_m の最後の行の σ^z の位置を 1 つずらすと合わない。
# σ_j^{a_j} は相異なるサイトで可換なので (h) の鎖は積の順序を見分けない。漸化式が順序を見ていることは、一般の非可換な行列で
# 逆順に掛けた積が合わないことで別に確かめる。Z_m・Y_m の左辺は、定義の式 σ_1^x⋯σ_{m-1}^xσ_m^{z,y} を F_j を経ずに site と reduce で別に組み、比べる。
import itertools
from functools import reduce

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
        print("FAIL " + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k} 式 = 第 {k+1} 式（左辺を第 0 式とし、等号の第 {k+1} 行）")

K0.<i> = QuadraticField(-1)
Id = matrix(K0, [[1, 0], [0, 1]])
pauli = {"x": matrix(K0, [[0, 1], [1, 0]]), "y": matrix(K0, [[0, -i], [i, 0]]), "z": matrix(K0, [[1, 0], [0, -1]])}

def run(M):
    D = 2^M
    idx = list(itertools.product([0, 1], repeat=M))      # def_kronecker の ν の順（辞書式）
    def kron(As):                                        # def_kronecker: (A_1⊠⋯⊠A_M)_{ν(I),ν(J)} = Π_k (A_k)_{i_k j_k}
        return matrix(K0, D, D, lambda r, c: prod(As[k][idx[r][k], idx[c][k]] for k in range(M)))
    def site(a, k):                                      # def_site_pauli_matrices: σ_k^a
        return kron([pauli[a] if kk == k else Id for kk in range(1, M + 1)])
    def fprod(As):                                       # def_finite_product_of_matrices: 左から掛ける
        acc = As[0]
        for A in As[1:]:
            acc = acc * A
        return acc
    tag = f"M={M}"
    check(all(kron(As) == reduce(lambda A, B: A.tensor_product(B), As)
              for As in [[pauli["x"]] * M, [pauli["y"]] + [Id] * (M - 1), [Id] * M]),
          f"{tag} def_kronecker の成分の式が Sage の tensor_product と一致")

    # (1) (h)
    for r in range(1, M + 1):
        for a in itertools.product("xyz", repeat=r):
            P = {1: site(a[0], 1)}                        # P_1 := σ_1^{a_1}
            for s in range(1, r):
                P[s + 1] = P[s] * site(a[s], s + 1)       # P_{s+1} := P_s σ_{s+1}^{a_{s+1}}
            chain_check([fprod([site(a[0], 1)]), site(a[0], 1), P[1]], f"{tag} (h) s=1 a={a}")
            for s in range(1, r):
                chain_check([fprod([site(a[j - 1], j) for j in range(1, s + 2)]),
                             fprod([site(a[j - 1], j) for j in range(1, s + 1)]) * site(a[s], s + 1),
                             P[s] * site(a[s], s + 1),
                             P[s + 1]], f"{tag} (h) s={s}→{s+1} a={a}")
    # 否定の対照: σ_j^{a_j} は相異なるサイトで互いに可換なので、σ 行列のままでは (h) の鎖は積の順序を見分けない。
    # 同じ漸化式（Π^1 := A_1、Π^{s+1} := (Π^s)A_{s+1}）を一般の非可換な 2^M 次の行列 A_j で組み、
    # 逆順に掛けた積（A_{s+1}(Π^s)）が左から掛けた P_s と合わないことを確かめる。
    if M >= 2:
        set_random_seed(20261113 + M)
        A = [random_matrix(ZZ, D, D, x=-3, y=4).change_ring(K0) for _ in range(M)]
        Pg = A[0]; Rg = A[0]
        for s in range(1, M):
            Pg = Pg * A[s]; Rg = A[s] * Rg
        check(fprod(A) == Pg, f"{tag} 一般の行列で Π と P の漸化式が一致")
        check(Rg != Pg, f"{tag} 否定の対照: 一般の行列では逆順に掛けた積が P と合わない")

    # (2)(3)
    for m in range(1, M + 1):
        az = {j: ("x" if j < m else "z") for j in range(1, m + 1)}
        ay = {j: ("x" if j < m else "y") for j in range(1, m + 1)}
        Fz = {j: (site("x", j) if j < m else site("z", m)) for j in range(1, m + 1)}
        Fy = {j: (site("x", j) if j < m else site("y", m)) for j in range(1, m + 1)}
        for j in range(1, m + 1):
            chain_check([Fz[j], site("x", j) if j < m else site("z", m), site(az[j], j)], f"{tag} (k) F_{j}^(z) m={m}")
            chain_check([Fy[j], site("x", j) if j < m else site("y", m), site(ay[j], j)], f"{tag} (k) F_{j}^(y) m={m}")
        check(site("x", m) != Fz[m], f"{tag} 否定の対照: a_m^(z) を x と読むと F_m^(z) と合わない m={m}")
        for (lab, a, F, last) in [("Z", az, Fz, "z"), ("Y", ay, Fy, "y")]:
            def Pm(aa):
                acc = site(aa[1], 1)
                for s in range(1, m):
                    acc = acc * site(aa[s + 1], s + 1)
                return acc
            lines = [fprod([F[j] for j in range(1, m + 1)]),            # 左辺 Z_m := Π F_j（定義）
                     fprod([F[j] for j in range(1, m + 1)]),            # def_jordan_wigner_*_matrices
                     fprod([site(a[j], j) for j in range(1, m + 1)]),   # (k)
                     Pm(a),                                             # (h)
                     kron([pauli[a[j]] for j in range(1, m + 1)] + [Id] * (M - m)),   # site_pauli_prefix_product_kronecker_form
                     kron([pauli["x"]] * (m - 1) + [pauli[last]] + [Id] * (M - m))]  # a の定義
            chain_check(lines, f"{tag} {lab}_{m} の鎖")
            direct = reduce(lambda X, Y: X * Y, [site("x", k) for k in range(1, m)] + [site(last, m)])
            check(direct == lines[0], f"{tag} {lab}_{m} の左辺 Π F_j が定義の式 σ_1^x⋯σ_m^{last} を別に組んだものと一致")
            check(lines[-1] == reduce(lambda A, B: A.tensor_product(B), [pauli["x"]] * (m - 1) + [pauli[last]] + [Id] * (M - m)),
                  f"{tag} {lab}_{m} の表示が Sage の tensor_product と一致")
            if M >= 2:
                shifted = kron([pauli["x"]] * (m - 1) + [Id] + [pauli[last]] + [Id] * (M - m - 1)) if m < M \
                    else kron([pauli["x"]] * (m - 2) + [pauli[last], pauli["x"]])
                check(shifted != lines[-1], f"{tag} 否定の対照: {lab}_{m} の σ^{last} の位置をずらすと合わない")

for M in [1, 2, 3, 4]:
    run(M)

print(f"checks: {n_check}, failures: {n_fail}")
if n_fail:
    print("RESULT: FAIL")
    raise SystemExit(1)
print("ALL PASS")
