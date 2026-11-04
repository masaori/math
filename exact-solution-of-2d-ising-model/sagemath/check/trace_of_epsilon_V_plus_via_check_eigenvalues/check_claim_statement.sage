# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（主張 (1)(2)(3) を実際の値で）
# V^{(+)} を V_plus_eq_c_exp_sum_gamma_check_number_operator の形 V^{(+)} = C·exp(X̌)（C := (2sinh 2K_2)^{M/2}、
# X̌ := Σ_μ γ(θ̃_μ)(ň_μ − (1/2)I)）で、本文の ψ̌ の ň_μ と ε（_prelude.sage。E_1 の厳密な行列を埋め込みで ComplexBallField(512) へ移す）と
# γ(θ̃_μ) の球から作る。exp は Sage の球の行列の exp と、def_exp の部分和に尾の上界を足した球の二通りで作り、重なることを見る。
# そのうえで
#   (i) tr(εV^{(+)}) と η_{(1,…,1)}ϰ_C が重なる（主張 (1)。η_{(1,…,1)} は証明の (1) の作り方で E_1 の中で厳密に求めた値）、
#   (ii) 独立な経路: trace_of_epsilon_V_plus の転送行列の側の値 (2exp(−K_2)cosh K_1)^M + (2exp(K_2)sinh K_1)^M とも重なる、
#   (iii) ϰ の球の全体が 0 より大きい（主張 (2)）、
#   (iv) η_{(1,…,1)} = +1 で、tr(εV^{(+)}) の虚部の球が 0 を含み実部の球が 0 より大きい（主張 (3) の両辺がともに成り立つ側）。
# 虚部がちょうど 0 であること（値が正の実数の包含に入ること）は球では言えず、(1) の厳密な鎖（check_step1_chain.sage・check_step3_step5_chains.sage）が受け持つ。
# 帰属: ε・ň_μ・η は E_1（厳密）、C・γ・exp・sinh・cosh の値は ℝ への脱出（実対数・平方根・exp・三角関数の値）で、球で扱う。
# 範囲: 結合定数 3 組 × M_col = 2, 3。
load("_prelude.sage")


def exp_by_partial_sums(A):
    """def_exp の部分和 Σ_{p=0}^{N} A^p/p! に、尾の上界 s^{N+1}/(N+1)!/(1 − s/(N+2))（s は Frobenius ノルムの上界）を半径として足す。"""
    n = A.nrows()
    s = RB(sum(abs(z) ** 2 for z in A.list()).sqrt().upper())
    N = 20
    while not (s < N + 2 and (s ** (N + 1) / factorial(N + 1)) < RB(2) ** (-300)):
        N += 10
    E = matrix(CB, n, n, 0)
    P = identity_matrix(CB, n)
    for p in range(N + 1):
        E = E + (CB(1) / factorial(p)) * P
        P = P * A
    rad = (s ** (N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CB, n, n, lambda r, c: CB(E[r, c].real().add_error(rad), E[r, c].imag().add_error(rad)))


checks = 0
negatives = 0
for st in trace_settings([2, 3]):
    M, N = st.M, st.N
    top = tuple([1] * M)
    eta1 = st.eta[top]
    C = (2 * (2 * st.K2).sinh()).sqrt() ** M
    Id = identity_matrix(CB, N)
    X = sum((CB(st.gam[mu]) * (st.cb(st.ns[mu]) - Id / 2) for mu in range(M)), matrix(CB, N, N, 0))
    E1 = X.exp()
    E2 = exp_by_partial_sums(X)
    assert all(E1[r, c].overlaps(E2[r, c]) for r in range(N) for c in range(N)), st.tag
    V = CB(C) * E1
    trEV = (st.cb(st.E) * V).trace()
    kappa = C * left_product([2 * (g / 2).sinh() for g in st.gam])
    rhs = CB(st.to_cb(eta1)) * CB(kappa)
    closed = (2 * (-st.K2).exp() * st.K1.cosh()) ** M + (2 * st.K2.exp() * st.K1.sinh()) ** M
    assert trEV.overlaps(rhs), st.tag                                      # (i)
    assert trEV.overlaps(CB(closed)) and rhs.overlaps(CB(closed)), st.tag   # (ii)
    assert kappa > 0, st.tag                                               # (iii)
    assert eta1 == 1 and trEV.imag().contains_zero() and trEV.real() > 0, st.tag   # (iv)
    assert max(trEV.real().rad(), trEV.imag().rad()) < 1e-100
    checks += 5
    # 否定コントロール: sinh を cosh に（ϰ を Σ_ϵ Λ̌_ϵ に）すると重ならない。η を −1 にすると重ならない。
    assert not trEV.overlaps(CB(C * left_product([2 * (g / 2).cosh() for g in st.gam]))), st.tag
    assert not trEV.overlaps(-rhs), st.tag
    # 否定コントロール: ε を I に取り違えた tr(V^{(+)}) は重ならない
    assert not V.trace().overlaps(rhs), st.tag
    negatives += 3
    print(f"  {st.tag}: tr(εV) ≈ {trEV.real().mid().n(digits=12)}、η_(1,…,1) = {eta1}", flush=True)
print(f"checked {checks} claims")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
