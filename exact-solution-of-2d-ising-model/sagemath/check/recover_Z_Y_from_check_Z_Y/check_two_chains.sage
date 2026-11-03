# 対象ラベル: recover_Z_Y_from_check_Z_Y
# 第 1 式・第 2 式の主張の左辺からの鎖（各 13 等号）と、準備 1 の鎖（2 等号）を一行ずつ確かめる。
# 厳密: Z_j・Y_j は本文の定め方（pauli_sites_exact.sage の jw: クロネッカー積と積の成分の式）で QQ(i) に作り、
#   円分体 L := QQ(ζ_{4M}) へ i ↦ ζ_{4M}^M で移す。位相 f_{j,μ} = exp(i(j_R θ̃_μ)_C)、e_{k,μ} = exp(-i(k_R θ̃_μ)_C) は
#   θ̃_μ = 2π(μ-1/2)/M なので exp(i(2πq)_C) = ζ_{4M}^{4Mq} として L に持つ。
#   各行の行列は本文の成分の式（積・和・スカラー倍・有限和）で組み、隣と厳密に比べる。スカラーの有限和は L の和で左から組む。
#   第 6 行（scalar_exp_product の後）の exp は指数の和 j(μ-1/2)/M + (-k(μ-1/2)/M) を一つの有理数として、
#   第 7 行（準備 2 の後）は (j-k)(μ-1/2)/M から、第 9 行は 0·(μ-1/2)/M から 1 の冪根に直したもので、
#   どれも積 f_{j,μ}e_{k,μ} とは別の経路で作る。c = (M_col)_C^{-1} は L の逆元で作り、c(M_col)_C = 1_C も確かめる。
# 1 の冪根による exp の値の表し方そのもの（Euler の公式を前提にする）と、scalar_exp_product・準備 2・
# antiperiodic_exp_sum の行の中身は check_exp_balls.sage が本文の exp のボールで確かめる。
# 範囲: M = 2..5、j ∈ {1..M}、Z と Y の両方。
load("../../_shared/pauli_sites_exact.sage")


def sum_C(zs, L):
    """def_finite_sum_of_complex_numbers: 左から順に足す。"""
    out = L(0)
    for z in zs:
        out = out + z
    return out


total = 0
for M in range(2, 6):
    L = CyclotomicField(4 * M, 'z')
    zeta = L.gen()
    iL = zeta**M
    assert iL**2 == -1

    def conv(A):
        return matrix(L, A.nrows(), A.ncols(), lambda r, c: L(KG(A[r, c]).list()[0]) + L(KG(A[r, c]).list()[1]) * iL)

    def ph(q):
        """exp(i(2πq)_C) を ζ_{4M}^{4Mq} で表す（4Mq ∈ ZZ）。"""
        e = 4 * M * QQ(q)
        assert e in ZZ
        return zeta**ZZ(e)

    t = lambda lam: (QQ(lam) - QQ(1) / 2) / M          # θ̃_λ/(2π)
    f = lambda jj, lam: ph(QQ(jj) * t(lam))             # f_{j,μ}
    e = lambda kk, lam: ph(-QQ(kk) * t(lam))            # e_{k,μ}
    N = M
    J = list(range(1, N + 1))
    n = 2**M
    O = matrix(L, n, n, 0)
    cM = L(M)
    c = cM**(-1)                                        # (M_col)_C の逆元
    assert c * cM == L(1)
    for tag in ['z', 'y']:
        X = {m: conv(jw(M, m, tag)) for m in J}
        checkX = {lam: body_finite_sum([body_scalar(e(k, lam), X[k]) for k in J]) for lam in J}   # def_half_integer_checkZ/Y
        for lam in J:
            assert checkX[lam] == sum(e(k, lam) * X[k] for k in J)                                 # Sage の演算（独立な経路）
        for j in J:
            # 準備 1: k ≠ j で 0 < |j-k| < M、指数和は 0_C、その A 倍は O
            for k in J:
                if k != j:
                    assert 0 < abs(j - k) < M and (j - k) % M != 0
                    s = sum_C([ph(QQ(j - k) * t(mu)) for mu in J], L)
                    pre = [body_scalar(s, X[k]), body_scalar(L(0), X[k]), O]
                    for u in range(2):
                        assert pre[u] == pre[u + 1], (tag, M, j, k, u)
            lines = [
                body_scalar(c, body_finite_sum([body_scalar(f(j, mu), checkX[mu]) for mu in J])),
                body_scalar(c, body_finite_sum([body_scalar(f(j, mu), body_finite_sum([body_scalar(e(k, mu), X[k]) for k in J])) for mu in J])),   # 定義
                body_scalar(c, body_finite_sum([body_finite_sum([body_scalar(f(j, mu), body_scalar(e(k, mu), X[k])) for k in J]) for mu in J])),   # finite_sum_of_scalar_multiples
                body_scalar(c, body_finite_sum([body_finite_sum([body_scalar(f(j, mu) * e(k, mu), X[k]) for k in J]) for mu in J])),               # scalar_multiple_is_associative
                body_scalar(c, body_finite_sum([body_finite_sum([body_scalar(f(j, mu) * e(k, mu), X[k]) for mu in J]) for k in J])),               # 二重和の順序交換
                body_scalar(c, body_finite_sum([body_scalar(sum_C([f(j, mu) * e(k, mu) for mu in J], L), X[k]) for k in J])),                    # 一つの行列のスカラー倍の有限和
                body_scalar(c, body_finite_sum([body_scalar(sum_C([ph(QQ(j) * t(mu) + (-QQ(k) * t(mu))) for mu in J], L), X[k]) for k in J])),    # scalar_exp_product
                body_scalar(c, body_finite_sum([body_scalar(sum_C([ph(QQ(j - k) * t(mu)) for mu in J], L), X[k]) for k in J])),                   # 準備 2
                body_scalar(c, body_scalar(sum_C([ph(QQ(j - j) * t(mu)) for mu in J], L), X[j])),                                                 # 単一の非零項
                body_scalar(c, body_scalar(sum_C([ph(QQ(0) * t(mu)) for mu in J], L), X[j])),                                                     # j - j = 0
                body_scalar(c, body_scalar(cM, X[j])),                                                                                            # antiperiodic_exp_sum（k = 0）
                body_scalar(c * cM, X[j]),                                                                                                        # scalar_multiple_is_associative
                body_scalar(L(1), X[j]),                                                                                                          # 逆元
                X[j],                                                                                                                             # scalar_multiple_by_one
            ]
            assert len(lines) == 14
            for u in range(len(lines) - 1):
                assert lines[u] == lines[u + 1], (tag, M, j, u)
            # 第 7 行の k ≠ j の項が実際に O であること（単一の非零項の主張の仮定）
            for k in J:
                if k != j:
                    assert body_scalar(sum_C([ph(QQ(j - k) * t(mu)) for mu in J], L), X[k]) == O
            # 主張を Sage の演算（独立な経路）と比べる
            assert (1 / L(M)) * sum(f(j, mu) * checkX[mu] for mu in J) == X[j]
            total += 1
        # 対照: f の符号を反転した exp(-i(j_R θ̃_μ)_C) では復元できない j がある
        bad = sum(1 for j in J if (1 / L(M)) * sum(ph(-QQ(j) * t(mu)) * checkX[mu] for mu in J) != X[j])
        assert bad > 0
    print(f"  M = {M}: both 13-equality chains and the preparation-1 chain hold for all j in 1..{M}")
print(f"checked {total} cases (M, j, Z or Y)")
print("RESULT: PASS")
