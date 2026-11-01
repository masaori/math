# 対象ラベル: trace_of_idempotent
# Step 2（Qv_j = v_j の 4 行、j > r の Qv_j = 0、(PD)_{il} の 6 行の鎖、QP = PD）と
# Step 3（tr(Q) から dim im Q までの 9 行の鎖）を、QQ(i) の具体の冪等行列で厳密に確かめる。
# im Q と ker Q の基底は Sage の column_space と right_kernel から取り、x_j は solve_right で求める。
# P' は Sage の inverse で求め、仮定 P'P = PP' = I を本文の積の組み方で確かめる。
# 鎖の両端は Sage の trace・rank と比べる。
load("_prelude.sage")

for n in SIZES:
    for (r, seed, Q) in idempotents(n):
        R = K
        I = body_identity(R, n)
        im_basis = [matrix(R, n, 1, list(v)) for v in Q.column_space().basis()]
        ker_basis = [matrix(R, n, 1, list(v)) for v in Q.right_kernel().basis()]
        assert len(im_basis) == r and len(ker_basis) == n - r
        vs = im_basis + ker_basis
        QQm = body_product(Q, Q)
        assert QQm == Q
        # Step 2: j ≤ r で Qv_j = Q(Qx_j) = (QQ)x_j = Qx_j = v_j
        for j in range(r):
            xj = Q.solve_right(vs[j])
            assert body_product(Q, xj) == vs[j]                            # v_j = Q x_j
            l = [body_product(Q, vs[j]), body_product(Q, body_product(Q, xj)),
                 body_product(QQm, xj), body_product(Q, xj), vs[j]]
            for t in range(len(l) - 1):
                assert l[t] == l[t + 1], (n, r, seed, j, t)
        # j > r で Qv_j = 0（ker Q の元）
        for j in range(r, n):
            assert body_product(Q, vs[j]) == body_zero(R, n, 1)
        # P と D
        P = columns_matrix(R, vs, n)
        D = matrix(R, n, n, lambda k, l: R(1) if (k == l and k < r) else R(0))
        PD = body_product(P, D)
        QP = body_product(Q, P)
        Qcols = columns_matrix(R, [body_product(Q, v) for v in vs], n)
        for i in range(n):
            for l in range(n):
                off = [k for k in range(n) if k != l]
                assert all(D[k, l] == 0 for k in off)
                e = [
                    PD[i, l],                                              # (PD)_{il}
                    sum(P[i, k] * D[k, l] for k in range(n)),              # Σ_k P_ik D_kl          (mat_mult)
                    P[i, l] * D[l, l] + sum((P[i, k] * D[k, l] for k in off), R(0)),  # k = l の項を分ける
                    P[i, l] * D[l, l] + sum((P[i, k] * R(0) for k in off), R(0)),  # D_kl = 0 (k ≠ l)
                    P[i, l] * D[l, l] + sum((R(0) for k in off), R(0)),    # z0 = 0 (complex_times_zero_is_zero)
                    P[i, l] * D[l, l],                                     # 0 は加法の単位元
                    vs[l][i, 0] * D[l, l],                                 # (v_l)_i D_ll           (P の定め方)
                    vs[l][i, 0] * R(1) if l < r else vs[l][i, 0] * R(0),   # 場合分け               (D の定め方)
                    vs[l][i, 0] if l < r else R(0),                        # 1 は積の単位元、z0 = 0
                    body_product(Q, vs[l])[i, 0],                          # (Qv_l)_i               (Qv_l の値と def_zero_matrix)
                    Qcols[i, l],                                           # ([Qv_1 ... Qv_n])_{il} (列に並べた行列の成分)
                    QP[i, l],                                              # (QP)_{il}              (mat_columnwise)
                ]
                for t in range(len(e) - 1):
                    assert e[t] == e[t + 1], (n, r, seed, i, l, t)
        assert QP == PD and Q * P == P * D
        # Step 3
        Pp = P.inverse()
        assert body_product(Pp, P) == I and body_product(P, Pp) == I     # P'P = PP' = I
        s = [
            body_trace(Q),                                                 # tr(Q)
            body_trace(body_product(Pp, QP)),                              # tr(P'(QP))   (trace_basic_properties (4))
            body_trace(body_product(Pp, PD)),                              # tr(P'(PD))   (QP = PD)
            body_trace(body_product(body_product(Pp, P), D)),              # tr((P'P)D)   (結合律)
            body_trace(body_product(I, D)),                                # tr(ID)       (P'P = I)
            body_trace(D),                                                 # tr(D)        (左単位元)
            sum((D[k, k] for k in range(n)), R(0)),                        # Σ D_kk       (def_trace)
            sum((R(1) for k in range(r)), R(0)) + sum((R(0) for k in range(r, n)), R(0)),  # D の定め方
            sum((R(1) for k in range(r)), R(0)),                           # 0 は加法の単位元
            R(Q.column_space().dimension()),                               # dim im Q
        ]
        for t in range(len(s) - 1):
            assert s[t] == s[t + 1], (n, r, seed, t)
        assert s[0] == Q.trace() and s[-1] == Q.rank() == r                # Sage の trace・rank と比べる
    print(f"n = {n}: 冪等行列 {len(idempotents(n))} 個（r = 0..{n}）で Step 2・3 の鎖と主張を確かめた")

# 否定コントロール: 冪等でない Q = 2I では tr(Q) = 2n ≠ n = dim im Q
for n in SIZES:
    Q = 2 * identity_matrix(K, n)
    assert body_trace(Q) != Q.column_space().dimension()
print("否定コントロール: 冪等でない 2I では tr(Q) ≠ dim im Q")
print("RESULT: PASS")
