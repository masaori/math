# 対象ラベル: trace_of_check_Vprime（Step 3 のトレースの鎖の 9 行目）
# Σ_{ε∈{0,1}^𝓜̌} (exp(−ǧ(ε)))_C = (Σ_{ε∈{0,1}^𝓜̌} exp(−ǧ(ε)))_C   (real_inclusion_preserves_sum_over_binary_words, x_ε → exp(−ǧ(ε)))
# 左辺の和は def_sum_over_binary_words_of_complex_numbers、右辺の和は def_sum_over_binary_words_of_real_numbers の
# 帰納法どおりに（最後の成分で 1 を 0 より先に）組む。ℂ は実数の対（_shared/complex_as_real_pairs.sage）。
# exp(γ(θ~_μ)/2) を有理関数体 QQ(a_1, …, a_M) の不定元 a_μ に置き、exp(−ǧ(ε)) = ∏_μ a_μ^{−(2ε_μ − 1)} とする
# （check_step3_chain と同じ置き方。Step 3 の鎖の 8 行目の右辺の項はこの値の包含である）。
# 帰属: QQ 上の有理関数体（厳密計算）。浮動小数点はない。
load("../../_shared/complex_as_real_pairs.sage")
import itertools


def complex_sum(r, z):
    if r == 1:
        return cc_add(z((1,)), z((0,)))
    return complex_sum(r - 1, lambda ep: cc_add(z(ep + (1,)), z(ep + (0,))))


def real_sum(r, x):
    if r == 1:
        return x((1,)) + x((0,))
    return real_sum(r - 1, lambda ep: x(ep + (1,)) + x(ep + (0,)))


count = 0
neg = 0
for M in range(1, 6):
    K = FractionField(PolynomialRing(QQ, [f"a_{mu}" for mu in range(1, M + 1)]))
    a = K.gens()

    def exp_g(eps):
        # exp(−ǧ(ε))
        out = K(1)
        for mu in range(M):
            out = out * a[mu] ** (-(2 * eps[mu] - 1))
        return out

    lhs = complex_sum(M, lambda eps: iota(exp_g(eps), K))
    rhs = iota(real_sum(M, exp_g), K)
    assert lhs == rhs, M
    count += 1
    # 比べる側: 右辺の ℝ の和は ∏_μ (a_μ^{-1} + a_μ)（Step 3 の残りの行が示す値）と一致する
    assert real_sum(M, exp_g) == prod(a[mu] + a[mu] ** (-1) for mu in range(M))
    # 否定コントロール: 左辺で ε = (1, …, 1) の項を落とす（和の項の落とし）と右辺と一致しない
    top = tuple([1] * M)
    assert complex_sum(M, lambda eps: iota(exp_g(eps) if eps != top else K(0), K)) != rhs
    neg += 1
print(f"checked 1 line in {count} cases (M_col = 1..5)")
print(f"negative controls: {neg}")
print("RESULT: PASS")
