# 対象ラベル: trace_of_check_number_operator_product
# 証明の全ての鎖を、M_col = 2, 3, 4 の相異なる添字の全ての列 μ_1, …, μ_k（k = 1..M_col）と全ての e_1, …, e_k ∈ {0,1} について、
# QQ の厳密計算で一行ずつ確かめる。基底段階 tr(I) = 2^{M_col}、準備 1（最後の因子を分ける。k = 1 では P := I）、
# 準備 2（ψ̌_{M_col+1-μ_k} と単位行列・各因子 R_{μ_j}^{(e_j)}・P の可換性）、準備 3 の 10 行、tr(Pň_{μ_k}) の 8 行、
# 移項の 2 行、二場合の鎖、最後の 6 行。
#   D_μ := ψ̌_μ^†、A_μ := ψ̌_{M_col+1-μ}、n_μ := D_μ A_μ（def_check_number_operator）。
# 鎖が使う仮定は check_number_operator_idempotent (2)（A_μD_μ = I - n_μ）と check_number_operators_commute (1) の第 2 式
# （μ ≠ ν で A_μ n_ν = n_ν A_μ）だけなので、check_23 と同じく Jordan–Wigner のフェルミ演算子 c_μ を取り、D_μ := c_μ^T、A_μ := c_μ とする。
# 否定コントロール: 添字が重なる列（μ_k = μ_j）では準備 2 の可換性と主張の値 2^{M_col-k} が外れることを確かめる。
# 帰属: 成分とトレースは QQ（厳密計算）。
from itertools import permutations, product


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for X in factors:
        out = out.tensor_product(X)
    return out


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


def assert_chain(values, label):
    global count
    for a, b in zip(values, values[1:]):
        assert a == b, label
        count += 1


count = 0
neg_control = 0
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
for M in range(2, 5):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    D = [ck.transpose() for ck in c]
    A = c
    n = [D[m] * A[m] for m in range(M)]
    for m in range(M):
        assert A[m] * D[m] == sub(Id, n[m])                       # check_number_operator_idempotent (2)
        for l in range(M):
            if l != m:
                assert A[m] * n[l] == n[l] * A[m]                 # check_number_operators_commute (1) の第 2 式
    R = lambda m, e: n[m] if e == 1 else sub(Id, n[m])            # R_μ^{(1)} := ň_μ、R_μ^{(0)} := I - ň_μ
    # 基底段階（k = 0）: tr(I) = Σ_l 1 = 2^{M_col} = 2^{M_col-0}
    assert_chain([Id.trace(), sum(QQ(1) for _ in range(2 ** M)), QQ(2) ** M, QQ(2) ** (M - 0)], ("base", M))
    for k in range(1, M + 1):
        for mus in permutations(range(M), k):
            for es in product((0, 1), repeat=k):
                Rs = [R(m, e) for m, e in zip(mus, es)]
                mk, ek = mus[-1], es[-1]
                P = Id if k == 1 else left_product(Rs[:-1])
                lab = (M, mus, es)
                # 帰納法の仮定: tr(P) = 2^{M_col-(k-1)}
                assert P.trace() == QQ(2) ** (M - (k - 1)), lab
                # 準備 1
                if k == 1:
                    assert_chain([left_product(Rs), Rs[0], Id * Rs[0], P * Rs[-1]], ("prep1", lab))
                else:
                    assert_chain([left_product(Rs), left_product(Rs[:-1]) * Rs[-1], P * Rs[-1]], ("prep1", lab))
                # 準備 2
                psi = A[mk]
                assert_chain([psi * Id, psi, Id * psi], ("prep2 unit", lab))
                for mj, ej in zip(mus[:-1], es[:-1]):
                    if ej == 1:
                        assert_chain([psi * R(mj, 1), psi * n[mj], n[mj] * psi, R(mj, 1) * psi], ("prep2 e=1", lab))
                    else:
                        assert_chain([psi * R(mj, 0), psi * sub(Id, n[mj]), sub(Id, n[mj]) * psi, R(mj, 0) * psi], ("prep2 e=0", lab))
                if k == 1:
                    assert_chain([psi * P, psi * Id, Id * psi, P * psi], ("prep2 k=1", lab))
                else:
                    Q = left_product(Rs[:-1])
                    assert_chain([psi * P, psi * Q, Q * psi, P * psi], ("prep2 k>=2", lab))
                # 準備 3（10 行）
                nk = n[mk]
                prep3 = [
                    (P * sub(Id, nk)).trace(),
                    (P * (Id + neg(nk))).trace(),
                    (P * Id + P * neg(nk)).trace(),
                    (P + P * neg(nk)).trace(),
                    (P + neg(P * nk)).trace(),
                    (1 * P + neg(P * nk)).trace(),
                    (1 * P + (-1) * (P * nk)).trace(),
                    1 * P.trace() + (-1) * (P * nk).trace(),
                    P.trace() + (-1) * (P * nk).trace(),
                    P.trace() + (-(P * nk).trace()),
                    P.trace() - (P * nk).trace(),
                ]
                assert_chain(prep3, ("prep3", lab))
                # tr(Pň_{μ_k}) の 8 行
                Dk = D[mk]
                chain_n = [
                    (P * nk).trace(),
                    (P * (Dk * psi)).trace(),
                    ((P * Dk) * psi).trace(),
                    (psi * (P * Dk)).trace(),
                    ((psi * P) * Dk).trace(),
                    ((P * psi) * Dk).trace(),
                    (P * (psi * Dk)).trace(),
                    (P * sub(Id, nk)).trace(),
                    P.trace() - (P * nk).trace(),
                ]
                assert_chain(chain_n, ("trace P n", lab))
                # 移項の 2 行
                assert 2 * (P * nk).trace() == P.trace(), lab
                assert (P * nk).trace() == P.trace() / 2, lab
                count += 2
                # 二場合
                assert_chain([(P * R(mk, 1)).trace(), (P * nk).trace(), P.trace() / 2], ("case e=1", lab))
                assert_chain([(P * R(mk, 0)).trace(), (P * sub(Id, nk)).trace(), P.trace() - (P * nk).trace(),
                              P.trace() - P.trace() / 2, P.trace() / 2], ("case e=0", lab))
                # 最後の 6 行
                assert_chain([left_product(Rs).trace(), (P * Rs[-1]).trace(), P.trace() / 2,
                              QQ(2) ** (M - (k - 1)) / 2, QQ(2) ** ((M - k) + 1) / 2, (QQ(2) ** (M - k) * 2) / 2, QQ(2) ** (M - k)], ("final", lab))
    # 否定コントロール: 最後の添字が前の添字と重なる列（μ_k = μ_1、e_1 = e_k = 1）
    for m in range(M):
        Rs = [n[m], n[m]]
        P = Rs[0]
        assert A[m] * P != P * A[m], ("準備 2 が添字の重なりでも成り立ってしまう", M, m)
        assert left_product(Rs).trace() != QQ(2) ** (M - 2), ("主張の値が添字の重なりでも成り立ってしまう", M, m)
        neg_control += 1
print(f"  {count} 行（M_col = 2..4 の相異なる添字の全ての列と全ての e で、証明の全ての鎖。QQ の厳密計算）")
print(f"  否定コントロール {neg_control} 件: 添字が重なる列では準備 2 の可換性と 2^(M_col-k) が外れる")
print("RESULT: PASS")
