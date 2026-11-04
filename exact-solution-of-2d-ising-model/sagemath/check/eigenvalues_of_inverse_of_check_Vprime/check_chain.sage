# 対象ラベル: eigenvalues_of_inverse_of_check_Vprime（証明の 11 行の鎖の行列の行）
# (V̌')^{-1}Q̌_ε = (V̌')^{-1}(1_C Q̌_ε)                                  (scalar_multiple_by_one を右辺から左辺へ)
#              = (V̌')^{-1}((exp 0)_C Q̌_ε)                             (scalar_exp_zero を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ + ǧ))_C Q̌_ε)                       (ℝ で −a + a = 0 を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ)exp(ǧ))_C Q̌_ε)                     (scalar_exp_product を右辺から左辺へ)
#              = (V̌')^{-1}(((exp(−ǧ))_C (exp ǧ)_C) Q̌_ε)               (real_inclusion_preserves_product を右辺から左辺へ)
#              = (V̌')^{-1}((exp(−ǧ))_C ((exp ǧ)_C Q̌_ε))               (scalar_multiple_is_associative を右辺から左辺へ)
#              = (exp(−ǧ))_C ((V̌')^{-1}((exp ǧ)_C Q̌_ε))               (scalar_multiple_factors_out_of_right_factor)
#              = (exp(−ǧ))_C ((V̌')^{-1}(V̌' Q̌_ε))                      (eigenvalues_of_check_Vprime を右辺から左辺へ)
#              = (exp(−ǧ))_C (((V̌')^{-1}V̌') Q̌_ε)                      (mat_mult_associative を右辺から左辺へ)
#              = (exp(−ǧ))_C (I Q̌_ε)                                  (def_invertible_elements_of_R の g^{-1}g = I)
#              = (exp(−ǧ))_C Q̌_ε                                      (identity_matrix_is_left_unit_of_mat_mult)
#
# ň_μ は ../eigenvalues_of_check_Vprime/_vprime_settings.sage が読み込む number_operator_settings() から取る（既定は Jordan–Wigner の
# 模型 n_μ := c_μ^T c_μ、QQ、M_col = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ、数体 F := E_1、結合定数 3 組 × M_col = 2, 3）。
# Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň_μ、R^{(0)} := I − ň_μ、左から掛ける）。
# exp(γ(θ̃_μ)/2) をローラン多項式環 F[a_1^{±1}, …, a_M^{±1}] の不定元 a_μ に置き、V̌' := Π_μ (a_μň_μ + a_μ^{-1}(I − ň_μ))、
# (V̌')^{-1} := Π_μ (a_μ^{-1}ň_μ + a_μ(I − ň_μ)) とする（ň_μ は互いに可換な冪等行列なので、これは exp(±X̌) の値と同じ形の式である。
# V̌' = exp(X̌) そのものはここでは確かめない。eigenvalues_of_check_Vprime の検算と、このディレクトリの check_claim_statement.sage が確かめる）。
# (V̌')^{-1} が V̌' の逆元であることは、Sage の行列の積で (V̌')^{-1}V̌' = V̌'(V̌')^{-1} = I を確かめる（両側の逆元は一意）。
# 実数 x = Σ_μ k_μ γ(θ̃_μ)/2（k_μ ∈ ZZ）を係数の組 (k_1, …, k_M) で持ち、exp(x) := Π_μ a_μ^{k_μ} とする。このとき
# ǧ(ε) は k_μ = 2ε_μ − 1、0 は k = 0、−a + a は係数の組の和である。引いた主張の前提 V̌'Q̌_ε = (exp ǧ(ε))Q̌_ε も確かめる
# （本文の ψ̌ ではこれが本物の ň_μ の性質として試される）。積は mat_mult の成分の式（_shared の body_product）、スカラー倍は body_scalar で組む。
# 行の番号は 1 行目 = 1_C の行から数えた等号の番号で、lines[k] が k 行目の右辺である。
# 2〜5 行目（exp 0、exp(−ǧ+ǧ)、exp(−ǧ)exp ǧ、包含の積）は、この置き方では指数の組の整数の足し算と環の中の恒等に縮むので、
# ほぼ同語反復である。exp の値としての 2〜4 行目は check_real_exp_lines.sage が球で確かめる。実質の比較は 1 行目と 6〜11 行目
# （1_C、スカラー倍の結合・外出し・固有関係・結合律・逆元・単位行列）である。
# 否定コントロール: (a) 右辺の係数を exp(+ǧ(ε)) にすると外れること（a_μ が独立な不定元で ǧ(ε) の係数は全て ±1 なので全ての ε で外れる）。
# (b) 鎖の行を壊すと外れること: 8 行目（eigenvalues_of_check_Vprime）の右辺の V̌'Q̌_ε を Q̌_ε に、9 行目（mat_mult_associative）の
#     右辺の (V̌')^{-1}V̌' を V̌'V̌' に替えると、その行の左辺と外れる。
# 帰属: 成分は F[a_1^{±1}, …, a_M^{±1}]（F は QQ か本文の ψ̌ の数体）の元（厳密計算）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")
import itertools


