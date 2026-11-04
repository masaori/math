# 対象ラベル: trace_of_epsilon_V_plus_via_check_eigenvalues（Step 1 の 13 行の鎖）
# tr(εV) = tr((εV)I)                       (identity_matrix_is_right_unit_of_mat_mult を右辺から左辺へ)
#        = tr((εV)Σ_ϵQ̌_ϵ)                  (check_joint_eigenspace_decomposition (2) を右辺から左辺へ)
#        = tr(Σ_ϵ(εV)Q̌_ϵ)                  (sum_over_binary_words_distributes_in_right_factor)
#        = Σ_ϵ tr((εV)Q̌_ϵ)                 (trace_of_sum_over_binary_words)
#        = Σ_ϵ tr(ε(VQ̌_ϵ))                 (mat_mult_associative を各項へ)
#        = Σ_ϵ tr(ε((Λ̌_ϵ)_C Q̌_ϵ))          (eigenvalues_of_V_plus (1) を各項へ)
#        = Σ_ϵ tr((Λ̌_ϵ)_C(εQ̌_ϵ))           (scalar_multiple_factors_out_of_right_factor を各項へ)
#        = Σ_ϵ tr((Λ̌_ϵ)_C(η_ϵQ̌_ϵ))         (epsilon_eigenvalue_on_check_Q (1) を各項へ)
#        = Σ_ϵ tr(((Λ̌_ϵ)_Cη_ϵ)Q̌_ϵ)         (scalar_multiple_is_associative を各項へ)
#        = Σ_ϵ ((Λ̌_ϵ)_Cη_ϵ)tr(Q̌_ϵ)         (trace_of_scalar_multiple を各項へ)
#        = Σ_ϵ ((Λ̌_ϵ)_Cη_ϵ)1_C             (check_joint_eigenspace_decomposition (4) を各項へ)
#        = Σ_ϵ (Λ̌_ϵ)_Cη_ϵ                  (1_C は乗法の単位元)
#        = Σ_ϵ η_ϵ(Λ̌_ϵ)_C                  (ℂ の乗法の交換則)
# V := V^{(+)}。ε・ň_μ・Q̌_ϵ・η_ϵ は本文の ψ̌ から作った数体 E_1 の厳密な行列と値（_prelude.sage）。
# V^{(+)} の値（指数関数を含む）は使わず、(2s_2)^{M/2} を不定元 C、exp(γ(θ̃_μ)/2) を不定元 a_μ に置いて、
# V := C·Π_μ(a_μň_μ + a_μ^{-1}(I − ň_μ))（左から掛ける）、Λ̌_ϵ := C·Π_μ a_μ^{2ϵ_μ−1} とする（成分は E_1[C^{±1}, a_1^{±1}, …] の元）。
# 鎖が V について使う性質は eigenvalues_of_V_plus (1) の VQ̌_ϵ = (Λ̌_ϵ)_C Q̌_ϵ だけで、これを前提として各 ϵ で確かめる。
# 不定元での等号は、C・a_μ に実際の値を代入しても成り立つ。V^{(+)} の実際の値での主張は check_claim_statement.sage が確かめる。
# 引いた主張 (2) Σ_ϵQ̌_ϵ = I、(4) tr(Q̌_ϵ) = 1、epsilon_eigenvalue_on_check_Q (1) の εQ̌_ϵ = η_ϵQ̌_ϵ も前提として確かめる。
# 帰属: 全て厳密（E_1 上のローラン多項式環）。浮動小数点はない。
load("_prelude.sage")

