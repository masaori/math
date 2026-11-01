# 本文 def_end_iso の写像 end: Mat(2^M, C) → End(F)（F = C^{2^M}）を、定義の文言どおりに作る。
# end_agrees_with_matrix_vector_product と end_preserves_matrix_exponential の検算が使う。
#
# 定義の文言: f_I := e_{i_1} ⊠ … ⊠ e_{i_M}、E_{I,J} := E_{i_1 j_1} ⊠ … ⊠ E_{i_M j_M}（def_kronecker のクロネッカー積）、
# Θ_{I,J} は基底 (f_K) 上で Θ_{I,J}(f_K) := f_I（K = J）、0（K ≠ J）と定めた線型写像、
# end は基底 (E_{I,J}) 上で end(E_{I,J}) := Θ_{I,J} と定めて線型に拡張した写像。
#
# ここでの作り方:
#   - クロネッカー積は def_kronecker の成分の式 (v_1⊠…⊠v_M)_{ν(I)} := Π_k (v_k)_{i_k} を直接書く。
#     Sage の tensor_product は対照にだけ使う。
#   - 行列 X の基底 (E_{I,J}) での座標と、数ベクトル g の基底 (f_K) での座標は、基底のベクトルを並べた
#     行列の逆行列（QQ 上で厳密に求める）を掛けて求める。行列と数ベクトルの積が end の値と一致する
#     という、検算の対象の主張そのものは使わない。
#   - end(X)(g) := Σ_{I,J} c_{I,J}(X) Θ_{I,J}(g)、Θ_{I,J}(g) := Σ_K d_K(g) [K = J] f_I。
# 添字は本文の 1 始まりで持つ。多重添字 I は Python のタプル (i_1, …, i_M) で、各 i_m ∈ {1, 2}。
import itertools


def multi_indices(M):
    """本文 def_kronecker の添字集合 I_M = {1,2}^M。並べ順は itertools.product の順（ν の順と一致させない）。"""
    return list(itertools.product([1, 2], repeat=M))


def nu(I):
    """本文 def_kronecker の ν(I) := 1 + Σ_k (i_k - 1) 2^{M-k}。"""
    M = len(I)
    return 1 + sum((I[k - 1] - 1) * 2^(M - k) for k in range(1, M + 1))


def nu_reversed(I):
    """対照用の別の全単射（ビットの並びを逆にしたもの）。本文の ν ではない。"""
    return nu(tuple(reversed(I)))


def std_basis_C2(R, i):
    """C^2 の標準基底 e_1 = (1,0)、e_2 = (0,1)。"""
    return vector(R, [1 if j == i else 0 for j in (1, 2)])


def matrix_unit_2(R, i, j):
    """Mat(2, C) の行列単位 E_ij。"""
    return matrix(R, 2, 2, lambda p, q: 1 if (p + 1, q + 1) == (i, j) else 0)


def kron_vectors(R, vs, index_map=nu):
    """def_kronecker (1): (v_1⊠…⊠v_M)_{ν(I)} := Π_k (v_k)_{i_k}。"""
    M = len(vs)
    w = [R(0)] * (2^M)
    for I in multi_indices(M):
        w[index_map(I) - 1] = prod(vs[k][I[k] - 1] for k in range(M))
    return vector(R, w)


def kron_matrices(R, As, index_map=nu):
    """def_kronecker (2): (A_1⊠…⊠A_M)_{ν(I),ν(J)} := Π_k (A_k)_{i_k j_k}。"""
    M = len(As)
    X = matrix(R, 2^M, 2^M)
    for I in multi_indices(M):
        for J in multi_indices(M):
            X[index_map(I) - 1, index_map(J) - 1] = prod(As[k][I[k] - 1, J[k] - 1] for k in range(M))
    return X


def f_basis(R, M, index_map=nu):
    """f_I := e_{i_1} ⊠ … ⊠ e_{i_M}。辞書 I ↦ f_I。"""
    return {I: kron_vectors(R, [std_basis_C2(R, i) for i in I], index_map) for I in multi_indices(M)}


def E_basis(R, M, index_map=nu):
    """E_{I,J} := E_{i_1 j_1} ⊠ … ⊠ E_{i_M j_M}。辞書 (I, J) ↦ E_{I,J}。"""
    return {(I, J): kron_matrices(R, [matrix_unit_2(R, I[k], J[k]) for k in range(M)], index_map)
            for I in multi_indices(M) for J in multi_indices(M)}


class EndByDefinition:
    """M を固定し、end(X)(g) を定義の文言どおりに計算する。index_map を替えると対照用の別の並べ方になる。"""

    def __init__(self, M, index_map=nu):
        self.M = M
        self.index_map = index_map
        self.idx = multi_indices(M)
        fq = f_basis(QQ, M, index_map)
        Eq = E_basis(QQ, M, index_map)
        self.pairs = [(I, J) for I in self.idx for J in self.idx]
        # 基底のベクトルを列に並べた行列と、その逆行列（QQ 上で厳密）
        self.F_cols_inv = matrix(QQ, [list(fq[K]) for K in self.idx]).transpose().inverse()
        self.E_cols_inv = matrix(QQ, [Eq[P].list() for P in self.pairs]).transpose().inverse()
        self._fb = {}

    def _f_basis(self, R):
        if R not in self._fb:
            self._fb[R] = f_basis(R, self.M, self.index_map)
        return self._fb[R]

    def f(self, R, I):
        return self._f_basis(R)[I]

    def coords_of_vector(self, g):
        """g = Σ_K d_K f_K の d_K。辞書 K ↦ d_K。"""
        d = self.F_cols_inv.change_ring(g.base_ring()) * g
        return {K: d[n] for n, K in enumerate(self.idx)}

    def coords_of_matrix(self, X):
        """X = Σ_{I,J} c_{I,J} E_{I,J} の c_{I,J}。辞書 (I, J) ↦ c_{I,J}。"""
        c = self.E_cols_inv.change_ring(X.base_ring()) * vector(X.base_ring(), X.list())
        return {P: c[n] for n, P in enumerate(self.pairs)}

    def theta(self, I, J, g, d=None):
        """Θ_{I,J}(g) := Σ_K d_K(g) Θ_{I,J}(f_K)、Θ_{I,J}(f_K) := f_I（K = J）、0（K ≠ J）。
        d に g の座標を渡すと座標の計算を省く。"""
        R = g.base_ring()
        if d is None:
            d = self.coords_of_vector(g)
        fb = self._f_basis(R)
        out = vector(R, [0] * (2^self.M))
        for K in self.idx:
            if K == J:
                out = out + d[K] * fb[I]
        return out

    def apply(self, X, g):
        """end(X)(g) := Σ_{I,J} c_{I,J}(X) Θ_{I,J}(g)（end は end(E_{I,J}) := Θ_{I,J} の線型な拡張）。"""
        R = g.base_ring()
        c = self.coords_of_matrix(X.change_ring(R))
        d = self.coords_of_vector(g)
        out = vector(R, [0] * (2^self.M))
        for (I, J) in self.pairs:
            out = out + c[(I, J)] * self.theta(I, J, g, d)
        return out
