# 対象ラベル: isotropic_A_equals_one
# A = 1 の鎖と主張を、具体の K（QQ）で、値を囲む実数のボール（RealBallField）で確かめる。
# ℝ への脱出: sinh・tanh の値は実数の exp の値（部分和の極限）、K_2^* は実対数の値なので、ここだけ区間計算を使う。
# - sinh 2K・tanh K は本文の実数の exp を囲むボール（body_real_exp_ball）から作る。K_2^* は QQ に無いので、log と sinh 2K_2^* は
#   Arb で作り、sinh 2K_2^* が (1/tanh K_2 − tanh K_2)/2 と重なることも確かめる。
# - 等方な点では K_1 = K_2 = K と置いて計算するので、左辺→1 行目・1→2 行目・2→3 行目の具体値は同じ値の照合だけである
#   （2→3 行目の内容は check_lines_generic.sage の代入と対照が確かめる）。内容を確かめるのは 3→4 行目と主張である。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/isotropic_balls.sage")

for K in K_list:
    tag = f"(K={K})"
    K2s = -(btanh(K).log()) / 2                       # def_second_dual_coupling_constant（K_2 = K）
    check(f"K_2^* > 0 {tag}", K2s > 0)
    eq((2 * K2s).sinh(), (1 / btanh(K) - btanh(K)) / 2, f"sinh 2K_2^* = (1/tanh K_2 − tanh K_2)/2 {tag}")
    s1 = bsinh(2 * K)
    s2s = (2 * K2s).sinh()
    A = s1 * s2s
    L = [A, s1 * s2s, bsinh(2 * K) * (2 * K2s).sinh(), bsinh(2 * K) * (2 * K2s).sinh(), RB(1)]
    names = ["左辺→1", "1→2", "2→3", "3→4"]
    for j in range(4):
        eq(L[j], L[j + 1], f"鎖 {names[j]} 行目 {tag}")
    eq(A, 1, f"主張 A = 1 {tag}")
    K2a = K + QQ(1) / 3
    ne(s1 * (2 * (-(btanh(K2a).log()) / 2)).sinh(), 1, f"対照 異方的（K_2 = K + 1/3）なら A ≠ 1 {tag}")
    ne(s1 * (-2 * K2s).sinh(), 1, f"対照 K_2^* の符号を誤ると A ≠ 1 {tag}")
finish()
