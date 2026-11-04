# 対象ラベル: trace_of_check_Vprime（Step 3 の行列の部）
# 注（2026-11-04）: 本文の Step 3 は、いまは冒頭の exp(−ǧ(ε)) の 4 行の鎖とトレースの 20 行の鎖である（1〜9 行目がこの検算の鎖と包含、
#   10〜17 行目が Step 2 を γ → −γ で書き下した行で check_step3_exp_product.sage・check_step3_expansion_and_cosh.sage、18〜20 行目が下の (−a)/2・cosh_is_even・tr(V̌')）。
#   下の説明は、Step 3 が「Step 1〜2 を γ ↦ −γ として適用」の 4 行だった時点のもので、確かめる式は変わらない。
# 本文の Step 3 は、(V̌')^{-1} = exp(−X̌) と −X̌ = Σ_μ (−γ(θ̃_μ))(ň_μ − (1/2)I) を述べ、次の 4 行で結ぶ。
#   tr((V̌')^{-1}) = Π_μ 2cosh((−γ(θ̃_μ))/2)      (Step 1〜2 を γ(θ̃_μ) ↦ −γ(θ̃_μ) として適用)
#                 = Π_μ 2cosh(−(γ(θ̃_μ)/2))      (ℝ で (−a)/2 = −(a/2))
#                 = Π_μ 2cosh(γ(θ̃_μ)/2)         (cosh_is_even、x → γ(θ̃_μ)/2)
#                 = tr(V̌')                       (Step 1〜2 の V̌' のトレース表示)
# 1 行目の根拠は名前だけなので、ここではその中身として、Step 1 の 8 行の鎖を (V̌')^{-1} で一行ずつ組み、5 行目の根拠を
# eigenvalues_of_check_Vprime から eigenvalues_of_inverse_of_check_Vprime（(V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_C Q̌_ε）に替えたものを確かめる:
#   tr((V̌')^{-1}) = tr((V̌')^{-1} I) = tr((V̌')^{-1} Σ_ε Q̌_ε) = tr(Σ_ε (V̌')^{-1}Q̌_ε) = Σ_ε tr((V̌')^{-1}Q̌_ε)
#                 = Σ_ε tr((exp(−ǧ(ε)))_C Q̌_ε) = Σ_ε (exp(−ǧ(ε)))_C tr(Q̌_ε) = Σ_ε (exp(−ǧ(ε)))_C 1_C = Σ_ε (exp(−ǧ(ε)))_C
# 続く Step 2 の γ ↦ −γ の形（Σ_ε exp(−ǧ(ε)) = Π_μ (exp(−γ/2) + exp(γ/2))）は、a_μ := exp(γ(θ̃_μ)/2) の置き方で
#   Σ_ε Π_μ a_μ^{−(2ε_μ−1)} = Π_μ (a_μ^{-1} + a_μ)
# になり、本文の 4 行は a の形で Π_μ (a_μ^{-1} + a_μ) = Π_μ (a_μ + a_μ^{-1}) = tr(V̌') になる（2 行目の (−a)/2 = −(a/2) は a の形では同じ元で、3 行目の cosh_is_even は
# この形では ℂ の和の交換に縮むので、値としての 2・3 行目は check_step3_and_step4_real_lines.sage が球で確かめる）。
# あわせて本文の −X̌ = Σ_μ (−γ_μ)(ň_μ − (1/2)I) を、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I)（def_check_number_operator (2) の略記どおり）と比べる。
# ň_μ・Q̌_ε・置き方は check_step1_chain.sage と同じ。(V̌')^{-1} := Π_μ (a_μ^{-1}ň_μ + a_μ(I − ň_μ)) とし、V̌' の逆元であることを
# Sage の行列の積で両側から確かめる。eigenvalues_of_inverse_of_check_Vprime の関係は前提として各 ε で確かめる。
# 帰属: 成分は F[a_1^{±1}, …, a_M^{±1}]（F は QQ か本文の ψ̌ の数体）の元。−X̌ の行は γ_μ を有理数か F 上の不定元に置く（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")
import itertools


def tr(A):
    """def_trace: 対角成分を k = 1, …, n の順に足す。"""
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


def left_product(factors):
    P = factors[0]
    for A in factors[1:]:
        P = body_product(P, A)
    return P


