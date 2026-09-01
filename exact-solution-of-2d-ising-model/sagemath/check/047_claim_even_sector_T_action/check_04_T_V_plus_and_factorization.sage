# ---------------------------------------------------------
# SageMath: T_{(V^{(+)})} の作用と A(theta) の行列分解
#
# 対象: structured-latex T_V_plus_check_Z_Y
#       （併せて factorization_of_A_theta_general, def_T_V_plus,
#        T_V_plus_is_conjugation）
#
# (1) 分解:   B_1(theta) B_2 B_1(theta) = A(theta)   （任意の theta ∈ R）
# (2) 合成:   T_{(V^{(+)})}(X) = V^{(+)} X (V^{(+)})^{-1}
#             （V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}、
#              合成 T_{(V1)^{1/2}} ∘ T_{V2} ∘ T_{(V1)^{1/2}} と一致すること）
# (3) 作用:   (T_{(V^{(+)})}(checkZ_mu), T_{(V^{(+)})}(checkY_mu))
#               = (checkZ_mu, checkY_mu) A(theta~_mu)
# (4) 参考:   gamma_2(theta~_mu) != 0 が半整数運動量では常に成り立つこと
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== (1) B_1(theta) B_2 B_1(theta) = A(theta)（theta を細かく走査）===")
fac_ok = True
for params in EVEN_PARAMS:
    K1v = RDF(params['K1'])
    K2v = RDF(params['K2'])
    K2s = K_star(K2v)
    worst = 0.0
    for k in range(0, 60):
        t = CDF(2 * pi * k / 60)
        P = B1(K1v, t) * B2(K2s) * B1(K1v, t)
        worst = max(worst, (P - A_theta(K1v, K2v, t)).norm(1))
    ok = worst <= TOL
    print(f"  K1={params['K1']}, K2={params['K2']}: 最大残差 {worst:.1e}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    fac_ok = ok and fac_ok

print("=== (2)(3) T_{(V^{(+)})} の合成と checkZ, checkY への作用 ===")
act_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v = RDF(params['K1'])
        K2v = RDF(params['K2'])
        E1, E1inv = V1p_half(O, K1v)
        E2, E2inv = V2_mat(O, K2v)
        Vp = E1 * E2 * E1
        Vpinv = E1inv * E2inv * E1inv
        w = {'compose': 0.0, 'A': 0.0}
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            Zc, Yc = checkZ(O, mu), checkY(O, mu)
            for W in (Zc, Yc):
                comp = E1 * (E2 * (E1 * W * E1inv) * E2inv) * E1inv
                w['compose'] = max(w['compose'], opnorm(comp - Vp * W * Vpinv))
            Amat = A_theta(K1v, K2v, t)
            TZ = Vp * Zc * Vpinv
            TY = Vp * Yc * Vpinv
            w['A'] = max(w['A'],
                         opnorm(TZ - combine(Zc, Yc, Amat.column(0))),
                         opnorm(TY - combine(Zc, Yc, Amat.column(1))))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"合成=共役 {w['compose']:.1e}, (T(cZ),T(cY))=(cZ,cY)A(th~) {w['A']:.1e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        act_ok = ok and act_ok

print("=== (4) 参考: gamma_2(theta~_mu) != 0（半整数運動量では常に非零）===")
g2_ok = True
for M in EVEN_M:
    for params in EVEN_PARAMS:
        K1v = RDF(params['K1'])
        K2v = RDF(params['K2'])
        smallest = None
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            g2 = A_theta(K1v, K2v, t)[0, 1]
            a = abs(g2)
            smallest = a if smallest is None else min(smallest, a)
        ok = smallest > 1e-6
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"min |gamma_2(th~)| = {smallest:.3e}  -> {'PASS' if ok else 'FAIL'}")
        g2_ok = ok and g2_ok

all_ok = fac_ok and act_ok and g2_ok
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