def left_product(factors):
    """def_finite_product_of_matrices（左から掛ける）。"""
    P = factors[0]
    for A in factors[1:]:
        P = body_product(P, A)
    return P


chain_count = 0
chain_neg = 0
for (tag, M, F, ns) in number_operator_settings():
    K = LaurentPolynomialRing(F, ["a%d" % mu for mu in range(1, M + 1)])
    a = K.gens()
    n = [A.change_ring(K) for A in ns]
    Id = body_identity(K, 2 ** M)
    V = left_product([body_sum(body_scalar(a[mu], n[mu]), body_scalar(a[mu] ** -1, Id - n[mu])) for mu in range(M)])
    Vinv = left_product([body_sum(body_scalar(a[mu] ** -1, n[mu]), body_scalar(a[mu], Id - n[mu])) for mu in range(M)])
    expv = lambda k: prod(a[mu] ** k[mu] for mu in range(M))      # exp(Σ k_μ γ_μ/2)
    neg = lambda k: tuple(-x for x in k)
    add = lambda k, l: tuple(x + y for x, y in zip(k, l))
    zero = tuple([0] * M)
    one = K(1)
    # 前提: (V̌')^{-1} は V̌' の逆元（def_invertible_elements_of_R）。独立な経路として Sage の行列の積で両側を確かめる
    assert Vinv * V == Id and V * Vinv == Id, tag
    for eps in itertools.product([1, 0], repeat=M):
        Q = left_product([n[mu] if eps[mu] == 1 else Id - n[mu] for mu in range(M)])
        assert Q != 0, (tag, eps)
        g = tuple(2 * e - 1 for e in eps)                          # ǧ(ε) の係数の組
        # 前提: eigenvalues_of_check_Vprime の V̌'Q̌_ε = (exp ǧ(ε))_C Q̌_ε
        assert body_product(V, Q) == body_scalar(expv(g), Q), (tag, eps)
        lines = [
            body_product(Vinv, Q),
            body_product(Vinv, body_scalar(one, Q)),
            body_product(Vinv, body_scalar(expv(zero), Q)),
            body_product(Vinv, body_scalar(expv(add(neg(g), g)), Q)),
            body_product(Vinv, body_scalar(expv(neg(g)) * expv(g), Q)),
            body_product(Vinv, body_scalar(expv(neg(g)) * expv(g), Q)),   # ℂ の積で組む（包含は成分の環の中で恒等）
            body_product(Vinv, body_scalar(expv(neg(g)), body_scalar(expv(g), Q))),
            body_scalar(expv(neg(g)), body_product(Vinv, body_scalar(expv(g), Q))),
            body_scalar(expv(neg(g)), body_product(Vinv, body_product(V, Q))),
            body_scalar(expv(neg(g)), body_product(body_product(Vinv, V), Q)),
            body_scalar(expv(neg(g)), body_product(Id, Q)),
            body_scalar(expv(neg(g)), Q),
        ]
        for x, y in zip(lines, lines[1:]):
            assert x == y, (tag, eps)
            chain_count += 1
        # 積の実装の照合: 成分の式で組んだ両端を Sage の行列の積とスカラー倍と比べる（主張は試さない）
        assert lines[0] == Vinv * Q and lines[-1] == expv(neg(g)) * Q, (tag, eps)
        # 否定コントロール (a): 右辺を exp(+ǧ(ε)) にすると外れる
        assert body_scalar(expv(g), Q) != lines[0], (tag, eps)
        chain_neg += 1
        # 否定コントロール (b): 鎖の行を壊すと隣の行と外れる
        assert body_scalar(expv(neg(g)), body_product(Vinv, Q)) != lines[7], (tag, eps)
        chain_neg += 1
        assert body_scalar(expv(neg(g)), body_product(body_product(V, V), Q)) != lines[8], (tag, eps)
        chain_neg += 1
    print(f"  {tag}: 鎖 {chain_count} 段まで、否定コントロール {chain_neg} 件まで", flush=True)

print(f"checked {chain_count} matrix lines and {chain_neg} negative controls")
print("RESULT: PASS")
