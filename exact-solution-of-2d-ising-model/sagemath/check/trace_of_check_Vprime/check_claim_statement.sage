# 対象ラベル: trace_of_check_Vprime
# 主張 tr(V̌') = tr((V̌')^{-1}) = Π_μ 2cosh(γ(θ̃_μ)/2) ∈ ℝ_{>0} そのものを、証明の行を経ずに確かめる。ň_μ・γ_μ は
# ../eigenvalues_of_check_Vprime/_vprime_settings.sage の ball_settings から取る（既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と
# 有理数 γ_μ、M_col = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ と γ(θ̃_μ) の実際の値、結合定数 3 組 × M_col = 2, 3）。
#   V̌' := exp(X̌)、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I)（def_check_number_operator (2)）を、Sage の球の行列の exp と、def_exp の部分和に尾の上界を
#   足した球（exp_ball_by_partial_sums）の二つの経路で作り、重なることを確かめてから使う。
#   (V̌')^{-1} は二通りに作る: Sage の球の行列の逆行列と、主張の前置き（def_check_Vprime (2)）の exp(−X̌)。重なること、(V̌')^{-1}V̌' と
#   V̌'(V̌')^{-1} が I と重なることを確かめる。
#   (i) tr(V̌')・tr((V̌')^{-1})・Π_μ 2cosh(γ_μ/2) の三つが重なる。(ii) tr(V̌') の虚部の球が 0 を含み、実部の球が 0 より大きい
#   （tr(V̌') が ℂ の中の ℝ_{>0} の像に入ることの、球で言える範囲の確かめ。虚部がちょうど 0 であることは球では言えないので、
#   check_step1_chain.sage の厳密な鎖の右辺 Σ_ε (exp(ǧ(ε)))_C が実数の包含の和であることが受け持つ）。
# 否定コントロール: Π_μ 2cosh(γ_μ) と Π_μ 2sinh(γ_μ/2)（cosh の引数の 1/2 を落とす誤り、cosh を sinh にする誤り）は tr(V̌') と重ならない。
# 帰属: ň_μ は QQ か本文の ψ̌ の数体 F の上の厳密な行列。γ_μ・exp・cosh・V̌'・(V̌')^{-1}・トレースは ℝ・ℂ の値を囲む球
#   （ℝ への脱出: arccosh の実対数、実数の exp・cosh と行列の exp の値。いずれも極限で定まる）。
load("../eigenvalues_of_check_Vprime/_vprime_settings.sage")

claim_count = 0
claim_neg = 0
tol = RBv(10) ** -80


def claim(ok, label):
    global claim_count
    assert ok, label
    claim_count += 1


def crad(z):
    return RBv(max(z.real().rad(), z.imag().rad()))


def tr(A):
    total = A[0, 0]
    for k in range(1, A.nrows()):
        total = total + A[k, k]
    return total


for (tag, M, F, ns, gams, to_cb, g1s) in ball_settings([2, 3, 4]):
    N = 2 ^ M
    IdC = identity_matrix(CBv, N)
    nC = [mat_to_cb(A, to_cb) for A in ns]
    X = sum(CBv(gams[mu]) * (nC[mu] - IdC / 2) for mu in range(M))
    V = X.exp()
    claim(balls_overlap_mat(V, exp_ball_by_partial_sums(X)) and max_radius(V) < tol, (tag, "V̌' の二つの経路"))
    Vinv = V.inverse()
    Vneg = (-X).exp()
    claim(balls_overlap_mat(Vinv, Vneg) and balls_overlap_mat(Vneg, exp_ball_by_partial_sums(-X)), (tag, "(V̌')^{-1} = exp(−X̌)"))
    claim(balls_overlap_mat(Vinv * V, IdC) and balls_overlap_mat(V * Vinv, IdC) and max_radius(Vinv) < tol, (tag, "(V̌')^{-1}"))
    t, tinv = tr(V), tr(Vinv)
    p = prod(CBv(2 * (gams[mu] / 2).cosh()) for mu in range(M))
    claim(t.overlaps(tinv) and tinv.overlaps(p) and max(crad(t), crad(tinv), crad(p)) < tol, (tag, "(i)"))
    claim(t.imag().contains_zero() and t.real() > 0 and tinv.imag().contains_zero() and tinv.real() > 0, (tag, "(ii)"))
    for bad in [prod(CBv(2 * gams[mu].cosh()) for mu in range(M)), prod(CBv(2 * (gams[mu] / 2).sinh()) for mu in range(M))]:
        assert not t.overlaps(bad), (tag, "否定コントロール")
        claim_neg += 1
    print(f"  {tag}: 主張 {claim_count} 件まで、否定コントロール {claim_neg} 件まで", flush=True)

print(f"checked {claim_count} claims and {claim_neg} negative controls")
print("RESULT: PASS")