def binary_word_matrix_sum(r, B):
    """def_sum_over_binary_words。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_matrix_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


def binary_word_complex_sum(r, z):
    """def_sum_over_binary_words_of_complex_numbers。"""
    if r == 1:
        return z((1,)) + z((0,))
    return binary_word_complex_sum(r - 1, lambda ep: z(ep + (1,)) + z(ep + (0,)))


def finite_matrix_sum(Xs):
    S = Xs[0]
    for X in Xs[1:]:
        S = body_sum(S, X)
    return S


count = 0
lines3 = 0
negatives = 0
for (tag, M, F, ns) in number_operator_settings():
    K = LaurentPolynomialRing(F, ["a%d" % mu for mu in range(1, M + 1)])
    a = K.gens()
    n = [A.change_ring(K) for A in ns]
    Id = body_identity(K, 2 ** M)
    Q = {eps: left_product([n[mu] if eps[mu] == 1 else Id - n[mu] for mu in range(M)]) for eps in itertools.product([1, 0], repeat=M)}
    V = left_product([body_sum(body_scalar(a[mu], n[mu]), body_scalar(a[mu] ** -1, Id - n[mu])) for mu in range(M)])
    Vinv = left_product([body_sum(body_scalar(a[mu] ** -1, n[mu]), body_scalar(a[mu], Id - n[mu])) for mu in range(M)])
    expmg = lambda eps: prod(a[mu] ** (-(2 * eps[mu] - 1)) for mu in range(M))   # exp(−ǧ(ε))
    one = K(1)
    # 前提: (V̌')^{-1} は V̌' の逆元、(2)・(4)、eigenvalues_of_inverse_of_check_Vprime
    assert Vinv * V == Id and V * Vinv == Id, tag
    assert binary_word_matrix_sum(M, lambda eps: Q[eps]) == Id, tag
    for eps in Q:
        assert tr(Q[eps]) == one, (tag, eps)
        assert body_product(Vinv, Q[eps]) == body_scalar(expmg(eps), Q[eps]), (tag, eps)
        # 否定コントロール: 固有値の符号を誤った (V̌')^{-1}Q̌_ε = (exp(+ǧ(ε)))_C Q̌_ε は行列の段で外れる
        assert body_product(Vinv, Q[eps]) != body_scalar(expmg(eps) ** -1, Q[eps]), (tag, eps)
        negatives += 1
    chain = [
        tr(Vinv),
        tr(body_product(Vinv, Id)),
        tr(body_product(Vinv, binary_word_matrix_sum(M, lambda eps: Q[eps]))),
        tr(binary_word_matrix_sum(M, lambda eps: body_product(Vinv, Q[eps]))),
        binary_word_complex_sum(M, lambda eps: tr(body_product(Vinv, Q[eps]))),
        binary_word_complex_sum(M, lambda eps: tr(body_scalar(expmg(eps), Q[eps]))),
        binary_word_complex_sum(M, lambda eps: expmg(eps) * tr(Q[eps])),
        binary_word_complex_sum(M, lambda eps: expmg(eps) * one),
        binary_word_complex_sum(M, lambda eps: expmg(eps)),
    ]
    for x, y in zip(chain, chain[1:]):
        assert x == y, tag
        count += 1
    assert chain[0] == Vinv.trace(), tag
    # Step 2 の γ ↦ −γ の形と、本文の Step 3 の 3 行（a の形）
    step3 = [
        chain[-1],
        prod(a[mu] ** -1 + a[mu] for mu in range(M)),          # Π 2cosh(−γ/2) = Π (exp(−γ/2) + exp(γ/2))
        prod(a[mu] + a[mu] ** -1 for mu in range(M)),          # Π 2cosh(γ/2) = Π (exp(γ/2) + exp(−γ/2))
        tr(V),
    ]
    for x, y in zip(step3, step3[1:]):
        assert x == y, tag
        lines3 += 1
    # 否定コントロール: 固有値を exp(−ǧ(ε)) の代わりに exp(−2ǧ(ε)) にした和（γ ↦ −γ の代わりに γ ↦ −2γ とする誤り）は外れる。
    # （exp(+ǧ(ε)) にした和は ε ↦ 1 − ε の並べ替えで同じ値になるので、符号の誤りはトレースでは見分けられない。
    #  符号の誤りは上の前提の段で、各 ε の行列 (V̌')^{-1}Q̌_ε と比べて捉える）
    bad = binary_word_complex_sum(M, lambda eps: expmg(eps) ** 2)
    assert bad != chain[0], tag
    negatives += 1
    # −X̌ = Σ_μ (−γ_μ)(ň_μ − (1/2)I)
    for (tag2, M2, R, ns2, gams) in chain_settings([M], symbolic_gamma=True):
        if tag2 != tag:
            continue
        IdR = body_identity(R, 2 ** M)
        half = R(1) / 2
        X = finite_matrix_sum([body_scalar(gams[mu], body_sum(ns2[mu], body_scalar(-half, IdR))) for mu in range(M)])
        mX = finite_matrix_sum([body_scalar(-gams[mu], body_sum(ns2[mu], body_scalar(-half, IdR))) for mu in range(M)])
        assert body_scalar(R(-1), X) == mX, tag
        lines3 += 1
        assert body_scalar(R(-1), X) != X, tag                 # 否定コントロール: −X̌ ≠ X̌（X̌ ≠ O と同じで、写し間違いはほとんど捉えない弱い対照）
        negatives += 1
    print(f"  {tag}: 鎖 {count} 段、Step 3 の行 {lines3} 個まで", flush=True)
print(f"checked {count} chain lines and {lines3} Step 3 lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
