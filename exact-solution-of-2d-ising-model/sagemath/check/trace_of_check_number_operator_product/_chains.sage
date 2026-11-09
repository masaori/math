# 対象ラベル: trace_of_check_number_operator_product の検算の鎖の組み立て（模型の検算と本物の ψ̌ の検算が共有する）。
# 引数:
#   M  : M_col
#   Id : I := I_{Mat(2^{M_col}, C)}
#   D  : D[m] = ψ̌_{m+1}^†（m = 0..M_col-1）
#   A  : A[m] = ψ̌_{M_col+1-(m+1)}（D[m] と同じ環の成分）
#   check(ok, label): 一個の等号（または一つの主張）を受け取る
# 各行は証明の括弧どおりに組み、隣の行と比べる。同じ式（同じ括弧の積）は一度だけ計算して使い回す。
from itertools import permutations, product
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")


def neg(X):
    # def_matrix_negation
    return matrix(X.base_ring(), X.nrows(), X.ncols(), lambda r, c: (-1) * X[r, c])


def sub(X, Y):
    # def_matrix_difference
    return matrix(X.base_ring(), X.nrows(), X.ncols(), lambda r, c: X[r, c] - Y[r, c])


def left_product(Xs):
    # def_finite_product_of_matrices（左から順に掛ける）
    out = Xs[0]
    for X in Xs[1:]:
        out = out * X
    return out


def chain(values, label, check):
    for i, (a, b) in enumerate(zip(values, values[1:])):
        check(a == b, f"{label} 第 {i + 1} 等号")


def assumption_lines(M, Id, D, A, check):
    """鎖が引く主張: check_number_operator_idempotent (2) と check_number_operators_commute (1) の第 2 式。"""
    n = [D[m] * A[m] for m in range(M)]
    for m in range(M):
        check(A[m] * D[m] == sub(Id, n[m]), f"M={M} μ={m + 1}: 仮定 ψ̌_σ(μ)ψ̌_μ^† = I - ň_μ")
        for l in range(M):
            if l != m:
                check(A[m] * n[l] == n[l] * A[m], f"M={M} μ={m + 1} ν={l + 1}: 仮定 ψ̌_σ(μ) ň_ν = ň_ν ψ̌_σ(μ)")
    return n


def base_case(M, Id, check):
    # 基底段階（k = 0）の 9 行: tr(I) = Σ_{l=1}^{2_ℤ^M} 1_ℂ = Σ (1_ℝ)_ℂ = (Σ 1_ℝ)_ℂ = (ι(2_ℤ^M) 1_ℝ)_ℂ = (ι(2_ℤ^M))_ℂ
    #   = (2_ℝ^M)_ℂ = ((2_ℝ)_ℂ)^M = 2^M = 2^{M-0}。ℂ は実数の対（definition_of_cc）、ℤ・ℝ の冪と ι は定義の再帰で作る。
    one_r, two_r = QQ(1), QQ(1) + QQ(1)
    incl = lambda x: (QQ(x), QQ(0))                                   # inclusion_rr_to_cc
    pair_add = lambda z, w: (z[0] + w[0], z[1] + w[1])                # definition_of_cc の和
    pair_mul = lambda z, w: (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])
    def csum(zs):                                                     # def_finite_sum_of_complex_numbers（左から足す）
        out = zs[0]
        for z in zs[1:]:
            out = pair_add(out, z)
        return out
    def cpow(z, m):                                                   # def_power_of_complex_number
        out = incl(1)
        for _ in range(m):
            out = pair_mul(out, z)
        return out
    d = power_of_integer_by_definition(ZZ(1) + ZZ(1), M)              # 2_ℤ^M（def_power_of_integer）
    check(d >= 1, f"M={M} 基底段階: 2_ℤ^M ∈ ℤ_{{≥1}}")
    tr = Id.trace()
    rows = [(QQ(tr), QQ(0)),
            csum([incl(1)] * d),                                      # trace_basic_properties (3)
            csum([incl(one_r)] * d),                                  # 1_ℂ = (1_ℝ)_ℂ
            incl(finite_sum_by_definition([one_r] * d)),              # real_inclusion_preserves_finite_sum
            incl(iota_zz_to_rr(d) * one_r),                           # finite_sum_of_constant_real_number
            incl(iota_zz_to_rr(d)),                                   # 1_ℝ は乗法の単位元
            incl(power_of_real_by_definition(two_r, M)),              # inclusion_zz_to_rr_of_power_of_two
            cpow(incl(two_r), M),                                     # real_inclusion_preserves_power
            (QQ(2) ** M, QQ(0)),                                      # 主張の底 2 := 2_ℂ := (2_ℝ)_ℂ（組み込みの冪）
            (QQ(2) ** (M - 0), QQ(0))]
    check(Id.trace() == Id.trace().parent()(rows[0][0]), f"M={M} 基底段階: tr(I) は実数の包含")
    chain(rows, f"M={M} 基底段階", check)
    # 否定の対照: ℝ の冪の底を 3 に取り違えると M ≥ 1 で合わない
    if M >= 1:
        check(incl(power_of_real_by_definition(QQ(3), M)) != rows[6], f"M={M} 基底段階: 否定の対照（底 3）")


