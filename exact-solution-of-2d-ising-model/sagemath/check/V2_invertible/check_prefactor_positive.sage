# 対象ラベル: V2_invertible
# 準備の鎖 a = (2s_2)^{M/2} = (2 sinh 2K_2)^{M/2} ∈ ℝ_{>0} と、a ≠ 0 から ℝ の逆数 a^{-1} があることを確かめる。
# K_2 = log x（x ∈ {2, 3, 3/2}）と選ぶ。
#   - s_2 は二つの経路で作って比べる: 共通の準備の second_coupling_exact（(x^2 - x^{-2})/2 の式）と、
#     def_cosh_sinh の sinh z := (exp z - exp(-z))/2 に exp(2K_2) = x^2・exp(-2K_2) = x^{-2} を別々に渡したもの
#     （hyperbolic_by_definition.sage の sinh_by_definition）
#   - a は二つの経路で作って比べる: def_second_transfer_matrix_prefactor の (√(2 sinh 2K_2))^{M} を
#     平方根の M 回の積として組んだものと、Sage の AA の有理数冪 (2s_2)^{M/2}
#   第一行は略記 s_2 := sinh 2K_2（def_indexed_hyperbolic_abbreviations）の代入なので、確かめられるのは二つの経路の一致である。
# あわせて K_2 ∈ {1/4, 1/2, 1}（有理数）では exp(±2K_2) を本文の部分和に尾の評価を足したボール（body_real_exp_ball。Arb の exp は使わない）
# で作り、s_2 > 0・a > 0 を確かめる（ℝ への脱出: exp の極限）。
load("_prelude.sage")
load("../../_shared/hyperbolic_by_definition.sage")
for M in range(1, 6):
    for x in [QQ(2), QQ(3), QQ(3)/2]:
        s2, _ = second_coupling_exact(x)
        sinh2K2 = sinh_by_definition(x**2, x**(-2))
        assert s2 == sinh2K2
        r = AA(2 * sinh2K2).sqrt()
        a_def = prod([r] * M) if M > 0 else AA(1)
        a = prefactor_exact(M, x)
        assert a == a_def == AA(2 * s2) ** (QQ(M) / 2)
        assert 2 * sinh2K2 > 0 and a > 0
        ainv = a**(-1)
        assert a * ainv == 1 and ainv * a == 1 and ainv in AA
    for K2 in [QQ(1)/4, QQ(1)/2, QQ(1)]:
        s2b = sinh_by_definition(body_real_exp_ball(2 * K2), body_real_exp_ball(-2 * K2))
        assert s2b > 0
        ab = (2 * s2b).sqrt() ** M
        assert ab > 0
    print(f"  M_col={M}: s_2 と a を二つの経路で作って一致、a > 0、a a^(-1) = a^(-1) a = 1（K_2 = log x で厳密、K_2 有理数で本文の exp のボール）")
print("RESULT: PASS")
