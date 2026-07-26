# ---------------------------------------------------------
# SageMath: T_{(V^{(+)})} = T_{(checkV')} と V^{(+)} = c checkV'
#
# 対象: structured-latex V_plus_eq_c_check_Vprime
#       （併せて T_V_plus_eq_T_check_Vprime_on_check_Z_Y, T_V_plus_eq_T_check_Vprime）
#
# (a) checkZ, checkY 上での一致: T_{(V^{(+)})}(checkZ_mu) = T_{(checkV')}(checkZ_mu) 等
# (b) Z_j, Y_j 上での一致（復元公式 recover_Z_Y_from_check_Z_Y 経由）
# (c) 写像としての一致: ランダムな X について T_{(V^{(+)})}(X) = T_{(checkV')}(X)
# (d) W := (checkV')^{-1} V^{(+)} がスカラー行列であること（W - c I の残差）
# (e) c = (2 sinh 2K_2)^{M/2} と一致すること（次章 017 で本文に載せる値の数値確認）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

set_random_seed(20260726)

print("=== (a) checkZ, checkY 上での一致 ===")
zy_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vp, Vpi = V_plus(O, K1v, K2v)
        Vq, Vqi = checkVprime(O, K1v, K2v)
        worst = 0.0
        for mu in range(1 - M, M + 1):
            Zc, Yc = checkZ(O, mu), checkY(O, mu)
            for W in (Zc, Yc):
                worst = max(worst, opnorm(Vp * W * Vpi - Vq * W * Vqi))
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: 最大残差 {worst:.1e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        zy_ok = ok and zy_ok

print("=== (b) Z_j, Y_j 上での一致（復元公式経由の確認も含む）===")
site_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vp, Vpi = V_plus(O, K1v, K2v)
        Vq, Vqi = checkVprime(O, K1v, K2v)
        w = {'rec': 0.0, 'eq': 0.0}
        for j in range(1, M + 1):
            # 復元公式 Z_j = (1/M) sum_mu checkZ_mu e^{i j theta~_mu}
            Zrec = matrix(CDF, O.d, O.d, 0)
            Yrec = matrix(CDF, O.d, O.d, 0)
            for mu in range(1, M + 1):
                ph = eiph(j * th_tilde(M, mu))
                Zrec = Zrec + checkZ(O, mu) * ph
                Yrec = Yrec + checkY(O, mu) * ph
            Zrec = Zrec / M
            Yrec = Yrec / M
            w['rec'] = max(w['rec'], opnorm(Zrec - O.Z[j]), opnorm(Yrec - O.Y[j]))
            for W in (O.Z[j], O.Y[j]):
                w['eq'] = max(w['eq'], opnorm(Vp * W * Vpi - Vq * W * Vqi))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"復元公式 {w['rec']:.1e}, T の一致 {w['eq']:.1e}  -> {'PASS' if ok else 'FAIL'}")
        site_ok = ok and site_ok

print("=== (c) 写像としての一致（ランダムな X で確認）===")
map_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vp, Vpi = V_plus(O, K1v, K2v)
        Vq, Vqi = checkVprime(O, K1v, K2v)
        worst = 0.0
        for _ in range(3):
            X = matrix(CDF, O.d, O.d,
                       [CDF(RDF.random_element(-1, 1), RDF.random_element(-1, 1))
                        for _ in range(O.d * O.d)])
            worst = max(worst, opnorm(Vp * X * Vpi - Vq * X * Vqi) / max(1.0, opnorm(X)))
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: 相対最大残差 {worst:.1e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        map_ok = ok and map_ok

print("=== (d)(e) W = (checkV')^{-1} V^{(+)} = c I と c = (2 sinh 2K_2)^{M/2} ===")
c_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vp, _ = V_plus(O, K1v, K2v)
        _, Vqi = checkVprime(O, K1v, K2v)
        W = Vqi * Vp
        c_num = CDF(W.trace() / O.d)
        res_scalar = opnorm(W - c_num * Id) / max(1.0, abs(c_num))
        c_pred = CDF((2 * RDF(sinh(2 * K2v))) ** (RDF(M) / 2))
        res_c = abs(c_num - c_pred) / abs(c_pred)
        ok = (res_scalar <= TOL) and (res_c <= 1e-6)
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"c(数値)={complex(c_num):.10g}, (2 sinh 2K2)^(M/2)={float(c_pred.real()):.10g}, "
              f"スカラー性 {res_scalar:.1e}, c の相対差 {res_c:.1e}  -> {'PASS' if ok else 'FAIL'}")
        c_ok = ok and c_ok

all_ok = zy_ok and site_ok and map_ok and c_ok
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
