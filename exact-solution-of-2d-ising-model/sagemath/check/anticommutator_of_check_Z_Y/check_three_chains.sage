# 対象ラベル: anticommutator_of_check_Z_Y
# 主張の三つの式の左辺からの鎖（第 1 式 16 等号、第 2 式 6 等号、第 3 式 16 等号）を一行ずつ確かめる。
# 厳密: Z_j・Y_j は本文の定め方（pauli_sites_exact.sage の jw: クロネッカー積と積の成分の式）で QQ(i) に作り、
#   円分体 L := QQ(ζ_{4M}) へ i ↦ ζ_{4M}^M で移す。位相 e_{j,λ} = exp(-i(j_R θ̃_λ)_C) は 1 の冪根
#   ζ_{4M}^{-2j(2λ-1)} として L に持つ（θ̃_λ = 2π(λ-1/2)/M なので exp(i(2πq)_C) = ζ_{4M}^{4Mq}）。
#   各行の行列は本文の成分の式（積・和・スカラー倍・有限和・反交換子）で組み、隣と厳密に比べる。
#   スカラーの有限和は L の和で組む。第 10 行（scalar_exp_product の後）の exp は、指数の和
#   -(j(2μ-1) + j(2ν-1))/(2M)·2π を一つの有理数として 1 の冪根に直したもの、第 11 行は y_j = 2πjκ/M の
#   jκ/M から直したもので、どちらも積 e_{j,μ}e_{j,ν} とは別の経路で作る。
# 1 の冪根による exp の値の表し方そのもの（Euler の公式を前提にする）と、scalar_exp_product・exp_sum の行の中身は
# check_exp_balls.sage が本文の exp のボールで確かめる。ここでの第 10・11 行の比較は、指数の有理数の計算の一致を見る。
# 範囲: M = 2..5、μ, ν ∈ M̌ = {1,…,M} の全ての組。
load("../../_shared/pauli_sites_exact.sage")


def deltaM(M, a, b):
    return 1 if (a - b) % M == 0 else 0


def kron_delta(n, a, b):
    assert 1 <= a <= n and 1 <= b <= n
    return 1 if a == b else 0


