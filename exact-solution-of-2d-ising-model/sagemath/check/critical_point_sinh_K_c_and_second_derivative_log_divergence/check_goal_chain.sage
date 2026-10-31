# ---------------------------------------------------------
# SageMath: 主張 critical_point_sinh_K_c_and_second_derivative_log_divergence の各部分を確かめる。
#   f(K) := (1/2) log(2 sinh 2K) + (1/(4pi)) int_0^{2pi} gamma(theta) d theta（K_1 = K_2 = K。
#   gamma は gamma1_lower_bound_all_theta の arccosh 表示）。
#   (1) K_c := (1/2) log(1 + sqrt 2) について sinh 2K_c = 1 と K_c > 0 を、
#       x := exp(2K_c) = 1 + sqrt 2 として代数的数体 QQbar で厳密に確かめる
#       （sinh 2K_c = (x - 1/x)/2）。sinh 2K = 1 の解が R_{>0} にただ一つであることは
#       sinh の狭義単調性による（cosh_addition_and_half_angle (3)）。ここでは格子点での
#       sinh 2K - 1 の符号の変化が一回だけであることを見る（例示）。
#   (2) 証明の式変形: arccosh 表示の f と、(1/2) log(2 sinh 2K) + G(kappa(K))（specific_heat_log_divergence の f）
#       が一致すること。その上で 0 < |K - K_c| <= 1/10 で |f''(K) - (8/pi) log(1/|K-K_c|)| <= 49。
#       f'' は数値微分（mpmath の diff）で作る。|K - K_c| >= 1e-3 では arccosh 表示の f を直接微分した値とも比べる。
#   否定コントロール: (1) を K_c' = (1/2) log 2 にしたもの、(2) の係数 8/pi を 4/pi にしたものが
#                     成り立たないこと。
# 対象ラベル: critical_point_sinh_K_c_and_second_derivative_log_divergence
# 対象: structured-latex/content/critical_point_and_log_divergence.ts
#       ブロック critical_point_claim_sinh_K_c_and_second_derivative_log_divergence
# 帰属: (1) は QQbar の厳密計算。(2) の f は実対数と Riemann 積分の値（ℝ 脱出: 実対数・積分）で、
#       厳密計算できないので mpmath（dps=40）で計算する（055_claim_critical_point の共通定義）。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../055_claim_critical_point/_prelude.sage")
load(__file__)

all_ok = True

print("=== (1) sinh 2K_c = 1 と K_c > 0（QQbar で厳密） ===")
x = QQbar(1) + QQbar(2).sqrt()          # exp(2 K_c) = exp(log(1+sqrt2)) = 1 + sqrt2
sinh2Kc = (x - 1 / x) / 2
ok1 = (sinh2Kc == 1) and (x > 1)        # x > 1 <=> log x > 0 <=> K_c > 0
print(f"  (x - 1/x)/2 = {sinh2Kc}（= 1: {sinh2Kc == 1}）、x = 1+sqrt2 > 1: {x > 1}  -> {'PASS' if ok1 else 'FAIL'}")
all_ok = ok1 and all_ok
xbad = QQbar(2)                          # 否定コントロール: K_c' = (1/2) log 2
neg1 = ((xbad - 1 / xbad) / 2 != 1)
print(f"  否定コントロール K_c' = (1/2)log 2: sinh 2K_c' = {(xbad - 1/xbad)/2} != 1: {neg1}  -> {'PASS' if neg1 else 'FAIL'}")
all_ok = neg1 and all_ok
print(f"  数値: K_c = {mp.nstr(KC, 20)}、(1/2)log(1+sqrt2) = {mp.nstr(mp.log(1 + mp.sqrt(2)) / 2, 20)}")
grid = [mp.mpf(k) / 1000 for k in range(1, 3001)]
signs = [mp.sign(mp.sinh(2 * K) - 1) for K in grid]
changes = sum(1 for a, b in zip(signs, signs[1:]) if a != b)
ok_u = (changes == 1)
print(f"  K = 0.001,...,3 で sinh 2K - 1 の符号の変化: {changes} 回  -> {'PASS' if ok_u else 'FAIL'}")
all_ok = ok_u and all_ok


def f_goal(K):
    """主張の f: (1/2) log(2 sinh 2K) + (1/4pi) int_0^{2pi} arccosh(gamma_1(theta)) d theta（K_1 = K_2 = K）"""
    K = F(K)
    return (mp.log(2 * mp.sinh(2 * K)) / 2
            + mp.quad(lambda th: gamma_of(K, K, th), [0, PI, 2 * PI]) / (4 * PI))


print()
print("=== (2) 式変形: 主張の f = (1/2)log(2 sinh 2K) + G(kappa(K)) ===")
w = mp.mpf(0)
for K in [mp.mpf('0.2'), KC - mp.mpf('0.1'), KC - mp.mpf('1e-4'), KC + mp.mpf('1e-4'),
          KC + mp.mpf('0.1'), mp.mpf('1.3')]:
    w = max(w, abs(f_goal(K) - f_free(K)))
ok2 = w <= TOL_ACOSH
print(f"  max |f_goal - f_free| = {mp.nstr(w, 3)}（許容 {mp.nstr(TOL_ACOSH, 2)}。arccosh の条件数による）  -> {'PASS' if ok2 else 'FAIL'}")
all_ok = ok2 and all_ok

print()
print("=== (2) |f''(K) - (8/pi) log(1/|K-K_c|)| <= 49（0 < |K-K_c| <= 1/10） ===")
DKS = [mp.mpf('0.1'), mp.mpf('0.05'), mp.mpf('0.01'), mp.mpf('1e-3'),
       mp.mpf('1e-6'), mp.mpf('1e-12'), mp.mpf('1e-24')]
mx = mp.mpf(0); wd = mp.mpf(0); neg2 = False
for dK in DKS:
    for s in [1, -1]:
        K = KC + s * dK
        f2 = mp.diff(f_free, K, 2)
        if dK >= mp.mpf('1e-3'):
            wd = max(wd, abs(mp.diff(f_goal, K, 2) - f2))
        e = abs(f2 - 8 / PI * mp.log(1 / dK))
        mx = max(mx, e)
        if abs(f2 - 4 / PI * mp.log(1 / dK)) > 49:
            neg2 = True
        c = e <= 49
        print(f"  K-K_c={mp.nstr(s*dK,4):>8}: f''={mp.nstr(f2,10):>14}, 誤差={mp.nstr(e,6)}  -> {'PASS' if c else 'FAIL'}")
        all_ok = c and all_ok
okd = wd <= mp.mpf('1e-8')
print(f"  最大誤差 {mp.nstr(mx, 8)}（<= 49）")
print(f"  |K-K_c| >= 1e-3 で arccosh 表示の f を直接 2 回微分した値との差の最大 {mp.nstr(wd, 3)}  -> {'PASS' if okd else 'FAIL'}")
print(f"  否定コントロール: 係数を 4/pi にすると誤差 > 49 となる点がある: {neg2}  -> {'PASS' if neg2 else 'FAIL'}")
all_ok = okd and neg2 and all_ok

print()
print("ALL PASS" if all_ok else "SOME CHECK FAILED")
