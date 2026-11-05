# 対象ラベル: kappa_of_K_basic
# 主張の K_c と準備（K_c > 0、cosh 2K_c = √2、√2 の小数の評価）と (2) の同値の鎖を、AA（実代数的数）と QQ[w] で厳密に確かめる。
# 書き換え: w := exp(2K) と置くと sinh 2K = (w − 1/w)/2、cosh 2K = (w + 1/w)/2、tanh K = (w − 1)/(w + 1)、
#   exp(2K^*) = 1/tanh K（def_isotropic_dual_coupling）。exp は狭義単調増加で exp(0) = 1 なので、K > 0 ⟺ w > 1、
#   K = K' ⟺ w = w'（exp の単射性）。この書き換えは本文の証明には無く、検算の側で使う標準の事実である。浮動小数点は使わない。
import sys
def dec(t):
    """小数の文字列を QQ の元にする（浮動小数点を経ない）"""
    i, f = t.split('.')
    return QQ(Integer(i + f)) / 10^len(f)
ok = True
def check(name, cond):
    global ok
    print(("PASS " if cond else "FAIL ") + name)
    ok = ok and bool(cond)

# K_c: sinh 2K_c = 1 ⟺ w − 1/w = 2 ⟺ w^2 − 2w − 1 = 0。w > 0 の根は 1 + √2 だけ
P = PolynomialRing(QQ, 'w'); w = P.gen()
q = w^2 - 2*w - 1
roots = q.roots(AA, multiplicities=False)
pos = [r for r in roots if r > 0]
r2 = AA(2).sqrt()
check("sinh 2K_c = 1 の w > 0 の解は 1 + √2 ただ一つ", pos == [1 + r2])
wc = 1 + r2
check("2K_c = arcsinh(1) = log(1 + √(1^2+1)): exp(2K_c) = 1 + √2（def_arcsinh）", wc == 1 + AA(1^2 + 1).sqrt())
check("準備 K_c > 0: w_c = 1 + √2 > 1", wc > 1)
# w ∈ (0, 1]（2K ≤ 0）なら sinh 2K = (w − 1/w)/2 = (w − 1)(w + 1)/(2w) ≤ 0（w − 1 ≤ 0、w + 1 > 0、2w > 0）
Fw = FractionField(P)
check("準備 K_c > 0 の背理法: (w − 1/w)/2 = (w − 1)(w + 1)/(2w)", (Fw(w) - 1 / Fw(w)) / 2 == (w - 1) * (w + 1) / (2 * Fw(w)))
check("準備 K_c > 0 の背理法: w ∈ {1/100, 1/3, 1/2, 9/10, 1} で (w − 1/w)/2 ≤ 0 < 1（sinh 2K_c = 1 に反する）",
      all((t - 1/t) / 2 <= 0 for t in [QQ(1)/100, QQ(1)/3, QQ(1)/2, QQ(9)/10, QQ(1)]))
check("準備 K_c > 0 の背理法: sinh 0 = (1 − 1)/2 = 0（sinh_zero）", (QQ(1) - 1) / 2 == 0)
sh2c = (wc - 1/wc) / 2
ch2c = (wc + 1/wc) / 2
check("K_c の定義の確認 sinh 2K_c = 1", sh2c == 1)
check("準備 (cosh 2K_c)^2 = 1 + (sinh 2K_c)^2", ch2c^2 == 1 + sh2c^2)
check("準備 1 + 1^2 = 2 = (√2)^2", 1 + 1^2 == 2 and r2^2 == 2)
check("準備 cosh 2K_c = √2", ch2c == r2)
check("準備 cosh 2K_c > 0、√2 > 0", ch2c > 0 and r2 > 0)
check("対照: cosh 2K_c = −√2 ではない", ch2c != -r2)
# √2 の小数の評価
a, b = dec('1.414213'), dec('1.414214')
check("1.414213^2 = 1.999998409369", a^2 == dec('1.999998409369'))
check("1.999998409369 ≤ 2", dec('1.999998409369') <= 2)
check("2 ≤ 2.000001237796", 2 <= dec('2.000001237796'))
check("2.000001237796 = 1.414214^2", b^2 == dec('2.000001237796'))
check("結論 1.414213 ≤ √2 ≤ 1.414214（AA で）", AA(a) <= r2 <= AA(b))
check("対照: 1.414214 は √2 の下界ではない", not (AA(b) <= r2))

