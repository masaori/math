# 対象ラベル: T_V_plus_eq_T_check_Vprime の検算の準備。
# 数体の組み方・ψ̌ の作り方・ボールへの埋め込み・行列の exp のボールは、T_V_plus_eq_T_check_Vprime_on_check_Z_Y の検算の準備を
# そのまま読み込んで使う（K_1 = 2 log y、K_2 = log x と選び、S = exp(X)・V_2・Ž_μ・Y̌_μ・位相を一つの数体 F に置く）。
# この検算で足したもの: 実空間の Z_j・Y_j（pauli_sites_exact.sage の jw を F へ移したもの）、復元公式の係数、
#   T'_g（mat_conj の T_B を B → g に取ったもの）、V^{(+)} を F の中で直接作る組。
load("../T_V_plus_eq_T_check_Vprime_on_check_Z_Y/_prelude.sage")


class Recovery:
    """一つの (M_col, x, y) について、F の中に Z_j・Y_j・Ž_μ・Y̌_μ・c := (M_col)_C^{-1}・a_{jμ} := exp(i(j_R θ̃_μ)_C) と V^{(+)} を持つ。"""

    def __init__(self, f):
        self.f = f
        F, M, n = f.F, f.M, f.n
        self.F, self.M, self.n = F, M, n
        J = list(range(1, M + 1))
        self.J = J
        self.Zr = {j: f.kg_to_F(jw(M, j, 'z')) for j in J}        # Z_j（def_transfer_matrix_symbols）
        self.Yr = {j: f.kg_to_F(jw(M, j, 'y')) for j in J}
        self.Zc, self.Yc = f.Zc, f.Yc                             # Ž_μ・Y̌_μ（def_half_integer_checkZ / checkY の和で作ったもの）
        self.c = F(M)**(-1)                                        # (M_col)_C^{-1}
        assert self.c * F(M) == 1
        self.emb = embedding_to_qqbar(f)
        # a_{jμ} = exp(i(j_R θ̃_μ)_C) = ζ_{4M}^{2(2μ-1)j}。QQbar の E(j θ̃_μ/(2π)) と一致することを毎回確かめる。
        self.a = {(j, mu): f.phase(mu, j) for j in J for mu in J}
        for (j, mu), v in self.a.items():
            assert self.emb(v) == E(j * theta_over_2pi(M, mu))
        I = body_identity(F, n)
        self.I = I
        self.S, self.Sinv = f.expX, f.expmX
        self.V2 = f.V2
        self.V2inv = self.V2.inverse()
        assert body_product(self.S, self.Sinv) == I and body_product(self.Sinv, self.S) == I
        assert body_product(self.V2, self.V2inv) == I and body_product(self.V2inv, self.V2) == I
        # def_V_plus の V^{(+)} := (S V_2) S と、その逆元 (S^{-1} V_2^{-1}) S^{-1}（def_invertible_elements_of_R (ii)）
        self.V = body_product(body_product(self.S, self.V2), self.S)
        self.Vinv = body_product(body_product(self.Sinv, self.V2inv), self.Sinv)
        assert body_product(self.V, self.Vinv) == I and body_product(self.Vinv, self.V) == I

    def T_composite(self, X):
        """def_T_V_plus の T_{(V^{(+)})}(X) := T_S(T_{V_2}(T_S(X)))。"""
        return conj_body(self.S, conj_body(self.V2, conj_body(self.S, X, self.Sinv), self.V2inv), self.Sinv)

    def T_g_Vplus(self, X):
        """def_T_g の T_{V^{(+)}}(X) = (V^{(+)}X)(V^{(+)})^{-1}。"""
        return conj_body(self.V, X, self.Vinv)

    def Tprime_Vplus(self, X):
        """T'_{V^{(+)}}(X) := (V^{(+)}X)(V^{(+)})^{-1}（mat_conj の T_B、B → V^{(+)}）。def_T_g と同じ式なので独立な確認ではない。"""
        return body_product(body_product(self.V, X), self.Vinv)

    def pairs(self):
        """準備 2 の対応する組 (W, U) = (Ž, Z), (Y̌, Y)。"""
        return [("Z", self.Zc, self.Zr), ("Y", self.Yc, self.Yr)]

    def recovered(self, W, j):
        """c Σ_μ a_{jμ} W_μ（スカラー倍・有限和は本文の成分の式）。"""
        return body_scalar(self.c, body_finite_sum([body_scalar(self.a[(j, mu)], W[mu]) for mu in self.J]))


def sample_elements(rc):
    """Step 2 の x, y に使う R の元: 生成元の積と、成分が小さい整数と i の組の行列。"""
    F, n, i = rc.F, rc.n, rc.f.i
    xs = [body_product(rc.Zr[1], rc.Yr[rc.M]), body_sum(rc.Yr[1], body_scalar(i, rc.Zr[2]))]
    gen = matrix(F, n, n, lambda r_, c_: F(((3 * r_ + 5 * c_) % 7) - 3) + F(((r_ * c_) % 5) - 2) * i)
    xs.append(gen)
    return xs
