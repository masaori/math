# 対象ラベル: site_pauli_prefix_product_kronecker_form
# s = 1 の鎖（2 行）と s → s+1 の鎖（6 行）を、M_col = 1..4、全ての r と (a_1,…,a_r) ∈ {x,y,z}^r で厳密に。
# 左辺の Π_{j=1}^{s}σ_j^{a_j} は def_finite_product_of_matrices（Π^1 := A_1、Π^{s+1} := (Π^s)A_{s+1}）どおり
# body_product を左から重ねて毎回組み直す（fprod）。
# 各行の両辺: s = 1 の第 1 行は Π^1 の定義、第 2 行は def_site_pauli_matrices の k = 1。
# s → s+1 の第 1 行は Π^{s+1} := (Π^s)σ_{s+1}^{a_{s+1}}、第 2 行は二つのクロネッカー積の積、
# 第 3〜6 行は因子ごとの 2 次の積をその行の形どおりに組んだクロネッカー積（def_kronecker の成分の式）。
load("_prelude.sage")
import itertools

def fprod(As):
    acc = As[0]
    for A in As[1:]:
        acc = body_product(acc, A)
    return acc

total = 0
for M in [1, 2, 3, 4]:
    for r in range(1, M + 1):
        for a in itertools.product('xyz', repeat=r):
            sig = [site(M, j, a[j - 1]) for j in range(1, r + 1)]   # σ_1^{a_1}, …, σ_r^{a_r}
            check_chain([fprod(sig[:1]), sig[0], kron([PAULI[a[0]]] + [I2] * (M - 1))], f"M={M} a={a} s=1")
            for s in range(1, r):
                left = [PAULI[a[k]] for k in range(s)] + [I2] * (M - s)
                right = [I2] * s + [PAULI[a[s]]] + [I2] * (M - s - 1)
                assert fprod(sig[:s]) == kron(left)               # 帰納法の仮定（s で成り立つこと）
                lines = [fprod(sig[:s + 1]),
                         body_product(fprod(sig[:s]), sig[s]),
                         body_product(kron(left), kron(right)),
                         kron([body_product(PAULI[a[k]], I2) for k in range(s)] + [body_product(I2, PAULI[a[s]])] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s)] + [body_product(I2, PAULI[a[s]])] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s + 1)] + [body_product(I2, I2)] * (M - s - 1)),
                         kron([PAULI[a[k]] for k in range(s + 1)] + [I2] * (M - s - 1))]
                check_chain(lines, f"M={M} a={a} s={s}")
            assert fprod(sig) == kron([PAULI[x] for x in a] + [I2] * (M - r))
            assert prefix_product(M, list(a)) == fprod(sig)
            total += 1
# 定義を開く行（s = 1 と s → s+1 の第 1 行）は fprod の実装そのものなので、両辺は同じ式から作られる。
# 漸化式が積の順序を見ていることは、σ_j^{a_j}（相異なるサイトで可換）では見分けられないので、
# 一般の非可換な行列で、左から掛けた fprod と逆順に掛けた積が合わないことを否定の対照として確かめる。
for M in [2, 3, 4]:
    set_random_seed(20261113 + M)
    A = [random_matrix(ZZ, 2^M, 2^M, x=-3, y=4).change_ring(KG) for _ in range(M)]
    rev = A[0]
    for s in range(1, M):
        rev = body_product(A[s], rev)
    assert fprod(A) != rev, f"否定の対照: M={M} で逆順の積が左から掛けた積と一致した"
print(f"  M_col=1..4 の {total} 通りの (r, a) で、帰納法の各行と主張が成り立つ")
print("RESULT: PASS")