# (2) の同値の鎖。K ∈ ℝ_{>0}（w > 1）。各行の条件を w の多項式の零点として書く。
# 1 行目 κ(K) = 0 ⟺ 2K = 2K^* ⟺ w = exp(2K^*) = 1/tanh K = (w + 1)/(w − 1) ⟺ w(w − 1) − (w + 1) = 0
c1 = w * (w - 1) - (w + 1)
# 2 行目 κ = 0（def_kappa の κ = 2K_1 − 2K_2^*。def_second_dual_coupling_constant の K_2^* = −(1/2)log tanh K_2 から
#   exp(2K_2^*) = (w_2 + 1)/(w_2 − 1)）。κ = 0 ⟺ w_1 = (w_2 + 1)/(w_2 − 1) ⟺ w_1(w_2 − 1) − (w_2 + 1) = 0。K_1 = K_2 = K で w_1 = w_2 = w
P12 = PolynomialRing(QQ, 'w1,w2'); W1, W2 = P12.gens()
c2_two = W1 * (W2 - 1) - (W2 + 1)
c2 = c2_two(w, w)                                   # w_1 = w_2 = w を代入
# 3 行目 s_1 s_2 = 1、4 行目 sinh^2 2K = 1: ((w − 1/w)/2)^2 = 1 ⟺ (w^2 − 1)^2 − 4w^2 = 0
c3 = (w^2 - 1)^2 - 4 * w^2
# 5 行目 sinh 2K = 1 ⟺ w^2 − 2w − 1 = 0
c5 = q
check("1 行目 κ(K) = 0 の条件は w^2 − 2w − 1 = 0", c1 == q)
check("1 行目 ⟺ 2 行目: def_kappa の κ を K_1 = K_2 = K に置いた条件が、def_isotropic_kappa_of_K の κ(K) の条件と一致（isotropic_kappa_equals_kappa_of_K）", c2 == c1)
check("2 行目 対照: K_1 ≠ K_2 なら κ = 0 の条件は κ(K) の条件と恒等的には等しくない", c2_two != c1(W2))
P2 = FractionField(PolynomialRing(QQ, 'w1,w2')); w1, w2 = P2.gens()
s_of = lambda u: (u - 1/u) / 2
check("3 行目 ⟺ 4 行目: s_1s_2 = sinh 2K_1 sinh 2K_2 は K_1 = K_2 = K（w_1 = w_2 = w）で sinh^2 2K",
      (s_of(w1) * s_of(w2)).subs(w1=w2) == s_of(w2)^2)
check("3 行目 対照: K_1 ≠ K_2 なら s_1s_2 は sinh^2 2K_2 と恒等的には等しくない", s_of(w1) * s_of(w2) != s_of(w2)^2)
check("4 行目の条件は (w^2 − 2w − 1)(w^2 + 2w − 1)", c3 == (w^2 - 2*w - 1) * (w^2 + 2*w - 1))
check("4 行目 ⟺ 5 行目: w > 1 では w^2 + 2w − 1 = (w − 1)^2 + 4w − 2 > 0", w^2 + 2*w - 1 == (w - 1)^2 + 4*w - 2)
check("2 行目 ⟺ 3 行目（critical_point_iff_kappa_zero）: w > 1 の根の集合が一致",
      sorted(r for r in c2.roots(AA, multiplicities=False) if r > 1) == sorted(r for r in c3.roots(AA, multiplicities=False) if r > 1))
check("5 行目 ⟺ 6・7 行目: w > 1 の根は w_c だけ（sinh の単射性と exp の単射性）",
      [r for r in c5.roots(AA, multiplicities=False) if r > 1] == [wc])
check("κ(K_c) = 0: w_c は 1 行目の条件を満たす", c1(wc) == 0)
check("対照: 4 行目の w > 0 の根 √2 − 1（sinh 2K = −1、K < 0）は w > 1 から外れる",
      [r for r in c3.roots(AA, multiplicities=False) if 0 < r < 1] == [r2 - 1])
check("対照: K > 0 の仮定を外すと sinh^2 2K = 1 は sinh 2K = 1 より根が多い",
      len([r for r in c3.roots(AA, multiplicities=False) if r > 0]) == 2)

print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)
