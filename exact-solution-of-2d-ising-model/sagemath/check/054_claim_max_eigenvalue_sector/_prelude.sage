# ---------------------------------------------------------
# 共通: c_−(M) ≤ c_+(M) と c(M) = c_+(M) = Λ^{(1/2)}_M
#   structured-latex/content/019_max_eigenvalue_sector.ts に対応
#
#   ε        := σ^x_1 ⋯ σ^x_M                   (def_transfer_matrix_symbols)
#   W        := V_1^{1/2} V_2 V_1^{1/2}         (def_symmetrized_transfer_matrix)
#              V_1 = exp(K_1 Σ_{m=1}^{M} σ^z_m σ^z_{m+1}) は周期境界
#   F^{(±)}  := ε の固有値 ±1 の固有空間          (def_eigenspaces_of_epsilon)
#   c_±(M)   := sup{ x^T W x | x ∈ F^{(±)} ∩ R^{2^M}, ‖x‖ = 1 }
#   c(M)     := sup{ x^T W x | x ∈ R^{2^M}, ‖x‖ = 1 }
#   Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp( (1/2) Σ_{μ=1}^{M} γ(2π(μ−δ)/M) )
#
#   （053 の _prelude.sage と同じ理由で、別ディレクトリの prelude を load せず
#     自己完結させている。__file__ の解決が環境依存になるため。）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

TOL = 1e-8


def coeffs(K1, K2):
    K1 = RDF(K1); K2 = RDF(K2); K2s = K_star(K2)
    return {'K1': K1, 'K2': K2, 'K2s': K2s,
            'c1': RDF(cosh(2 * K1)), 's1': RDF(sinh(2 * K1)),
            'c2': RDF(cosh(2 * K2)), 's2': RDF(sinh(2 * K2)),
            'c2s': RDF(cosh(2 * K2s)), 's2s': RDF(sinh(2 * K2s))}


def g1(t, P):
    """γ_1(θ) = c_1 c_2* − s_1 s_2* cos θ"""
    return RDF(P['c1'] * P['c2s'] - P['s1'] * P['s2s'] * cos(RDF(t)))


def V2_mat(O, K2):
    """V_2 = (2 sinh 2K_2)^{M/2} exp(i K_2^* H_2)"""
    K2s = K_star(K2)
    A = CDF(I) * RDF(K2s) * O.H2
    pref = CDF((2 * RDF(sinh(2 * RDF(K2)))) ** (RDF(O.M) / 2))
    return pref * matrix(CDF, A.exp())


def D_periodic(O):
    """D = Σ_{m=1}^{M} σ^z_m σ^z_{m+1}（σ^z_{M+1} := σ^z_1）"""
    out = matrix(CDF, O.d, O.d, 0)
    for m in range(1, O.M + 1):
        mp = m + 1 if m < O.M else 1
        out = out + O.SZ[m] * O.SZ[mp]
    return matrix(CDF, out)


def W_op(O, K1, K2):
    """W = V_1^{1/2} V_2 V_1^{1/2}"""
    B = matrix(CDF, (RDF(K1) / 2 * D_periodic(O)).exp())
    return matrix(CDF, B * V2_mat(O, K2) * B)


def W_real(O, K1, K2):
    """W を実行列（RDF）として返す。W_is_real_symmetric_positive_definite により実対称。"""
    W = W_op(O, K1, K2)
    return matrix(RDF, [[W[i, j].real() for j in range(O.d)] for i in range(O.d)])


def eps_op(O):
    """ε = σ^x_1 ⋯ σ^x_M"""
    out = identity_matrix(CDF, O.d)
    for m in range(1, O.M + 1):
        out = out * O.SX[m]
    return matrix(CDF, out)


def eps_real(O):
    """ε を実行列（RDF）として返す。0/1 の置換行列である（check_01 で検証する）。"""
    E = eps_op(O)
    return matrix(RDF, [[E[i, j].real() for j in range(O.d)] for i in range(O.d)])


def flip_index(M, k):
    """ε が定める置換 π。標準基底の番号 k を「全スピン反転」の番号へ移す。"""
    return (2 ** M - 1) - k


def sector_basis(M, sgn):
    """F^{(±)} ∩ R^{2^M} の正規直交基底（実、列ベクトルとして並べた行列）。"""
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = sgn / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def rayleigh_sup(A_real):
    """実対称行列の Rayleigh 商の上限（= 最大固有値）。"""
    return max([RDF(CDF(z).real()) for z in A_real.eigenvalues()])


def rayleigh_argmax(A_real):
    """実対称行列の最大固有値と、それを達成する単位固有ベクトル。"""
    evals, evecs = A_real.eigenmatrix_right()
    d = A_real.nrows()
    vals = [RDF(CDF(evals[i, i]).real()) for i in range(d)]
    i0 = max(range(d), key=lambda i: vals[i])
    v = vector(RDF, [RDF(CDF(evecs[j, i0]).real()) for j in range(d)])
    return vals[i0], v / v.norm()


def Lambda_delta_M(O, P, delta):
    """Λ^{(δ)}_M = (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{μ=1}^{M} γ(2π(μ−δ)/M))"""
    M = O.M
    pref = RDF((2 * P['s2']) ** (RDF(M) / 2))
    s = RDF(0)
    for mu in range(1, M + 1):
        t = RDF(2 * pi * (RDF(mu) - RDF(delta)) / M)
        # 厳密な臨界点かつ δ = 0 では γ_1(θ_M) = 1 が理論値だが、倍精度では 1 を
        # わずかに下回りうる（arccosh の定義域外）。理論値どおり 1 で丸める。
        y = max(RDF(g1(t, P)), RDF(1))
        s = s + RDF(arccosh(y))
    return RDF(pref * exp(s / 2))


def K2_critical(K1):
    """sinh(2K_1) sinh(2K_2) = 1 を満たす K_2（厳密な臨界点）"""
    K1 = RDF(K1)
    return RDF(arcsinh(1 / sinh(2 * K1))) / 2


# パラメータ集合（臨界点上・臨界点近傍・一般点・高温側を含む）。053 と同じもの。
SEC_M = [2, 3, 4, 5]
SEC_PARAMS = [
    {'K1': RDF(0.4), 'K2': K2_critical(0.4)},                 # 厳密な臨界点（非等方）
    {'K1': RDF(0.4406867935097715),
     'K2': K2_critical(0.4406867935097715)},                  # 厳密な臨界点（等方 K1 = K2 = Kc）
    {'K1': RDF(0.44), 'K2': K2_critical(0.44) * (1 + 1e-6)},  # 臨界点近傍
    {'K1': RDF(0.4), 'K2': RDF(0.8)},                         # 一般点
    {'K1': RDF(1.2), 'K2': RDF(0.3)},                         # 一般点
    {'K1': RDF(0.05), 'K2': RDF(0.1)},                        # 高温極限付近（本文の注記で言及）
]


def param_label(p):
    K1 = RDF(p['K1']); K2 = RDF(p['K2'])
    return f"K1={float(K1):.8g}, K2={float(K2):.8g} (s1*s2={float(sinh(2*K1)*sinh(2*K2)):.8g})"
