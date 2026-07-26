# cycle 13 / T1 step 3: 観察 T の標本拡大（厳密整数計算）
#
# 対象: tau(L) = L x L トーラス（周期境界の正方格子, C_L box C_L）の全域木数。
# 観察 T: 奇数 L に対し v_2(tau(L)) = 2(L-1)。
#
# 本スクリプトは tau(L) を「証明で使う分解を一切使わずに」計算する:
#   tau(L) = Res_x( f_L(x)/(x-2),  f_L(4-x) ),   f_L(x) = prod_{k=0}^{L-1}(x - 2cos(2 pi k / L))
# これは標準の積公式
#   tau(L) = (1/L^2) prod_{(j,k) != (0,0)} (4 - 2cos(2 pi j/L) - 2cos(2 pi k/L))
# を ZZ[x] 上の終結式へ書き直したもの（導出は README §1）。整数演算のみ・厳密。
#
# f_L は Chebyshev の記号展開ではなく漸化式 p_n = x p_{n-1} - p_{n-2} (p_0=2, p_1=x) で作る
# （p_n = t^n + t^{-n}, x = t + 1/t）。大きい L でも高速。
#
# 実行: sage tau_v2_evidence.sage

import time

R.<x> = ZZ[]

def p_seq(n):
    """p_n(x) = t^n + t^{-n} in ZZ[x], where x = t + 1/t."""
    a, b = R(2), x
    if n == 0:
        return a
    for _ in range(n - 1):
        a, b = b, x * b - a
    return b

def f_poly(L):
    """f_L(x) = prod_{k=0}^{L-1} (x - (zeta_L^k + zeta_L^{-k})) = t^L - 2 + t^{-L}."""
    return p_seq(L) - 2

def tau_res(L):
    """tau(L) via the resultant form of the standard product formula."""
    f = f_poly(L)
    q = f // (x - 2)
    assert q * (x - 2) == f, "x-2 must divide f_L"
    return q.resultant(R(f(4 - x)))

def tau_kirchhoff(L):
    """tau(L) via Kirchhoff's matrix-tree theorem on the actual graph C_L box C_L."""
    C = graphs.CycleGraph(L)
    return C.cartesian_product(C).spanning_trees_count()


print("=" * 78)
print("A. 二方法の一致（Kirchhoff の matrix-tree 定理 vs 積公式=終結式）")
print("=" * 78)
print("  L=3..12 で両者を独立に計算して比較する。")
print("  （L<=2 は C_L が単純グラフでないため Sage の CycleGraph では表現できない。除外。）")
ok_all = True
for L in range(3, 13):
    a, b = tau_res(L), tau_kirchhoff(L)
    ok = (a == b)
    ok_all = ok_all and ok
    print("  L=%2d  一致=%s  tau(L)=%s" % (L, ok, factor(a)))
print("  全一致:", ok_all)
assert ok_all

print()
print("=" * 78)
print("B. 奇数 L: v_2(tau(L)) と 2(L-1) の比較（標本拡大）")
print("=" * 78)
odd_range = list(range(3, 302, 2)) + list(range(311, 502, 10))
mismatch = []
t0 = time.time()
for L in odd_range:
    v = tau_res(L).valuation(2)
    if v != 2 * (L - 1):
        mismatch.append((L, v))
print("  検査した奇数 L: 3,5,...,301 の全て（150 個）＋ 311,321,...,501（20 個）＝ 170 個")
print("  v_2(tau(L)) != 2(L-1) となった L:", mismatch if mismatch else "なし（170/170 で一致）")
print("  所要 %.1f 秒" % (time.time() - t0))
print()
print("  最初と最後のいくつかを明示:")
for L in [3, 5, 7, 9, 11, 19, 21, 101, 201, 301, 401, 501]:
    print("    L=%3d  v_2(tau(L))=%4d  2(L-1)=%4d" % (L, tau_res(L).valuation(2), 2 * (L - 1)))

print()
print("=" * 78)
print("C. 偶数 L: v_2(tau(L)) の実測（奇偶の違いを一次情報として記録）")
print("=" * 78)
print("  s := v_2(L) と置く。表: L, s, v_2(tau(L)), 2(L-1)（奇数則を当てはめた場合の値）")
even_data = []
for L in range(2, 129, 2):
    L = ZZ(L)
    s = L.valuation(2)
    v = tau_res(L).valuation(2)
    even_data.append((L, s, v))
for (L, s, v) in even_data[:16]:
    print("    L=%3d  s=%d  v_2=%5d   2(L-1)=%4d   差=%5d" % (L, s, v, 2 * (L - 1), v - 2 * (L - 1)))
print("    ...")
for (L, s, v) in even_data[-4:]:
    print("    L=%3d  s=%d  v_2=%5d   2(L-1)=%4d   差=%5d" % (L, s, v, 2 * (L - 1), v - 2 * (L - 1)))
print()
print("  ⇒ 偶数 L では 2(L-1) から系統的に大きく外れる＝奇数則は偶数へ延びない。")
print()
print("  観察 T'（偶数 L, 本セッションで新たに気づいた規則。未証明）:")
print("      v_2(tau(L)) = (2s+4) L - (6s+1)      (L 偶数, s = v_2(L))")
bad = [(L, v) for (L, s, v) in even_data if v != (2 * s + 4) * L - (6 * s + 1)]
print("  検査 L=2,4,...,128（64 個）で外れた L:", bad if bad else "なし（64/64 で一致）")
print("  注: s が同じなら L の奇部分に依らない。s=0（奇数 L）へは延びない")
print("      （s=0 を代入すると 4L-1 となり実測 2L-2 と異なる）。")

print()
print("=" * 78)
print("D. 標本範囲の明示（0 件観察を根拠にしないための記録）")
print("=" * 78)
print("  奇数 L: L=3,5,...,301 の全 150 個 ＋ L=311,321,...,501 の 20 個 = 170 個。")
print("  偶数 L: L=2,4,...,128 の全 64 個。")
print("  これは有限標本であり、それ自体は証明ではない。証明は tau_v2_proof_check.sage / README §2。")