def acomm_body(X, W):
    """def_matrix_anticommutator: [X, W]_+ := XW + WX（成分の式）。"""
    return body_sum(body_product(X, W), body_product(W, X))


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

    e = lambda jj, lam: ph(-QQ(jj) * (QQ(lam) - QQ(1) / 2) / M)   # e_{j,λ}
    N = M
    J = list(range(1, N + 1))
    Z = {m: conv(jw(M, m, 'z')) for m in J}
    Y = {m: conv(jw(M, m, 'y')) for m in J}
    n = 2**M
    I = body_identity(L, n)
    O = matrix(L, n, n, 0)
    two = L(2)
    twoI = body_scalar(two, I)
    AZZ = {(a, b): acomm_body(Z[a], Z[b]) for a in J for b in J}
    AZY = {(a, b): acomm_body(Z[a], Y[b]) for a in J for b in J}
    AYY = {(a, b): acomm_body(Y[a], Y[b]) for a in J for b in J}
    # anticommutator_of_Z_and_Y の右辺を δ(2_C I)・O として読めることを確かめる
    for a in J:
        for b in J:
            assert AZZ[(a, b)] == body_scalar(L(deltaM(M, a, b)), twoI)
            assert AYY[(a, b)] == body_scalar(L(deltaM(M, a, b)), twoI)
            assert AZY[(a, b)] == O
    checkZ = {lam: body_finite_sum([body_scalar(e(jj, lam), Z[jj]) for jj in J]) for lam in J}
    checkY = {lam: body_finite_sum([body_scalar(e(jj, lam), Y[jj]) for jj in J]) for lam in J}
    # Sage の演算（独立な経路）で組んだ Ž・Y̌ と一致する
    for lam in J:
        assert checkZ[lam] == sum(e(jj, lam) * Z[jj] for jj in J)
        assert checkY[lam] == sum(e(jj, lam) * Y[jj] for jj in J)

    def first_or_third(X, AXX, mu, nu, tag):
        kappa = -(mu + nu - 1)
        dd = lambda a, b: L(deltaM(M, a, b))
        dsum = lambda f: body_finite_sum([body_finite_sum([f(a, b) for b in J]) for a in J])
        lines = [
            acomm_body(X[mu], X[nu]),                                                               # [X̌_μ, X̌_ν]_+
            acomm_body(body_finite_sum([body_scalar(e(a, mu), (Z if tag == 'Z' else Y)[a]) for a in J]),
                       body_finite_sum([body_scalar(e(b, nu), (Z if tag == 'Z' else Y)[b]) for b in J])),  # 定義
            dsum(lambda a, b: body_scalar(e(a, mu) * e(b, nu), AXX[(a, b)])),                         # 新しい主張（二重和）
            dsum(lambda a, b: body_scalar(e(a, mu) * e(b, nu), body_scalar(dd(a, b), twoI))),        # anticommutator_of_Z_and_Y
            dsum(lambda a, b: body_scalar((e(a, mu) * e(b, nu)) * dd(a, b), twoI)),                   # scalar_multiple_is_associative
            body_finite_sum([body_scalar(sum_C([(e(a, mu) * e(b, nu)) * dd(a, b) for b in J], L), twoI) for a in J]),  # 各 j へ
            body_scalar(sum_C([sum_C([(e(a, mu) * e(b, nu)) * dd(a, b) for b in J], L) for a in J], L), twoI),          # 外側
            body_scalar(sum_C([(e(a, mu) * e(a, nu)) * dd(a, a) for a in J], L), twoI),               # 単一の非零項
            body_scalar(sum_C([(e(a, mu) * e(a, nu)) * L(1) for a in J], L), twoI),                   # 準備 1
            body_scalar(sum_C([e(a, mu) * e(a, nu) for a in J], L), twoI),                            # 1_C
            body_scalar(sum_C([ph(-(QQ(a) * (QQ(mu) - QQ(1) / 2) / M + QQ(a) * (QQ(nu) - QQ(1) / 2) / M)) for a in J], L), twoI),  # scalar_exp_product
            body_scalar(sum_C([ph(QQ(a) * kappa / M) for a in J], L), twoI),                          # 準備 2
            body_scalar(L(M) * dd(kappa, 0), twoI),                                                   # exp_sum
            body_scalar(L(M) * dd(mu + nu, 1), twoI),                                                 # def_delta_M
            body_scalar(L(M) * L(kron_delta(M, nu, M + 1 - mu)), twoI),                               # def_check_index_set (5)
            body_scalar((L(M) * L(kron_delta(M, nu, M + 1 - mu))) * two, I),                          # scalar_multiple_is_associative
            body_scalar((two * L(M)) * L(kron_delta(M, nu, M + 1 - mu)), I),                          # ℂ の積の結合・交換
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (tag, M, mu, nu, t)
        # 主張を Sage の演算（独立な経路）と比べる
        Xs = {lam: sum(e(jj, lam) * (Z if tag == 'Z' else Y)[jj] for jj in J) for lam in (mu, nu)}
        delta = 1 if nu == M + 1 - mu else 0
        assert Xs[mu] * Xs[nu] + Xs[nu] * Xs[mu] == 2 * M * delta * identity_matrix(L, n) == lines[0]
        return len(lines) - 1

    # ループの変数名は、pauli_sites_exact.sage の関数 nu（def_kronecker の ν）を上書きしないよう a1・b1 とする
    for a1 in J:
        for b1 in J:
            n1 = first_or_third(checkZ, AZZ, a1, b1, 'Z')
            n3 = first_or_third(checkY, AYY, a1, b1, 'Y')
            lines2 = [
                acomm_body(checkZ[a1], checkY[b1]),
                acomm_body(body_finite_sum([body_scalar(e(a, a1), Z[a]) for a in J]),
                           body_finite_sum([body_scalar(e(b, b1), Y[b]) for b in J])),
                body_finite_sum([body_finite_sum([body_scalar(e(a, a1) * e(b, b1), AZY[(a, b)]) for b in J]) for a in J]),
                body_finite_sum([body_finite_sum([body_scalar(e(a, a1) * e(b, b1), O) for b in J]) for a in J]),
                body_finite_sum([body_finite_sum([O for b in J]) for a in J]),
                body_finite_sum([O for a in J]),
                O,
            ]
            for t in range(len(lines2) - 1):
                assert lines2[t] == lines2[t + 1], ('ZY', M, a1, b1, t)
            total += 1
    # 対照: 整数運動量の位相 exp(-i j 2πμ/M) にすると、対 ν = M+1-μ で第 1 式の右辺が崩れる
    eint = lambda jj, lam: ph(-QQ(jj) * QQ(lam) / M)
    mu0, nu0 = 1, M
    Zi = {lam: sum(eint(jj, lam) * Z[jj] for jj in J) for lam in (mu0, nu0)}
    assert Zi[mu0] * Zi[nu0] + Zi[nu0] * Zi[mu0] != 2 * M * identity_matrix(L, n)
    print(f"  M = {M}: first/third chains ({n1} equalities each) and second chain (6 equalities) hold for all mu, nu in 1..{M}")
print(f"checked {total} pairs (M, mu, nu)")
print("RESULT: PASS")