count = 0
negatives = 0
for st in trace_settings([2, 3]):
    M, N = st.M, st.N
    K = LaurentPolynomialRing(st.F, ["C"] + ["a%d" % mu for mu in range(1, M + 1)])
    C, a = K.gens()[0], K.gens()[1:]
    n = [A.change_ring(K) for A in st.ns]
    Id = body_identity(K, N)
    E = st.E.change_ring(K)
    Q = {w: st.Q[w].change_ring(K) for w in st.words}
    eta = {w: K(st.eta[w]) for w in st.words}
    V = body_scalar(C, left_product([body_sum(body_scalar(a[mu], n[mu]), body_scalar(a[mu] ** -1, body_difference(Id, n[mu]))) for mu in range(M)], body_product))
    Lam = lambda w: C * prod(a[mu] ** (2 * w[mu] - 1) for mu in range(M))
    one = K(1)
    # 引いた主張の前提
    assert binary_word_matrix_sum(M, lambda w: Q[w]) == Id, st.tag
    for w in st.words:
        assert tr(Q[w]) == one, (st.tag, w)
        assert body_product(V, Q[w]) == body_scalar(Lam(w), Q[w]), (st.tag, w)
        assert body_product(E, Q[w]) == body_scalar(eta[w], Q[w]), (st.tag, w)
        assert eta[w] in (one, -one), (st.tag, w)
    EV = body_product(E, V)
    lines = [
        tr(EV),
        tr(body_product(EV, Id)),
        tr(body_product(EV, binary_word_matrix_sum(M, lambda w: Q[w]))),
        tr(binary_word_matrix_sum(M, lambda w: body_product(EV, Q[w]))),
        binary_word_sum(M, lambda w: tr(body_product(EV, Q[w]))),
        binary_word_sum(M, lambda w: tr(body_product(E, body_product(V, Q[w])))),
        binary_word_sum(M, lambda w: tr(body_product(E, body_scalar(Lam(w), Q[w])))),
        binary_word_sum(M, lambda w: tr(body_scalar(Lam(w), body_product(E, Q[w])))),
        binary_word_sum(M, lambda w: tr(body_scalar(Lam(w), body_scalar(eta[w], Q[w])))),
        binary_word_sum(M, lambda w: tr(body_scalar(Lam(w) * eta[w], Q[w]))),
        binary_word_sum(M, lambda w: (Lam(w) * eta[w]) * tr(Q[w])),
        binary_word_sum(M, lambda w: (Lam(w) * eta[w]) * one),
        binary_word_sum(M, lambda w: Lam(w) * eta[w]),
        binary_word_sum(M, lambda w: eta[w] * Lam(w)),
    ]
    for x, y in zip(lines, lines[1:]):
        assert x == y, st.tag
        count += 1
    # 独立な経路: Sage の積と trace、および主張 (1) の a の形 η_{(1,…,1)}·C·Π_μ(a_μ − a_μ^{-1})（2sinh(γ/2) = a − a^{-1}）
    assert lines[0] == (st.E.change_ring(K) * V).trace(), st.tag
    top = tuple([1] * M)
    assert lines[-1] == eta[top] * C * prod(a[mu] - a[mu] ** -1 for mu in range(M)), st.tag
    # 否定コントロール: η_ϵ を落とす（ε を I に取り違える）と最後の行は Σ_ϵ Λ̌_ϵ = C·Π(a + a^{-1}) になり外れる
    bad = binary_word_sum(M, lambda w: Lam(w))
    assert bad != lines[-1] and bad == C * prod(a[mu] + a[mu] ** -1 for mu in range(M)), st.tag
    # 否定コントロール: VQ̌ の固有値の符号を取り違えた Λ̌_ϵ（a → a^{-1}）では 6 行目の項が 5 行目の項と外れる
    # （和では ϵ ↦ 1 − ϵ の並べ替えで外れないことがあるので、項ごとに比べる）
    assert any(tr(body_product(E, body_scalar(C * prod(a[mu] ** (1 - 2 * w[mu]) for mu in range(M)), Q[w])))
               != tr(body_product(E, body_product(V, Q[w]))) for w in st.words), st.tag
    negatives += 2
    print(f"  {st.tag}: η_(1,…,1) = {eta[top]}、鎖 {count} 段まで", flush=True)
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
