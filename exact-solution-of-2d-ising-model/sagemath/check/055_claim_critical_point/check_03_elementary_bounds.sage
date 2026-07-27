# ---------------------------------------------------------
# SageMath: 章 E の初等評価（本文の各不等式そのもの）
#   対象: structured-latex elementary_sine_bounds, closed_form_log_integral,
#         sine_integral_two_sided, gamma_derivatives_in_kappa
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

all_ok = True
N = 400

print("=== elementary_sine_bounds: 0 <= theta/2 - sin(theta/2) <= theta^3/48, c0 theta/2 <= sin(theta/2) ===")
bad1 = bad2 = 0
worst_lo = mp.mpf('1e99')
for j in range(0, N + 1):
    th = PI * mp.mpf(j) / N
    d = th / 2 - mp.sin(th / 2)
    if not (mp.mpf(0) <= d <= th ** 3 / 48 + TOL):
        bad1 += 1
    if not (C0 * th / 2 - TOL <= mp.sin(th / 2) <= th / 2 + TOL):
        bad2 += 1
    if j > 0:
        worst_lo = min(worst_lo, mp.sin(th / 2) / (th / 2))
ok = (bad1 == 0) and (bad2 == 0) and (worst_lo >= C0)
print(f"  c_0 = 1 - pi^2/24 = {mp.nstr(C0, 10)}（0.5887 <= c_0 <= 0.5888: "
      f"{mp.mpf('0.5887') <= C0 <= mp.mpf('0.5888')}）")
print(f"  違反件数: 3 次評価 {bad1} 件、はさみ込み {bad2} 件、"
      f"min sin(t)/t = {mp.nstr(worst_lo, 10)} >= c_0  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== closed_form_log_integral (1)(2)(3): 閉じた形と log 評価 ===")
w1 = w3 = mp.mpf(0)
bad2 = 0
for d in [mp.mpf('0.5'), mp.mpf('0.1'), mp.mpf('1e-3'), mp.mpf('1e-6'), mp.mpf('1e-10')]:
    lhs = mp.quad(lambda th: 1 / mp.sqrt(d ** 2 + th ** 2 / 4), [0, PI])
    w1 = max(w1, abs(lhs - 2 * mp.asinh(PI / (2 * d))))
    y = PI / (2 * d)
    e = mp.asinh(y) - mp.log(2 * y)
    if not (mp.mpf(0) <= e <= 1 / (4 * y ** 2) + TOL):
        bad2 += 1
    for a in [C0, mp.mpf(1), mp.mpf('0.3')]:
        rhs = mp.quad(lambda th: 1 / (d ** 2 + a ** 2 * th ** 2 / 4) ** mp.mpf('1.5'), [0, PI])
        if rhs > 2 / (a * d ** 2):
            w3 = mp.mpf(1)
ok = (w1 <= TOL_NUM) and (bad2 == 0) and (w3 == 0)
print(f"  |int - 2 arcsinh(pi/2delta)| = {mp.nstr(w1,3)}, "
      f"log(2y) <= arcsinh y <= log(2y)+1/(4y^2) 違反 {bad2} 件, "
      f"(3) の上界 2/(a delta^2) 違反 {'なし' if w3 == 0 else 'あり'}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== sine_integral_two_sided: 2log(pi/delta) <= int <= 2log(pi/delta) + 2delta^2/pi^2 + B ===")
print(f"  B = pi^2/(12 c0 (1+c0)) = {mp.nstr(BCONST, 10)}（<= 0.88: {BCONST <= mp.mpf('0.88')}）")
bad = 0
for d in [mp.mpf('0.5'), mp.mpf('0.2527'), mp.mpf('0.1'), mp.mpf('1e-2'),
          mp.mpf('1e-4'), mp.mpf('1e-8'), mp.mpf('1e-12')]:
    v = mp.quad(lambda th: 1 / mp.sqrt(d ** 2 + mp.sin(th / 2) ** 2), [0, PI])
    lo = 2 * mp.log(PI / d)
    hi = lo + 2 * d ** 2 / PI ** 2 + BCONST
    good = (lo - TOL_NUM <= v <= hi + TOL_NUM)
    if not good:
        bad += 1
    print(f"  delta={mp.nstr(d,4)}: 下界 {mp.nstr(lo,10)} <= 実測 {mp.nstr(v,10)} <= 上界 {mp.nstr(hi,10)}"
          f"  -> {'PASS' if good else 'FAIL'}")
ok = (bad == 0) and (BCONST <= mp.mpf('0.88'))
all_ok = ok and all_ok

print()
print("=== gamma_derivatives_in_kappa (2)(3): 導関数の式と |d gamma/d kappa| <= 1 ===")
wd1 = wd2 = mp.mpf(0)
bad = 0
for kap in [mp.mpf('1.3'), mp.mpf('0.5'), mp.mpf('0.1'), mp.mpf('0.01'), mp.mpf('-0.4')]:
    for th in [mp.mpf('0.05'), mp.mpf('0.9'), PI / 2, PI, mp.mpf('5.0')]:
        g = lambda k: gamma_kappa(k, th)
        wd1 = max(wd1, abs(mp.diff(g, kap) - dgamma_dkappa(kap, th)))
        wd2 = max(wd2, abs(mp.diff(g, kap, 2) - d2gamma_dkappa2(kap, th)))
        if abs(dgamma_dkappa(kap, th)) > 1 + TOL:
            bad += 1
ok = (wd1 <= TOL_NUM) and (wd2 <= TOL_NUM) and (bad == 0)
print(f"  1 階 {mp.nstr(wd1,3)}, 2 階 {mp.nstr(wd2,3)}, |d gamma/d kappa| > 1 の件数 {bad}"
      f"  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
