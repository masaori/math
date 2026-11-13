# 対象ラベル: Z_Y_linearly_independent
# Step 3（Z_m・Y_m のクロネッカー積による表示）を一行ずつ確かめる。行は等号の行で数える。
# (1) (k): m ∈ {1..M}、j ∈ {1..m} の F_j^{(z)} = σ_j^{a_j^{(z)}}・F_j^{(y)} = σ_j^{a_j^{(y)}} の各 2 行の鎖
#     （F_j^{(z)}・F_j^{(y)} は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の因子で、Step 2 の F_q とは別の記号、a_j^{(z)}・a_j^{(y)} は Step 3 の定義）。
# (2) Z_m・Y_m の各 4 行の鎖。Z_m・Y_m は定義どおり Π_{j=1}^{m}F_j^{(z)}・Π_{j=1}^{m}F_j^{(y)} で組み、site_pauli_prefix_product_kronecker_form の行の右辺は
#     def_kronecker の成分の式で組む（Sage の tensor_product とも比べる）。
# σ_k^a は def_site_pauli_matrices（第 k 因子だけ σ^a、他は I）を def_kronecker の成分の式で組む。M = 1, 2, 3, 4。QQ(i) で厳密。
# 否定の対照: (k) で a_m^{(z)} を x と読むと F_m^{(z)} と合わない、Z_m の最後の行の σ^z の位置を 1 つずらすと合わない。
# Z_m・Y_m の左辺は、定義の式 σ_1^x⋯σ_{m-1}^xσ_m^{z,y} を F_j^{(z)}・F_j^{(y)} を経ずに site と reduce で別に組み、比べる。
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

    # (1)(2)
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
            lines = [fprod([F[j] for j in range(1, m + 1)]),            # 左辺 Z_m := Π F_j^{(z)}、Y_m := Π F_j^{(y)}（定義）
                     fprod([F[j] for j in range(1, m + 1)]),            # def_jordan_wigner_*_matrices
                     fprod([site(a[j], j) for j in range(1, m + 1)]),   # (k)
                     kron([pauli[a[j]] for j in range(1, m + 1)] + [Id] * (M - m)),   # site_pauli_prefix_product_kronecker_form
                     kron([pauli["x"]] * (m - 1) + [pauli[last]] + [Id] * (M - m))]  # a の定義
            chain_check(lines, f"{tag} {lab}_{m} の鎖")
            direct = reduce(lambda X, Y: X * Y, [site("x", k) for k in range(1, m)] + [site(last, m)])
            check(direct == lines[0], f"{tag} {lab}_{m} の左辺 Π F_j^({last}) が定義の式 σ_1^x⋯σ_m^{last} を別に組んだものと一致")
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
