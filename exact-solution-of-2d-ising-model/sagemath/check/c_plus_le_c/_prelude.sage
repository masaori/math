# ---------------------------------------------------------
# 共通: c_+(M_col) <= c(M_col) の数値検証
#   structured-latex/content/011_max_eigenvalue.ts に対応
#
#   行・列番号は def_row_configuration_numbering の ord(mu) = 1 + sum_m (1-mu(m))/2 * 2^{M-m}
#   （ここでは 0 始まりの ord(mu) - 1）。クロネッカー積（先頭因子が最上位）と同じ並びである
#   （config_numbering_equals_kronecker_numbering）。
#
#   V_1^{1/2} := exp(K_1 D / 2)、D := sum_{m=1}^{M} sigma^z_m sigma^z_{m+1}（def_transfer_matrix_square_root）
#                D は対角行列で (D)_{ord(mu),ord(mu)} = sum_m mu(m) mu(m+1)（sigma_z_diagonal_action）なので
#                exp は対角成分ごとの exp（exp_of_diagonal_matrix）
#   V_2         : 成分定義 (V_2)_{ord(mu),ord(mu')} = exp(K_2 sum_m mu(m) mu'(m))（def_transfer_matrix）
#   W := V_1^{1/2} V_2 V_1^{1/2}（def_symmetrized_transfer_matrix）
#   epsilon := sigma^x_1 … sigma^x_M（def_global_spin_flip_matrix）
#   c(M)   := sup{ x^T W x | x in R^{2^M}, ||x|| = 1 }            （def_rayleigh_sup）
#   c_+(M) := sup{ x^T W x | x in F^{(+)} ∩ R^{2^M}, ||x|| = 1 }  （def_sector_rayleigh_sup）
#
#   帰属: K_1, K_2 in R_{>0} と exp の値は R（指数評価による R への脱出）。倍精度 RDF で計算する。
# ---------------------------------------------------------
import itertools


def all_configs(M):
    return list(itertools.product([1, -1], repeat=M))


def config_index(mu):
    M = len(mu)
    return sum(((1 - mu[m - 1]) // 2) * 2 ** (M - m) for m in range(1, M + 1))


def epsilon_matrix(M):
    """epsilon = sigma^x_1 … sigma^x_M（成分は 0/1 なので QQ で作って RDF へ移す）"""
    sx = matrix(QQ, [[0, 1], [1, 0]])
    i2 = identity_matrix(QQ, 2)
    out = identity_matrix(QQ, 2 ** M)
    for site in range(1, M + 1):
        f = matrix(QQ, [[1]])
        for j in range(1, M + 1):
            f = f.tensor_product(sx if j == site else i2)
        out = out * f
    return matrix(RDF, out)


def W_matrix(M, K1, K2):
    K1 = RDF(K1); K2 = RDF(K2)
    d = 2 ** M
    B = matrix(RDF, d, d, 0)
    V2 = matrix(RDF, d, d, 0)
    cfgs = all_configs(M)
    for mu in cfgs:
        e = sum(mu[j] * mu[(j + 1) % M] for j in range(M))
        B[config_index(mu), config_index(mu)] = exp(K1 * e / 2)
        for nu in cfgs:
            V2[config_index(mu), config_index(nu)] = exp(K2 * sum(mu[j] * nu[j] for j in range(M)))
    return B * V2 * B


def even_real_basis(M):
    """F^{(+)} ∩ R^{2^M} の正規直交基底 (e_k + e_{k̄})/√2（k̄ は全スピン反転した配位の番号）を列に並べる。"""
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = d - 1 - k
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = 1 / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def top_eigenvalue(A):
    """実対称行列の最大固有値（= R 上の単位ベクトルでの Rayleigh 商の上限）"""
    return max([RDF(CDF(z).real()) for z in A.eigenvalues()])


def K2_critical(K1):
    """sinh(2K_1) sinh(2K_2) = 1 を満たす K_2（厳密な臨界点）"""
    return RDF(arcsinh(1 / sinh(2 * RDF(K1)))) / 2


C_PLUS_M = [2, 3, 4, 5, 6]
C_PLUS_PARAMS = [
    (RDF(0.4), K2_critical(0.4)),                                   # 厳密な臨界点（非等方）
    (RDF(0.4406867935097715), K2_critical(0.4406867935097715)),     # 厳密な臨界点（等方）
    (RDF(0.44), K2_critical(0.44) * (1 + 1e-6)),                    # 臨界点近傍
    (RDF(0.4), RDF(0.8)),                                           # 一般点
    (RDF(1.2), RDF(0.3)),                                           # 一般点
    (RDF(0.05), RDF(0.1)),                                          # 高温極限付近
]
