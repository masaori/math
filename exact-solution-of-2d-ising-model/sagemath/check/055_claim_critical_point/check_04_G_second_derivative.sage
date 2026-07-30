# ---------------------------------------------------------
# SageMath: G''(kappa) の対数発散（章 E の主定理の心臓部）
#   対象: structured-latex second_derivative_log_divergence
#
#   |G'(kappa)| <= 1/2
#   |G''(kappa) - (1/2pi) log(1/|kappa|)| <= 6/5   (0 < |kappa| <= 1/2)
#
# 本文の Step ごとに検証する（Step 1 の積分と微分の交換、Step 2 の折り返し、
# Step 3 の J, T への分解、Step 4/5/6 の各評価、Step 7 の総合）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

all_ok = True
KAPPAS = [mp.mpf('0.5'), mp.mpf('0.3'), mp.mpf('0.1'), mp.mpf('0.03'),
          mp.mpf('1e-3'), mp.mpf('1e-6'), mp.mpf('1e-10')]

print("=== Step 1: (R5) の交換（G'' = (1/4pi) int d^2gamma/dkappa^2） ===")
w = mp.mpf(0)
for kap in [mp.mpf('0.5'), mp.mpf('0.1'), mp.mpf('0.01')]:
    w = max(w, abs(G2(kap) - mp.diff(G, kap, 2)))
ok = w <= mp.mpf('1e-20')
print(f"  max |G''(積分形) - 数値 2 階微分| = {mp.nstr(w,3)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== Step 1: |G'(kappa)| <= 1/2 ===")
mx = mp.mpf(0)
for kap in KAPPAS:
    v = abs(mp.quad(lambda th: dgamma_dkappa(kap, th), [0, PI, 2 * PI]) / (4 * PI))
    mx = max(mx, v)
ok = mx <= mp.mpf(1) / 2
print(f"  max |G'| = {mp.nstr(mx, 10)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== Step 2/3: 折り返しと J, T への分解 ===")
w = mp.mpf(0)
for kap in KAPPAS:
    J = mp.quad(lambda th: 1 / mp.sqrt(S_of(kap, th) * (1 + S_of(kap, th))), [0, PI])
    T = mp.quad(lambda th: mp.sinh(kap) ** 2 * (1 + 2 * S_of(kap, th))
                / (2 * mp.sqrt(S_of(kap, th) * (1 + S_of(kap, th)))) ** 3, [0, PI])
    w = max(w, abs(2 * PI * G2(kap) - (mp.cosh(kap) / 2 * J - T)))
ok = w <= mp.mpf('1e-25')
print(f"  max |2pi G'' - (cosh k /2) J + T| = {mp.nstr(w,3)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== Step 4/5/6: 各段の評価（kappa <= 1/2） ===")
for kap in KAPPAS:
    d = mp.sinh(kap / 2)
    J = mp.quad(lambda th: 1 / mp.sqrt(S_of(kap, th) * (1 + S_of(kap, th))), [0, PI])
    T = mp.quad(lambda th: mp.sinh(kap) ** 2 * (1 + 2 * S_of(kap, th))
                / (2 * mp.sqrt(S_of(kap, th) * (1 + S_of(kap, th)))) ** 3, [0, PI])
    R = J - 2 * mp.log(PI / d)
    step6 = abs(mp.cosh(kap) * mp.log(PI / d) - mp.log(1 / kap))
    # Step 4 は R の上界（2 delta^2/pi^2 + B）と下界（-(pi/2)cosh(kappa/2)）を
    # 別々の項から取る（和を取らない）。その帰結が |R| <= 1.621。
    B = PI ** 2 / (12 * (1 - PI ** 2 / 24) * (2 - PI ** 2 / 24))
    c4a = (-(PI / 2) * mp.cosh(kap / 2) <= R <= 2 * d ** 2 / PI ** 2 + B)
    c4 = c4a and abs(R) <= mp.mpf('1.621')
    c5 = (0 <= T <= mp.mpf('3.614'))
    c6 = step6 <= mp.mpf('2.201')
    ok = c4 and c5 and c6
    print(f"  kappa={mp.nstr(kap,4)}: |R|={mp.nstr(abs(R),8)} (<=1.621 {int(c4)}), "
          f"(両側 {int(c4a)}), T={mp.nstr(T,8)} (<=3.614 {int(c5)}), "
          f"Step6={mp.nstr(step6,8)} (<=2.201 {int(c6)})  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print()
print("=== Step 7: |G'' - (1/2pi) log(1/|kappa|)| <= 6/5（0 < |kappa| <= 1/2 を細かく走査） ===")
mx = mp.mpf(0); arg = None
for j in range(1, 201):
    kap = mp.mpf(j) / 400
    v = abs(G2(kap) - mp.log(1 / kap) / (2 * PI))
    if v > mx:
        mx = v; arg = kap
for kap in [mp.mpf('1e-3'), mp.mpf('1e-6'), mp.mpf('1e-10'), mp.mpf('1e-20')]:
    v = abs(G2(kap) - mp.log(1 / kap) / (2 * PI))
    if v > mx:
        mx = v; arg = kap
ok = mx <= mp.mpf(6) / 5
print(f"  max = {mp.nstr(mx, 10)}（kappa = {mp.nstr(arg, 6)}）  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== 偶関数性: G''(-kappa) = G''(kappa) ===")
w = max(abs(G2(kap) - G2(-kap)) for kap in KAPPAS)
ok = w <= mp.mpf('1e-25')
print(f"  max |G''(k) - G''(-k)| = {mp.nstr(w,3)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== 発散すること: kappa -> 0 で G'' -> +infty ===")
prev = None
mono = True
for kap in [mp.mpf('1e-2'), mp.mpf('1e-4'), mp.mpf('1e-8'), mp.mpf('1e-16'), mp.mpf('1e-32')]:
    v = G2(kap)
    print(f"  kappa={mp.nstr(kap,4)}: G'' = {mp.nstr(v, 10)}, "
          f"(1/2pi)log(1/kappa) = {mp.nstr(mp.log(1/kap)/(2*PI), 10)}")
    if prev is not None and v <= prev:
        mono = False
    prev = v
print(f"  単調に増大: {mono}  -> {'PASS' if mono else 'FAIL'}")
all_ok = mono and all_ok

print()
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