def induction_step(M, Id, D, A, n, mus, es, check):
    """相異なる添字の列 mus（0 始まり）と es について、帰納段階の全ての鎖。"""
    k = len(mus)
    R = lambda m, e: n[m] if e == 1 else sub(Id, n[m])            # R_μ^{(1)} := ň_μ、R_μ^{(0)} := I - ň_μ
    Rs = [R(m, e) for m, e in zip(mus, es)]
    mk = mus[-1]
    lab = f"M={M} μ={tuple(m + 1 for m in mus)} e={es}"
    whole = left_product(Rs)
    Q = Id if k == 1 else left_product(Rs[:-1])
    P = Q                                                         # P の置き方
    # 帰納法の仮定: tr(P) = 2^{M_col-(k-1)}
    check(P.trace() == QQ(2) ** (M - (k - 1)), f"{lab}: 帰納法の仮定 tr(P)")
    # 準備 1
    if k == 1:
        chain([whole, Rs[0], Id * Rs[0], P * Rs[-1]], f"{lab}: 準備 1 (k=1)", check)
    else:
        chain([whole, Q * Rs[-1], P * Rs[-1]], f"{lab}: 準備 1 (k>=2)", check)
    # 準備 2
    psi = A[mk]
    psiI, Ipsi = psi * Id, Id * psi
    chain([psiI, psi, Ipsi], f"{lab}: 準備 2 単位行列", check)
    for mj, ej in zip(mus[:-1], es[:-1]):
        nj = n[mj]
        if ej == 1:
            chain([psi * R(mj, 1), psi * nj, nj * psi, R(mj, 1) * psi], f"{lab}: 準備 2 e_j=1 (μ_j={mj + 1})", check)
        else:
            Rj = R(mj, 0)
            chain([psi * Rj, psi * sub(Id, nj), sub(Id, nj) * psi, Rj * psi], f"{lab}: 準備 2 e_j=0 (μ_j={mj + 1})", check)
    psiP, Ppsi = psi * P, P * psi
    if k == 1:
        chain([psiP, psiI, Ipsi, Ppsi], f"{lab}: 準備 2 (k=1)", check)
    else:
        chain([psiP, psi * Q, Q * psi, Ppsi], f"{lab}: 準備 2 (k>=2)", check)
    # 準備 3（10 行）
    nk = n[mk]
    Pn = P * nk
    tPn = Pn.trace()
    tP = P.trace()
    PIminusn = (P * sub(Id, nk)).trace()
    prep3 = [
        PIminusn,
        (P * (Id + neg(nk))).trace(),
        (P * Id + P * neg(nk)).trace(),
        (P + P * neg(nk)).trace(),
        (P + neg(Pn)).trace(),
        (1 * P + neg(Pn)).trace(),
        (1 * P + (-1) * Pn).trace(),
        1 * tP + (-1) * tPn,
        tP + (-1) * tPn,
        tP + (-tPn),
        tP - tPn,
    ]
    chain(prep3, f"{lab}: 準備 3", check)
    # tr(Pň_{μ_k}) の 8 行
    Dk = D[mk]
    PD = P * Dk
    chain_n = [
        tPn,
        (P * (Dk * psi)).trace(),
        (PD * psi).trace(),
        (psi * PD).trace(),
        (psiP * Dk).trace(),
        (Ppsi * Dk).trace(),
        (P * (psi * Dk)).trace(),
        PIminusn,
        tP - tPn,
    ]
    chain(chain_n, f"{lab}: tr(Pň_μk) の鎖", check)
    # 準備 4（2_C と 2_C^{-1} の計算。2_C, 2_C^{-1} は成分の体の元）
    F = tP.parent()
    two = F(2)
    one = F(1)
    inv = one / two
    chain([two, F(QQ(2)), F(QQ(1) + QQ(1)), F(QQ(1)) + F(QQ(1)), one + one], f"{lab}: 準備 4 2_C = 1_C + 1_C", check)
    chain([inv * two, two * inv, one], f"{lab}: 準備 4 2_C^-1 2_C = 1_C", check)
    for wname, w in (("tr(Pň)", tPn), ("tr(P)", tP)):
        chain([two * w, (one + one) * w, one * w + one * w, w + w], f"{lab}: 準備 4 2_C w = w + w (w={wname})", check)
        chain([w, one * w, (inv * two) * w, inv * (two * w)], f"{lab}: 準備 4 w = 2_C^-1(2_C w) (w={wname})", check)
        chain([w, inv * (two * w), inv * (w + w), inv * w + inv * w], f"{lab}: 準備 4 w = 2_C^-1 w + 2_C^-1 w (w={wname})", check)
    # tr(Pň_{μ_k}) = 2_C^{-1} tr(P) の 9 行
    chain([tPn,
           inv * (two * tPn),
           inv * (tPn + tPn),
           inv * (tPn + (tP - tPn)),
           inv * (tPn + (tP + (-tPn))),
           inv * (tPn + ((-tPn) + tP)),
           inv * ((tPn + (-tPn)) + tP),
           inv * (F(0) + tP),
           inv * (tP + F(0)),
           inv * tP], f"{lab}: tr(Pň) = 2_C^-1 tr(P) の鎖", check)
    # 二場合（e_k = 1 の 2 行、e_k = 0 の 8 行）
    chain([(P * R(mk, 1)).trace(), tPn, inv * tP], f"{lab}: e_k=1 の場合", check)
    h = inv * tP
    chain([(P * R(mk, 0)).trace(), PIminusn, tP - tPn, tP - h,
           (h + h) - h, (h + h) + (-h), h + (h + (-h)), h + F(0), h], f"{lab}: e_k=0 の場合", check)
    # 最後の 9 行（2^m は 2_C^m）
    p_ = lambda m: two ** m
    chain([whole.trace(), (P * Rs[-1]).trace(), inv * tP,
           inv * p_(M - (k - 1)), inv * p_((M - k) + 1), inv * (p_(M - k) * two), inv * (two * p_(M - k)),
           (inv * two) * p_(M - k), one * p_(M - k), p_(M - k)],
          f"{lab}: 最後の鎖", check)
    # 否定の対照: 鎖から 2_C^{-1} を落とした tr(Pň) = tr(P) は成り立たない（tr(P) ≠ 0）
    check(tPn != tP, f"{lab}: 対照 tr(Pň) ≠ tr(P)（2_C^-1 を落とすと崩れる）")


def all_sequences(M):
    """相異なる添字の全ての列（k = 1..M_col）と全ての e。"""
    for k in range(1, M + 1):
        for mus in permutations(range(M), k):
            for es in product((0, 1), repeat=k):
                yield mus, es


def negative_controls(M, A, n, check):
    """添字が重なる列（μ_k = μ_1 = μ、e_1 = e_k = 1）では準備 2 の可換性と主張の値 2^{M_col-k} が外れる。"""
    for m in range(M):
        P = n[m]
        check(A[m] * P != P * A[m], f"否定コントロール M={M} μ={m + 1}: 添字が重なると準備 2 の可換性が外れる")
        check((n[m] * n[m]).trace() != QQ(2) ** (M - 2), f"否定コントロール M={M} μ={m + 1}: 添字が重なると 2^(M_col-2) が外れる")
