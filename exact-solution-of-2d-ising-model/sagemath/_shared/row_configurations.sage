# =============================================================
# 共通定義ファイル (sagemath/_shared/row_configurations.sage)
#
# 1 行ぶんのスピン配置 𝔐 = Map({1..M_col},{-1,1}) と、その番号付けを厳密計算で扱う。
# 対応する本文のラベル:
#   <def_row_configurations>            𝔐
#   <def_row_configuration_numbering>   ord(μ) = 1 + Σ_m (1-μ(m))/2 · 2^{M_col-m}
#   <def_kronecker>                     ν(I) = 1 + Σ_k (i_k-1) 2^{M-k} と ⊠ の成分定義
#   <def_config_basis_iso>              ι(μ)_m = 1 (μ(m)=+1), 2 (μ(m)=-1)
#   <def_transfer_matrix>               V_1, V_2 の成分定義（成分を ord で指す）
#
# 番号 ord, ν は本文どおり 1 始まりで返す。Sage の行列の添字は 0 始まりなので、
# 行列へ書き込むときだけ「番号 - 1」を使う。
#
# 行列の指数関数（<def_exp> の成分級数）は、対角化可能な整数行列 S についてだけ
# スペクトル射影で厳密に計算する（exp_by_spectral_projectors）。
#   S の相異なる固有値 λ（整数）ごとに P_λ := Π_{λ'≠λ} (S - λ'I)/(λ - λ') を QQ 上で作り、
#   Σ_λ P_λ = I と S P_λ = λ P_λ を検査したうえで exp(K S) := Σ_λ exp(Kλ) P_λ とする。
#   このとき S^p = Σ_λ λ^p P_λ なので、級数 Σ_p (KS)^p/p! の各成分は Σ_λ (Σ_p (Kλ)^p/p!) (P_λ)_{kl}
#   となり、スカラーの指数級数の値 exp(Kλ) を代入したものに一致する（有限個の射影の線型結合）。
# exp(Kλ) の値は、K = log x（x は 1 より大きい有理数）と選んで x^λ ∈ QQ として与える。
# これにより ℝ への脱出を「K の選び方」の一点に閉じ込め、等号の判定をすべて QQ / QQbar で行う。
# =============================================================

import itertools


def row_configurations(M_col):
    """𝔐 を (μ(1), ..., μ(M_col)) のタプルとして列挙する。"""
    return list(itertools.product([ZZ(1), ZZ(-1)], repeat=M_col))


def b_digit(mu, m):
    """b_m(μ) := (1-μ(m))/2 ∈ {0,1}（m は 1 始まり）。QQ で計算して ZZ に属することを確かめる。"""
    v = (QQ(1) - QQ(mu[m - 1])) / 2
    assert v in ZZ and v in (0, 1), (mu, m, v)
    return ZZ(v)


def ord_number(mu):
    """<def_row_configuration_numbering> の ord(μ)（1 始まり）。"""
    M_col = len(mu)
    return ZZ(1) + sum(b_digit(mu, m) * ZZ(2) ** (M_col - m) for m in range(1, M_col + 1))


def iota(mu):
    """<def_config_basis_iso> の ι(μ) = (i_1, ..., i_{M_col})。"""
    return tuple(ZZ(1) if s == 1 else ZZ(2) for s in mu)


def nu_number(I):
    """<def_kronecker> の ν(I)（1 始まり）。"""
    M = len(I)
    return ZZ(1) + sum((ZZ(I[k - 1]) - 1) * ZZ(2) ** (M - k) for k in range(1, M + 1))


def multi_indices(M):
    """𝓘_M = {1,2}^M。"""
    return list(itertools.product([ZZ(1), ZZ(2)], repeat=M))


def kron_by_definition(mats, R):
    """<def_kronecker> の成分定義そのもので A_1 ⊠ … ⊠ A_M を作る。
       (A_1 ⊠ … ⊠ A_M)_{ν(I),ν(J)} := Π_k (A_k)_{i_k j_k}。Sage の tensor_product は使わない。"""
    M = len(mats)
    d = 2 ** M
    out = matrix(R, d, d, 0)
    idx = multi_indices(M)
    for I in idx:
        for J in idx:
            val = R(1)
            for k in range(M):
                val = val * R(mats[k][I[k] - 1, J[k] - 1])
            out[nu_number(I) - 1, nu_number(J) - 1] = val
    return out


