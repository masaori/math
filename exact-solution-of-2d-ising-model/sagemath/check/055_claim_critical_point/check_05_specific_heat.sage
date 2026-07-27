# ---------------------------------------------------------
# SageMath: 比熱の対数発散（章 E の主定理）
#   対象: structured-latex specific_heat_log_divergence, remark_physical_specific_heat
#
#   |f''(K) - (8/pi) log(1/|kappa(K)|)| <= 45      (0 < |K - K_c| <= 1/10)
#   |f''(K) - (8/pi) log(1/|K - K_c|)| <= 49
#   f''(K) / log(1/|K-K_c|) -> 8/pi
#   C = k_B K^2 f''(K)
#
# 有限 M の (1/M) log Lambda^{(1/2)}_M の 2 階微分が M -> infty で f'' へ収束することも
# M = 2,3,4,5,... で確認する（M が本章に現れるのはこの経路だけである）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

all_ok = True

print(f"K_c = arcsinh(1)/2 = {mp.nstr(KC, 15)}  (2K_c = log(1+sqrt2) = {mp.nstr(mp.log(1+mp.sqrt(2)), 15)})")

print()
print("=== f''(K) の分解: f'' = -2/sinh^2 2K + G''(kappa) kappa'^2 + G'(kappa) kappa'' ===")
w = mp.mpf(0)
for dK in [mp.mpf('0.1'), mp.mpf('0.03'), mp.mpf('0.001')]:
    for s in [1, -1]:
        K = KC + s * dK
        kap = kappa_K(K)
        G1 = mp.quad(lambda th: dgamma_dkappa(kap, th), [0, PI, 2 * PI]) / (4 * PI)
        rhs = (-2 / mp.sinh(2 * K) ** 2 + G2(kap) * kappa_prime(K) ** 2
               + G1 * kappa_second(K))
        lhs = mp.diff(f_free, K, 2)
        w = max(w, abs(lhs - rhs))
ok = w <= mp.mpf('1e-20')
print(f"  max |f''(数値) - 分解式| = {mp.nstr(w,3)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== 主定理: |f'' - (8/pi) log(1/|kappa|)| <= 45 / |f'' - (8/pi) log(1/|K-K_c|)| <= 49 ===")
DKS = [mp.mpf('0.1'), mp.mpf('0.05'), mp.mpf('0.02'), mp.mpf('0.01'),
       mp.mpf('1e-3'), mp.mpf('1e-4'), mp.mpf('1e-6'), mp.mpf('1e-9')]
mx45 = mx49 = mp.mpf(0)
for dK in DKS:
    for s in [1, -1]:
        K = KC + s * dK
        kap = kappa_K(K)
        f2 = mp.diff(f_free, K, 2)
        e45 = abs(f2 - 8 / PI * mp.log(1 / abs(kap)))
        e49 = abs(f2 - 8 / PI * mp.log(1 / dK))
        mx45 = max(mx45, e45); mx49 = max(mx49, e49)
        c = (e45 <= 45) and (e49 <= 49)
        print(f"  K-K_c={mp.nstr(s*dK,4):>12}: kappa={mp.nstr(kap,8):>14}, f''={mp.nstr(f2,10):>13}, "
              f"(8/pi)log(1/|kappa|)={mp.nstr(8/PI*mp.log(1/abs(kap)),10):>13}, "
              f"誤差(kappa版)={mp.nstr(e45,6)}, 誤差(K版)={mp.nstr(e49,6)}  -> {'PASS' if c else 'FAIL'}")
        all_ok = c and all_ok
print(f"  最大誤差: kappa 版 {mp.nstr(mx45, 8)} (<= 45), K 版 {mp.nstr(mx49, 8)} (<= 49)")

print()
print("=== 臨界点への近づき方を変えても対数発散: f''/log(1/|K-K_c|) -> 8/pi ===")
print(f"  8/pi = {mp.nstr(8/PI, 12)}")
print("  注: mpmath の作業精度は dps=40 なので |K-K_c| は 1e-24 までしか下げない")
print("      （それ以上下げると K_c +- dK が K_c と区別できず、値が壊れる）。")
ok = True
prev_ratio = None
for e in [3, 6, 12, 18, 24]:
    dK = mp.mpf(10) ** (-e)
    row = []
    for s in [1, -1]:
        K = KC + s * dK
        row.append(mp.diff(f_free, K, 2) / mp.log(1 / dK))
    bound = 49 / mp.log(1 / dK)     # specific_heat_log_divergence から出る誤差限界
    good = all(abs(r - 8 / PI) <= bound for r in row)
    inc = prev_ratio is None or min(row) > prev_ratio
    print(f"  |K-K_c|=1e-{e:<3}: 比 (K>K_c) {mp.nstr(row[0], 12)}, (K<K_c) {mp.nstr(row[1], 12)}, "
          f"|比 - 8/pi| <= 49/log(1/|K-K_c|) = {mp.nstr(bound, 6)}: {good}, 単調増加: {inc}")
    ok = ok and good and inc
    prev_ratio = min(row)
print(f"  すべての段で理論限界内かつ 8/pi へ単調に近づく  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== 有限 M からの収束: (1/M) log Lambda^{(1/2)}_M の 2 階微分 -> f'' ===")
K_probe = KC + mp.mpf('0.02')
f2_inf = mp.diff(f_free, K_probe, 2)
print(f"  K = K_c + 0.02 での f''(極限) = {mp.nstr(f2_inf, 12)}")
errs = {}
for M in M_LIST + [8, 16, 64, 256, 1024]:
    v = mp.diff(lambda K: f_free_finite_M(K, M), K_probe, 2)
    errs[M] = abs(v - f2_inf)
    print(f"  M={M:>5}: 2 階微分 = {mp.nstr(v, 12):>16}, |差| = {mp.nstr(errs[M], 6)}")
# 収束は単調ではない（有限 M では半整数運動量の標本点の並びで誤差が振動する）。
# 主張するのは (a) M >= 8 の誤差が M = 2 の誤差より小さいこと、
# (b) M = 64, 256, 1024 で誤差が単調に減り 1e-6 を切ること。
c_a = all(errs[M] < errs[2] for M in [8, 16, 64, 256, 1024])
c_b = errs[64] > errs[256] > errs[1024] and errs[1024] <= mp.mpf('1e-6')
ok = c_a and c_b
print(f"  M>=8 の誤差 < M=2 の誤差: {c_a}, M=64>256>1024 かつ M=1024 で 1e-6 未満: {c_b}"
      f"  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("=== remark_physical_specific_heat: C = k_B K^2 f''(K) ===")
# k_B = J = 1 とおいて、C := dU/dT を数値微分で作り、k_B K^2 f'' と一致することを見る。
kB = mp.mpf(1); JJ = mp.mpf(1)
def u_of_beta(beta):
    return -mp.diff(lambda b: f_free(b * JJ), beta)
def C_of_T(T):
    return mp.diff(lambda t: u_of_beta(1 / (kB * t)), T)
w = mp.mpf(0)
for K in [mp.mpf('0.35'), KC + mp.mpf('0.02'), mp.mpf('0.55')]:
    T = JJ / (kB * K)
    w = max(w, abs(C_of_T(T) - kB * K ** 2 * mp.diff(f_free, K, 2)))
ok = w <= mp.mpf('1e-15')
print(f"  max |dU/dT - k_B K^2 f''| = {mp.nstr(w,3)}  -> {'PASS' if ok else 'FAIL'}")
all_ok = ok and all_ok

print()
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
