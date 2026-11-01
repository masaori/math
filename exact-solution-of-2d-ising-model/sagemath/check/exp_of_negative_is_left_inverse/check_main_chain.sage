# 対象ラベル: exp_of_negative_is_left_inverse
# 主張の鎖 exp(-A)exp(A) = exp((-A)+A) = exp(O) = I を二つの仕方で確かめる。
# (a) 形式冪級数: A を t A（t は実の不定元、A の成分は QQ 上の不定元の対）に置き、本文の部分和 E_N で
#     E_N(-tA) E_N(tA)、E_N((-tA)+tA)、E_N(O)、I が t の N 次まで一致することを厳密に確かめる（n = 1, 2、N = 6）。
# (b) ℝ への脱出を含む値: 具体の QQ(i) の行列 A で、本文の部分和に尾の評価を足したボールの行列で各行を囲み、
#     Sage 組み込みの ComplexBallField の exp とも比べる。浮動小数点ではなく区間（256 ビット）で、I を厳密に含むかを判定する。
load("../../_shared/hermitian_forms_by_definition.sage")

N = 6
for n in [1, 2]:
    P, (tt,), _, (A0,), _ = generic_ring(n, mats=["A"], real_scalars=["t"])
    A = body_scalar(iota(tt, P), A0)
    mA = body_neg(A, P)
    EmA = trunc_mat(body_partial_exp(mA, N, P), tt, N)
    EA = trunc_mat(body_partial_exp(A, N, P), tt, N)
    lhs = trunc_mat(body_prod(EmA, EA), tt, N)
    mid1 = trunc_mat(body_partial_exp(body_sum(mA, A), N, P), tt, N)
    mid2 = trunc_mat(body_partial_exp(body_zero(n, P), N, P), tt, N)
    I = body_identity(n, P)
    assert lhs == mid1 == mid2 == I, n
    print(f"n = {n}: 形式冪級数として t の {N} 次まで exp(-A)exp(A) = exp((-A)+A) = exp(O) = I を確かめた")

set_random_seed(17)
for n in [1, 2, 3, 4]:
    for _ in range(3):
        gA = rand_gauss_matrix(n) / 2
        lhs = body_exp_ball(-gA) * body_exp_ball(gA)
        mid = body_exp_ball(-gA + gA)
        assert ball_contains_exact(mid, identity_matrix(KG, n))          # exp(O) の部分和は I そのもの（尾は 0）
        assert ball_contains_exact(lhs, identity_matrix(KG, n))
        assert balls_overlap(body_exp_ball(gA), sage_exp_ball(gA))       # 本文の exp と Sage の exp
        assert balls_overlap(lhs, sage_exp_ball(-gA) * sage_exp_ball(gA))
        rad = max(max(z.real().rad(), z.imag().rad()) for z in lhs.list())
        print("  半径の最大", RR(rad))
        assert rad < 1e-20
    print(f"n = {n}: 具体の 3 個の A で、exp(-A)exp(A) を囲むボールが I を含むことを確かめた")
print("RESULT: PASS")
