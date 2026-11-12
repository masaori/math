# 対象ラベル: claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism,
#   claim_inverse_reindexing_after_reindexing_of_matrices_is_identity, claim_reindexing_after_inverse_reindexing_of_matrices_is_identity,
#   claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism, theorem_binary_numbering_gives_isomorphism_of_matrix_algebras
# X:=P_M、(n,e):=(2^M,e_M) で ν_e(F)_{k,l}:=F_{e(k),e(l)}、μ_e(G)_{x,y}:=G_{e^{-1}(x),e^{-1}(y)} を作り、
# M=1,2,3 で乱数の種を固定した整数行列について、和・積・単位元・スカラー倍の保存と μν=id、νμ=id を確かめる。
# P_M で添字づけた行列は {(S,T): 値} の辞書で表し、積は定義どおり Σ_{z∈P_M} で計算する（ZZ の厳密計算）。
from itertools import combinations

def two_pow(M):
    return 1 if M == 0 else 2 * two_pow(M - 1)

def e(M, k):                                      # def_binary_numbering_of_power_set
    if M == 0:
        return frozenset()
    h = two_pow(M - 1)
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def delta(a, b):
    return ZZ(1) if a == b else ZZ(0)

for M in range(1, 4):
    n = two_pow(M)
    X = power_set(M)
    ee = {k: e(M, k) for k in range(1, n + 1)}
    einv = {ee[k]: k for k in ee}
    add = lambda F, G: {xy: F[xy] + G[xy] for xy in F}
    mul = lambda F, G: {(x, y): sum(F[(x, z)] * G[(z, y)] for z in X) for x in X for y in X}   # 行列の積（Σ_{z∈X}）
    smul = lambda c, F: {xy: c * F[xy] for xy in F}
    one = {(x, y): delta(x, y) for x in X for y in X}
    nu = lambda F: matrix(ZZ, n, n, lambda k, l: F[(ee[k + 1], ee[l + 1])])                  # def_reindexing_of_matrices_by_numbering
    mu = lambda G: {(x, y): G[einv[x] - 1, einv[y] - 1] for x in X for y in X}               # def_reindexing_of_matrices_by_inverse_numbering
    set_random_seed(20261112 + M)
    for trial in range(4):
        F = {(x, y): ZZ.random_element(-5, 6) for x in X for y in X}
        G = {(x, y): ZZ.random_element(-5, 6) for x in X for y in X}
        c = ZZ.random_element(-7, 8)
        assert nu(add(F, G)) == nu(F) + nu(G)                     # 加法を保つ
        assert nu(mul(F, G)) == nu(F) * nu(G)                     # 乗法を保つ
        assert nu(smul(c, F)) == c * nu(F)                        # スカラー倍を保つ
        assert mu(nu(F)) == F                                     # μ∘ν=id
        Gm = random_matrix(ZZ, n, n, x=-5, y=6)
        Hm = random_matrix(ZZ, n, n, x=-5, y=6)
        assert nu(mu(Gm)) == Gm                                   # ν∘μ=id
        assert mu(Gm + Hm) == add(mu(Gm), mu(Hm))
        assert mu(Gm * Hm) == mul(mu(Gm), mu(Hm))
        assert mu(c * Gm) == smul(c, mu(Gm))
    assert nu(one) == identity_matrix(ZZ, n)                      # 乗法の単位元を保つ
    assert mu(identity_matrix(ZZ, n)) == one
    # 否定の対照: 列だけを別の全単射 k ↦ e_M(n+1-k) で付け替えると、積も単位元も保たれない
    rev = lambda F: matrix(ZZ, n, n, lambda k, l: F[(ee[k + 1], ee[n - l])])
    F = {(x, y): ZZ.random_element(-5, 6) for x in X for y in X}
    G = {(x, y): ZZ.random_element(-5, 6) for x in X for y in X}
    assert rev(one) != identity_matrix(ZZ, n)
    assert rev(mul(F, G)) != rev(F) * rev(G)
print("PASS reindexing-of-matrices-by-binary-numbering M=1,2,3")
