# 対象ラベル: anticommutator_of_finite_sums_of_scalar_multiples
# [Σ_j a_jX_j, Σ_k b_kW_k]_+ = Σ_j Σ_k (a_jb_k)[X_j, W_k]_+ の成分の 21 等号の鎖を、n = 1,2,3、r, s = 1,2,3 の全ての成分
# (p, q) で確かめる。行列の積・和・スカラー倍・有限和は本文の成分の式（matrix_operations_by_definition.sage）で組み、
# 二重和は内側から定める。複素数の三重和は、各行の書き方の和の順序（l → j → k、または j → k → l）どおりに Python の
# 入れ子の和で組む。多項式環は和の順序や積の並べ替えを同じ正規形にするので、比較は各行を多項式の恒等式として確かめる。帰属: QQ 上の多項式環（a_j, b_k と行列の成分は不定元）。
load("../../_shared/matrix_operations_by_definition.sage")


def acomm_body(X, W):
    """def_matrix_anticommutator: [X, W]_+ := XW + WX（積は mat_mult、和は def_matrix_sum の成分の式）。"""
    return body_sum(body_product(X, W), body_product(W, X))


count = 0
for n in [1, 2, 3]:
    for r in [1, 2, 3]:
        for s in [1, 2, 3]:
            shapes = [(f"X{j}", n, n) for j in range(r)] + [(f"W{k}", n, n) for k in range(s)]
            P, sc, mats = generic_ring(shapes, scalars=[f"a{j}" for j in range(r)] + [f"b{k}" for k in range(s)])
            a, b = sc[:r], sc[r:]
            X, W = mats[:r], mats[r:]
            S = body_finite_sum([body_scalar(a[j], X[j]) for j in range(r)])
            T = body_finite_sum([body_scalar(b[k], W[k]) for k in range(s)])
            AC = [[acomm_body(X[j], W[k]) for k in range(s)] for j in range(r)]
            rhs = body_finite_sum([body_finite_sum([body_scalar(a[j] * b[k], AC[j][k]) for k in range(s)]) for j in range(r)])
            lhs = acomm_body(S, T)
            ST, TS = body_product(S, T), body_product(T, S)
            for p in range(n):
                for q in range(n):
                    L = range(n)
                    J = range(r)
                    K = range(s)
                    aX = lambda j, u, v: body_scalar(a[j], X[j])[u, v]
                    bW = lambda k, u, v: body_scalar(b[k], W[k])[u, v]
                    lines = [
                        lhs[p, q],
                        body_sum(ST, TS)[p, q],                                                    # def_matrix_anticommutator
                        ST[p, q] + TS[p, q],                                                       # def_matrix_sum
                        sum(S[p, l] * T[l, q] for l in L) + sum(T[p, l] * S[l, q] for l in L),     # mat_mult
                        sum(sum(aX(j, p, l) for j in J) * sum(bW(k, l, q) for k in K) for l in L)
                        + sum(sum(bW(k, p, l) for k in K) * sum(aX(j, l, q) for j in J) for l in L),  # finite_sum_of_matrices_entrywise
                        sum(sum(a[j] * X[j][p, l] for j in J) * sum(b[k] * W[k][l, q] for k in K) for l in L)
                        + sum(sum(b[k] * W[k][p, l] for k in K) * sum(a[j] * X[j][l, q] for j in J) for l in L),  # def_matrix_scalar_multiple
                        sum(sum(a[j] * X[j][p, l] for j in J) * sum(b[k] * W[k][l, q] for k in K) for l in L)
                        + sum(sum(a[j] * X[j][l, q] for j in J) * sum(b[k] * W[k][p, l] for k in K) for l in L),  # 積の交換律（第 2 項）
                        sum(sum((a[j] * X[j][p, l]) * sum(b[k] * W[k][l, q] for k in K) for j in J) for l in L)
                        + sum(sum((a[j] * X[j][l, q]) * sum(b[k] * W[k][p, l] for k in K) for j in J) for l in L),  # (Σx)y = Σxy
                        sum(sum(sum((a[j] * X[j][p, l]) * (b[k] * W[k][l, q]) for k in K) for j in J) for l in L)
                        + sum(sum(sum((a[j] * X[j][l, q]) * (b[k] * W[k][p, l]) for k in K) for j in J) for l in L),  # xΣy = Σxy
                        sum(sum(sum((a[j] * b[k]) * (X[j][p, l] * W[k][l, q]) for k in K) for j in J) for l in L)
                        + sum(sum(sum((a[j] * b[k]) * (W[k][p, l] * X[j][l, q]) for k in K) for j in J) for l in L),  # 積の結合・交換
                        sum(sum(sum((a[j] * b[k]) * (X[j][p, l] * W[k][l, q]) for k in K) for l in L) for j in J)
                        + sum(sum(sum((a[j] * b[k]) * (W[k][p, l] * X[j][l, q]) for k in K) for l in L) for j in J),  # 順序交換（l と j）
                        sum(sum(sum((a[j] * b[k]) * (X[j][p, l] * W[k][l, q]) for l in L) for k in K) for j in J)
                        + sum(sum(sum((a[j] * b[k]) * (W[k][p, l] * X[j][l, q]) for l in L) for k in K) for j in J),  # 順序交換（l と k）
                        sum(sum(sum((a[j] * b[k]) * (X[j][p, l] * W[k][l, q]) for l in L) for k in K)
                            + sum(sum((a[j] * b[k]) * (W[k][p, l] * X[j][l, q]) for l in L) for k in K) for j in J),  # finite_sum_of_complex_sums（外側）
                        sum(sum(sum((a[j] * b[k]) * (X[j][p, l] * W[k][l, q]) for l in L)
                                + sum((a[j] * b[k]) * (W[k][p, l] * X[j][l, q]) for l in L) for k in K) for j in J),  # 同（内側）
                        sum(sum((a[j] * b[k]) * sum(X[j][p, l] * W[k][l, q] for l in L)
                                + (a[j] * b[k]) * sum(W[k][p, l] * X[j][l, q] for l in L) for k in K) for j in J),  # Σcx = cΣx
                        sum(sum((a[j] * b[k]) * (sum(X[j][p, l] * W[k][l, q] for l in L)
                                                 + sum(W[k][p, l] * X[j][l, q] for l in L)) for k in K) for j in J),  # 分配法則
                        sum(sum((a[j] * b[k]) * (body_product(X[j], W[k])[p, q] + body_product(W[k], X[j])[p, q]) for k in K) for j in J),  # mat_mult
                        sum(sum((a[j] * b[k]) * body_sum(body_product(X[j], W[k]), body_product(W[k], X[j]))[p, q] for k in K) for j in J),  # def_matrix_sum
                        sum(sum((a[j] * b[k]) * AC[j][k][p, q] for k in K) for j in J),          # def_matrix_anticommutator
                        sum(sum(body_scalar(a[j] * b[k], AC[j][k])[p, q] for k in K) for j in J),  # def_matrix_scalar_multiple
                        sum(body_finite_sum([body_scalar(a[j] * b[k], AC[j][k]) for k in K])[p, q] for j in J),  # entrywise（各 j）
                        rhs[p, q],                                                                 # entrywise
                    ]
                    assert len(lines) == 22   # 証明の 21 等号
                    for t in range(len(lines) - 1):
                        assert lines[t] == lines[t + 1], (n, r, s, p, q, t)
            # 主張を Sage の行列演算（独立な経路）と比べる
            Ss = sum(a[j] * X[j] for j in range(r))
            Ts = sum(b[k] * W[k] for k in range(s))
            assert Ss * Ts + Ts * Ss == sum(a[j] * b[k] * (X[j] * W[k] + W[k] * X[j]) for j in range(r) for k in range(s)) == lhs == rhs
            # 対照: 係数を a_j だけにしたもの（b_k を落とす）とは一致しない
            assert lhs != body_finite_sum([body_finite_sum([body_scalar(a[j], AC[j][k]) for k in range(s)]) for j in range(r)])
            count += 1
print(f"checked the 21-line entry chain for all entries, n = 1,2,3, r, s = 1,2,3 ({count} cases)")
print("RESULT: PASS")
