# ---------------------------------------------------------
# SageMath: 鍵の恒等式（章 E の出発点）
#   対象: structured-latex gamma_kappa_identity, cosh_addition_and_half_angle
#
#   cosh gamma(theta) = gamma_1(theta) = cosh kappa + 2 A sin^2(theta/2)
#   sinh^2(gamma/2)   = sinh^2(kappa/2) + A sin^2(theta/2)
#   gamma(theta)      = 2 arcsinh( sqrt( sinh^2(kappa/2) + A sin^2(theta/2) ) )
#
# 本文の各段をそのままの形で検証する（結論だけの検証にしない）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

THETAS = [mp.mpf(0), mp.mpf('0.3'), mp.mpf('1.1'), PI / 2, PI,
          mp.mpf('2.5'), mp.mpf('4.7'), 2 * PI]

print("=== gamma_kappa_identity（すべての実数 theta、等方・非等方の両方） ===")
all_ok = True
for (K1, K2) in ANISO_PAIRS:
    kap = kappa_of(K1, K2)
    A = A_of(K1, K2)
    w_g1 = mp.mpf(0)      # gamma_1 = cosh kappa + 2A sin^2(theta/2)
    w_cosh = mp.mpf(0)    # cosh gamma = gamma_1
    w_half = mp.mpf(0)    # sinh^2(gamma/2) = sinh^2(kappa/2) + A sin^2(theta/2)
    w_asinh = mp.mpf(0)   # gamma = 2 arcsinh(sqrt(...))
    w_add = mp.mpf(0)     # cosh(2K1 - 2K2*) = c1 c2* - s1 s2*（加法定理の段）
    for th in THETAS:
        g1 = gamma1_of(K1, K2, th)
        g = gamma_of(K1, K2, th)
        w_g1 = max(w_g1, abs(g1 - (mp.cosh(kap) + 2 * A * mp.sin(th / 2) ** 2)))
        w_cosh = max(w_cosh, abs(mp.cosh(g) - g1))
        w_half = max(w_half, abs(mp.sinh(g / 2) ** 2
                                 - (mp.sinh(kap / 2) ** 2 + A * mp.sin(th / 2) ** 2)))
        w_asinh = max(w_asinh, abs(g - gamma_kappa(kap, th, A)))
    K2s = K_star(K2)
    w_add = abs(mp.cosh(2 * F(K1) - 2 * K2s)
                - (mp.cosh(2 * F(K1)) * mp.cosh(2 * K2s)
                   - mp.sinh(2 * F(K1)) * mp.sinh(2 * K2s)))
    # kappa についての偶関数性
    w_even = max(abs(gamma_kappa(kap, th, A) - gamma_kappa(-kap, th, A)) for th in THETAS)
    ok = (max(w_g1, w_cosh, w_half, w_add, w_even) <= TOL) and (w_asinh <= TOL_ACOSH)
    print(f"  K1={mp.nstr(K1,6)}, K2={mp.nstr(K2,6)}: kappa={mp.nstr(kap,8)}, A={mp.nstr(A,8)} | "
          f"加法定理 {mp.nstr(w_add,3)}, gamma_1 {mp.nstr(w_g1,3)}, cosh {mp.nstr(w_cosh,3)}, "
          f"半角 {mp.nstr(w_half,3)}, arcsinh 表示 {mp.nstr(w_asinh,3)}, 偶関数 {mp.nstr(w_even,3)}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print()
print("=== cosh_addition_and_half_angle (2)(4)(5) ===")
w2a = w2b = w4 = w5 = mp.mpf(0)
for x in [mp.mpf('-2.3'), mp.mpf('-0.4'), mp.mpf(0), mp.mpf('0.7'), mp.mpf('3.1')]:
    w2a = max(w2a, abs(mp.cosh(x) - (1 + 2 * mp.sinh(x / 2) ** 2)))
    w2b = max(w2b, abs(mp.sinh(x) - 2 * mp.sinh(x / 2) * mp.cosh(x / 2)))
    w4 = max(w4, abs(mp.sinh(mp.log(x + mp.sqrt(x ** 2 + 1))) - x))
for t in [mp.mpf(0), mp.mpf('0.2'), mp.mpf('1.0'), mp.mpf('2.5')]:
    if not (t <= mp.sinh(t) <= t * mp.cosh(t) + TOL):
        w5 = mp.mpf(1)
ok = max(w2a, w2b, w4, w5) <= TOL
print(f"  cosh x = 1+2sinh^2(x/2) {mp.nstr(w2a,3)}, sinh x = 2 sinh cosh {mp.nstr(w2b,3)}, "
      f"sinh(arcsinh y)=y {mp.nstr(w4,3)}, t<=sinh t<=t cosh t {'OK' if w5 == 0 else 'NG'}"
      f"  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
