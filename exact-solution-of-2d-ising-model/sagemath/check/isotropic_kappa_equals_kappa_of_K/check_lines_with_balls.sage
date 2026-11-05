# 対象ラベル: isotropic_kappa_equals_kappa_of_K
# 準備 K_2^* = K^* と κ = κ(K) の鎖を、具体の K（QQ）で、値を囲む実数のボール（RealBallField）で確かめる。
# ℝ への脱出: tanh の値は実数の exp の値（部分和の極限）、K_2^*・K^* は実対数の値なので、ここだけ区間計算を使う。
# - tanh K は本文の実数の exp を囲むボール（body_real_exp_ball）から作り、log は Arb の log を使う。exp(−2K^*) = tanh K も確かめる。
# - 等方な点では K_1 = K_2 = K と置いて計算するので、鎖の各行の具体値は同じ値の照合だけである
#   （各行の内容は check_lines_generic.sage の代入・イデアルと対照が確かめる）。具体値で確かめるのは K^* > 0 と、
#   κ(K) が K_c の近くでも 0 と区別されることである。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/isotropic_balls.sage")

for K in K_list:
    tag = f"(K={K})"
    K2s = -(btanh(K).log()) / 2                       # def_second_dual_coupling_constant（K_2 = K）
    Ks = -(btanh(K).log()) / 2                        # def_isotropic_dual_coupling
    check(f"K^* > 0 {tag}", Ks > 0)
    eq((-2 * Ks).exp(), btanh(K), f"exp(−2K^*) = tanh K {tag}")
    P = [K2s, -(btanh(K).log()) / 2, -(btanh(K).log()) / 2, Ks]
    for j, nm in enumerate(["左辺→1", "1→2", "2→3"]):
        eq(P[j], P[j + 1], f"準備 {nm} 行目 {tag}")
    L = [2 * K - 2 * K2s, 2 * K - 2 * K2s, 2 * K - 2 * K2s, 2 * K - 2 * Ks, 2 * K - 2 * Ks]
    for j, nm in enumerate(["左辺→1", "1→2", "2→3", "3→4"]):
        eq(L[j], L[j + 1], f"κ の鎖 {nm} 行目 {tag}")
    check(f"κ(K) ≠ 0（K ≠ K_c） {tag}", is_zero(L[-1]) is False)
    ne(2 * K + 2 * Ks, L[-1], f"対照 K^* の符号を誤ると κ(K) と一致しない {tag}")
finish()
