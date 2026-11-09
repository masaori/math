# 対象ラベル: trace_of_check_number_operator_product の検算の鎖の組み立て（模型の検算と本物の ψ̌ の検算が共有する）。
# 引数:
#   M  : M_col
#   Id : I := I_{Mat(2^{M_col}, C)}
#   D  : D[m] = ψ̌_{m+1}^†（m = 0..M_col-1）
#   A  : A[m] = ψ̌_{M_col+1-(m+1)}（D[m] と同じ環の成分）
#   check(ok, label): 一個の等号（または一つの主張）を受け取る
# 各行は証明の括弧どおりに組み、隣の行と比べる。同じ式（同じ括弧の積）は一度だけ計算して使い回す。
from itertools import permutations, product


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
    # 基底段階（k = 0）: tr(I) = Σ_l 1 = 2^{M_col} = 2^{M_col-0}
    chain([Id.trace(), sum(QQ(1) for _ in range(2 ** M)), QQ(2) ** M, QQ(2) ** (M - 0)], f"M={M} 基底段階", check)


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
