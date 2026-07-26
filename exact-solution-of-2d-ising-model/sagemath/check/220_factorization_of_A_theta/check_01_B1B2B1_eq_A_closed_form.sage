# ---------------------------------------------------------
# A(theta_mu) = B_1(theta_mu) B_2 B_1(theta_mu)
# 対象: structured-latex `factorization_of_A_theta`
#
# 経路 1（左辺）: gamma_1, gamma_2 の閉じた式から組んだ A(theta)（<def_A_theta>）
# 経路 2（右辺）: B_1, B_2 という別々の 2x2 行列の積
# 2 つの経路は式の形が違うので、同語反復にはならない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))

rep = CheckReport("factorization_of_A_theta: A(theta_mu) = B_1 B_2 B_1（閉じた式との突き合わせ）")

for (K1, K2, tag) in param_sets():
    B2 = B2_of(K2)
    for M in OP_TEST_M:
        for mu in mu_range(M):
            th = theta_mu_of(mu, M)
            B1 = B1_of(th, K1)
            lhs = A_of(th, K1, K2)
            rhs = B1 @ B2 @ B1
            rep.close(lhs, rhs, "[%s K1=%.6f K2=%.6f M=%d mu=%d] A = B1 B2 B1" % (tag, K1, K2, M, mu))

# theta_mu 以外の一般の theta でも成り立つか（本文は mu についてのみ主張しているので、
# 主張の範囲外だが、成分計算の正しさの追加の検査になる）。
for (K1, K2, tag) in param_sets():
    B2 = B2_of(K2)
    for th in [0.0, 0.3, 1.0, 2.5, -0.7, np.pi, 2 * np.pi]:
        B1 = B1_of(th, K1)
        rep.close(A_of(th, K1, K2), B1 @ B2 @ B1,
                  "[%s K1=%.6f K2=%.6f] 一般の theta=%.4f" % (tag, K1, K2, th))

rep.finish()