def kron_vector_by_definition(vecs, R):
    """<def_kronecker> の成分定義 (v_1 ⊠ … ⊠ v_M)_{ν(I)} := Π_k (v_k)_{i_k}。"""
    M = len(vecs)
    out = vector(R, [0] * (2 ** M))
    for I in multi_indices(M):
        val = R(1)
        for k in range(M):
            val = val * R(vecs[k][I[k] - 1])
        out[nu_number(I) - 1] = val
    return out


SIGMA_X_2 = matrix(ZZ, [[0, 1], [1, 0]])
SIGMA_Z_2 = matrix(ZZ, [[1, 0], [0, -1]])
ID_2 = identity_matrix(ZZ, 2)
E_VEC = {ZZ(1): vector(ZZ, [1, 0]), ZZ(2): vector(ZZ, [0, 1])}


def site_pauli(a, k, M_col, R=ZZ):
    """<def_site_pauli_matrices> の σ_k^a（a ∈ {'x','z'}、k は 1..M_col）。"""
    s = {'x': SIGMA_X_2, 'z': SIGMA_Z_2}[a]
    return kron_by_definition([s if j == k else ID_2 for j in range(1, M_col + 1)], R)


def basis_vector_of(mu, R=ZZ):
    """f_{ι(μ)} = e_{i_1} ⊠ … ⊠ e_{i_M}（<def_end_iso>、<def_config_basis_iso>）。"""
    return kron_vector_by_definition([E_VEC[i] for i in iota(mu)], R)


def exp_by_spectral_projectors(S, exp_of_eigenvalue, R):
    """整数固有値をもつ対角化可能な整数行列 S について exp(K S) を厳密に返す。
       exp_of_eigenvalue(λ) が exp(K λ) の値（R の元）を返す。
       Σ P_λ = I と S P_λ = λ P_λ を検査し、満たさなければ例外を投げる。"""
    S = matrix(QQ, S)
    n = S.nrows()
    Id = identity_matrix(QQ, n)
    lams = sorted(ZZ(r) for r, _ in S.charpoly().roots(ZZ))
    # charpoly の根が全部整数であること（重複度込みで次数に一致）
    assert sum(mult for _, mult in S.charpoly().roots(ZZ)) == n, "固有値が整数だけではない"
    P = {}
    for lam in lams:
        Pl = Id
        for lp in lams:
            if lp != lam:
                Pl = Pl * (S - lp * Id) / (lam - lp)
        P[lam] = Pl
    assert sum(P.values(), matrix(QQ, n, n, 0)) == Id, "Σ P_λ ≠ I"
    for lam in lams:
        assert S * P[lam] == lam * P[lam], "S P_λ ≠ λ P_λ（対角化可能でない）"
    out = matrix(R, n, n, 0)
    for lam in lams:
        out = out + R(exp_of_eigenvalue(lam)) * matrix(R, P[lam])
    return out


def V1_by_components(M_col, weight, R):
    """<def_transfer_matrix> の V_1 を成分で作る。行・列番号 k から μ = ord^{-1}(k) を
       2 進展開で復元して書き込む（ord の順方向の計算とは別経路）。
       weight(n) は exp(K_1 n)（n ∈ ZZ）の値を返す。"""
    d = 2 ** M_col
    out = matrix(R, d, d, 0)
    for k in range(1, d + 1):
        mu = ord_inverse(k, M_col)
        n = sum(mu[m] * mu[(m + 1) % M_col] for m in range(M_col))
        out[k - 1, k - 1] = R(weight(n))
    return out


def V2_by_components(M_col, weight, R):
    """<def_transfer_matrix> の V_2 を成分で作る。weight(n) は exp(K_2 n) の値。"""
    d = 2 ** M_col
    out = matrix(R, d, d, 0)
    for k in range(1, d + 1):
        mu = ord_inverse(k, M_col)
        for l in range(1, d + 1):
            mup = ord_inverse(l, M_col)
            n = sum(mu[m] * mup[m] for m in range(M_col))
            out[k - 1, l - 1] = R(weight(n))
    return out


def ord_inverse(k, M_col):
    """k ∈ {1..2^M_col} から μ を復元する: k-1 の 2 進展開の第 m 桁（上位から）が b_m(μ)。"""
    r = ZZ(k) - 1
    assert 0 <= r < 2 ** M_col
    digits = [(r >> (M_col - m)) & 1 for m in range(1, M_col + 1)]
    return tuple(ZZ(1) if b == 0 else ZZ(-1) for b in digits)


def exact_result(ok_all):
    print("RESULT: PASS" if ok_all else "RESULT: FAIL")
    if not ok_all:
        import sys
        sys.exit(1)
