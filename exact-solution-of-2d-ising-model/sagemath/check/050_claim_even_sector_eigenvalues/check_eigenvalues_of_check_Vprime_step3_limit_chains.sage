# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 3（V̌'Q̌_ε）と Step 3'（Q̌_εV̌'）の極限の鎖の行を確かめる。
# 模型は check_eigenvalues_of_check_Vprime_step3_partial_sum_chains.sage と同じ（Jordan–Wigner の c_μ から n_μ := c_μ^T c_μ、
# Q̌_ε := Π_μ R_μ^{(ε_μ)}、X̌ := Σ_μ γ_μ(n_μ − ½I)、有理数 γ_μ、M = 2, 3、ε を全列挙）。
# (0) 1 行目 E_K → V̌': ‖E_K − V̌'‖ が K ≥ 5 で狭義に減り、K = 20 で 10^{-8} を下回る（RealField(256)）。
# (a) 「(1/k!)z = z/k! を各項へ」の行: 部分和 Σ_{k≤K}(1/k!)ǧ^k と Σ_{k≤K}ǧ^k/k! が QQ で等しい（厳密、K = 0..20）。
# (b) 前の行の鎖の両端: E_KQ̌_ε = Q̌_εE_K = (Σ_{k≤K}ǧ^k/k!)Q̌_ε（QQ で厳密、K = 0..20）。
# (c) 極限の行（ℝ への脱出。理由: 極限と exp の値。RealField(256) で評価する）:
#     ‖E_KQ̌_ε − V̌'Q̌_ε‖ ≤ ‖E_K − V̌'‖‖Q̌_ε‖（matrix_multiplication_continuity の評価）と、右からの形の同じ評価、
#     ‖c_KQ̌_ε − exp(ǧ)Q̌_ε‖ = |c_K − exp(ǧ)|‖Q̌_ε‖（scalar_sequence_times_matrix_converges の 2 行目）、
#     |c_K − exp(ǧ)| が K = 60 で 10^{-40} を下回ること（scalar_exp_is_limit_of_partial_sums の極限）。
#     V̌' は X̌ が対角なので、対角成分の実数の exp で組む（部分和からは組まない。独立な経路）。
# (a) と (d) は、Sage の中ではほぼ恒等的に成り立つ比較であり、写し間違いの検出だけに効く。
# (d) 最後の行（complex_exp_of_real_argument）: ComplexField(256) の exp(ǧ + 0i) と実数の exp(ǧ) が一致する。
# (e) 鎖を直した理由の記録: 模型に ǧ(ε) < 0 の ε が在る（real_exp_series_converges は a ∈ ℝ_{≥0} だけを述べる）。
RF = RealField(256)
CF = ComplexField(256)


def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def nrm(A):
    return sqrt(sum(RF(a) ** 2 for a in A.list()))


count = 0
neg_seen = False
sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
gammas = [QQ(3) / 2, QQ(5) / 7, QQ(2)]
for M in range(2, 4):
    Id = identity_matrix(QQ, 2 ** M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    n = [c[mu].transpose() * c[mu] for mu in range(M)]
    X = sum(gammas[mu] * (n[mu] - Id / 2) for mu in range(M))
    assert X.is_diagonal()
    Vp = diagonal_matrix(RF, [exp(RF(X[i, i])) for i in range(2 ** M)])
    for eps in cartesian_product([[0, 1]] * M):
        eps = [QQ(e) for e in eps]
        Q = Id
        for mu in range(M):
            Q = Q * (n[mu] if eps[mu] == 1 else Id - n[mu])
        g = sum(gammas[mu] * (eps[mu] - QQ(1) / 2) for mu in range(M))
        neg_seen = neg_seen or g < 0
        eg = exp(RF(g))
        QR = Q.change_ring(RF)
        prev_dE = None
        for K in range(21):
            E = sum((QQ(1) / factorial(k)) * X ** k for k in range(K + 1))
            c1 = sum((QQ(1) / factorial(k)) * g ** k for k in range(K + 1))
            c2 = sum(g ** k / factorial(k) for k in range(K + 1))
            assert c1 == c2                                          # (a)
            assert E * Q == c2 * Q and Q * E == c2 * Q               # (b)
            ER = E.change_ring(RF)
            dE = nrm(ER - Vp)
            if K >= 5:
                assert dE < prev_dE                                  # 1 行目: ‖E_K − V̌'‖ が減る
            prev_dE = dE
            assert nrm(ER * QR - Vp * QR) <= dE * nrm(QR) * (1 + RF(2) ** -200) + RF(2) ** -200   # (c) 左の因子が動く形
            assert nrm(QR * ER - QR * Vp) <= nrm(QR) * dE * (1 + RF(2) ** -200) + RF(2) ** -200   # (c) 右の因子が動く形
            lhs = nrm(RF(c2) * QR - eg * QR)
            rhs = abs(RF(c2) - eg) * nrm(QR)
            assert abs(lhs - rhs) <= RF(2) ** -200 * (1 + rhs)       # (c) スカラー倍の列の評価
            count += 4
        assert prev_dE < RF(10) ** -8                                # 1 行目: K = 20 で ‖E_K − V̌'‖ < 10^{-8}
        c60 = sum(RF(g) ** k / factorial(k) for k in range(61))
        assert abs(c60 - eg) < RF(10) ** -40                         # (c) 数の exp の部分和の極限
        assert nrm(Vp * QR - eg * QR) < RF(10) ** -60 and nrm(QR * Vp - eg * QR) < RF(10) ** -60   # 主張の両辺（独立な経路）
        assert abs(exp(CF(g, 0)) - CF(eg, 0)) < RF(10) ** -70        # (d)
        count += 3
assert neg_seen                                                       # (e)
print(f"checked {count} relations (M = 2, 3 with all eps, K = 0..20); a model eps with gcheck(eps) < 0 exists")
print("RESULT: PASS")
