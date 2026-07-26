# ---------------------------------------------------------
# gamma_1(theta_mu) >= 1
# 対象: structured-latex `gamma1_geq_1`
#
# 反例探索の姿勢で書く: 広いパラメータ範囲 (K_1, K_2) と多数の M, mu を走査し、
# gamma_1(theta_mu) - 1 の**最小値**を記録する。負になる点があれば FAIL になる。
#
# 独立経路:
#   (a) gamma_1 の閉じた式 c_1 c_2^* - s_1 s_2^* cos theta_mu
#   (b) 作用素レベルから読み取った A(theta_mu) の (1,1) 成分
#   (c) 下界の別表示: min_mu gamma_1 = c_1 c_2^* - s_1 s_2^* = cosh(2K_1 - 2K_2^*)
#       （cos theta_mu <= 1 で等号は cos theta_mu = 1 すなわち mu = ±M のとき）
#
# 併せて `TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2`（ラベル未付与）の内容、すなわち
# gamma_1(theta_mu) は常に実で正、したがって arg^{[0,2pi)}(gamma_1) = 0 であり
# 「arg = pi」の場合分けは空であること、も同時に確認する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("gamma1_geq_1: gamma_1(theta_mu) >= 1 と最小値の所在", tol=1e-8)

# --- 広域走査（反例探索） -----------------------------------------
worst = None   # (gamma_1 - 1, K1, K2, M, mu, tag)
K_grid = [0.02, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0]
scan = [(K1, K2, 'grid') for K1 in K_grid for K2 in K_grid]
scan += [(K1, K2, tag) for (K1, K2, tag) in param_sets()]

for (K1, K2, tag) in scan:
    for M in [1, 2, 3, 4, 5, 6, 7, 8]:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            g1 = float(np.real(gamma1_of(th, K1, K2)))
            gi = float(np.imag(complex(gamma1_of(th, K1, K2))))
            if gi != 0.0:
                rep.truth(False, "[K1=%.4f K2=%.4f M=%d mu=%d] gamma_1 が実でない" % (K1, K2, M, mu))
            d = g1 - 1.0
            if worst is None or d < worst[0]:
                worst = (d, K1, K2, M, mu, tag)
            # 反例探索本体: 倍精度の丸めを見込んで -1e-12 を下回ったら FAIL とする
            if d < -1e-12:
                rep.truth(False, "[%s K1=%.6f K2=%.6f M=%d mu=%d] gamma_1 - 1 = %.3e < 0"
                          % (tag, K1, K2, M, mu, d))
            if g1 <= 0.0:
                rep.truth(False, "[%s K1=%.6f K2=%.6f M=%d mu=%d] gamma_1 <= 0（arg = pi の場合）"
                          % (tag, K1, K2, M, mu, ))

print("  走査した (K1,K2,M,mu) 全体での gamma_1 - 1 の最小値: %.3e" % worst[0])
print("    達成点: tag=%s K1=%.10f K2=%.10f M=%d mu=%d" % (worst[5], worst[1], worst[2], worst[3], worst[4]))
rep.truth(worst[0] >= -1e-12, "走査全体で gamma_1 >= 1（最小値 %.3e）" % worst[0])
rep.truth(abs(worst[4]) == worst[3],
          "最小値は mu = ±M（cos theta_mu = 1）で達成される（実際の mu=%d, M=%d）" % (worst[4], worst[3]))

# --- 経路 (b): 作用素から読んだ A の (1,1) 成分と一致するか -----------
for (K1, K2, tag) in param_sets():
    for M in [2, 3, 4]:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            A_op, resid = A_from_operators(mu, M, K1, K2)
            rep.truth(resid < 1e-8, "[%s M=%d mu=%d] 作用素展開の残差 %.2e" % (tag, M, mu, resid))
            rep.close(A_op[0, 0], gamma1_of(th, K1, K2),
                      "[%s K1=%.6f K2=%.6f M=%d mu=%d] A_op[1,1] = gamma_1" % (tag, K1, K2, M, mu))
            rep.truth(float(np.real(A_op[0, 0])) >= 1.0 - 1e-8,
                      "[%s K1=%.6f K2=%.6f M=%d mu=%d] 作用素経路でも gamma_1 >= 1"
                      % (tag, K1, K2, M, mu))

# --- 経路 (c): 下界 c_1 c_2^* - s_1 s_2^* = cosh(2K_1 - 2K_2^*) --------
for (K1, K2, tag) in param_sets():
    K2s = K_star(K2)
    lower = c_of(K1) * c_of(K2s) - s_of(K1) * s_of(K2s)
    rep.close(lower, np.cosh(2 * K1 - 2 * K2s),
              "[%s K1=%.6f K2=%.6f] c_1c_2^* - s_1s_2^* = cosh(2K_1 - 2K_2^*)" % (tag, K1, K2))
    rep.truth(float(lower) >= 1.0 - 1e-12,
              "[%s K1=%.6f K2=%.6f] 下界 cosh(2K_1-2K_2^*) >= 1" % (tag, K1, K2))
    # 実際に mu = ±M でこの下界が達成されること
    for M in [2, 3, 4, 5]:
        rep.close(gamma1_of(theta_mu_of(M, M), K1, K2), lower,
                  "[%s K1=%.6f K2=%.6f M=%d] gamma_1(theta_M) = 下界" % (tag, K1, K2, M))

# --- 偏角: 常に arg^{[0,2pi)}(gamma_1) = 0（arg = pi の場合は空） ------
for (K1, K2, tag) in param_sets():
    for M in [2, 3, 4, 5, 6]:
        for mu in mu_range(M):
            g1 = gamma1_of(theta_mu_of(mu, M), K1, K2)
            rep.truth(arg02pi(g1) == 0.0,
                      "[%s K1=%.6f K2=%.6f M=%d mu=%d] arg^{[0,2pi)}(gamma_1) = 0"
                      % (tag, K1, K2, M, mu))

rep.finish()
