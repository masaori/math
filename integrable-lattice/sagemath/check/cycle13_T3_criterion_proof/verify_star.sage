# cycle 13 / T3 Pure: 公式 (★) と連結性判定の機械検証。
#
#   (★)   N · κ(X_N) = κ(X) · ∏_{ζ^N=1, ζ≠1} det L(ζ)          （任意の有限多重グラフ X, 任意の N ≥ 1）
#
# 証明本体は outputs/reports/cycle13_T3_mu_content_criterion_proof.md の 定理 3.4。
# ここでは証明の各仮定・各退化ケースが実際に主張どおりかを網羅的に確認する。
# 右辺の ∏ は終結式で **厳密な整数** として計算する（数値評価をしない＝ℝ/ℂ を経由しない）。

import os, sys
_HERE = os.path.dirname(os.path.abspath(sys.argv[0])) if (sys.argv and sys.argv[0]) else os.getcwd()
_LIB = os.path.join(_HERE, "lib_voltage.sage")
load(_LIB if os.path.exists(_LIB) else "lib_voltage.sage")

NFAIL = 0

def check(cond, msg):
    global NFAIL
    if not cond:
        NFAIL += 1
        print("    *** FAIL: " + msg)

print("=" * 78)
print("A. (★) N·κ(X_N) = κ(X)·∏_{ζ≠1} det L(ζ) を N = 1..12 で厳密検証")
print("=" * 78)

CASES = [
    # (名前, m, edges)  edges = [(u, v, voltage)]
    ("bouquet 1 ループ voltage 1",              1, [(0, 0, 1)]),
    ("bouquet 2 ループ voltage 1,2",            1, [(0, 0, 1), (0, 0, 2)]),
    ("bouquet ループ voltage 0 のみ（退化）",    1, [(0, 0, 0)]),
    ("bouquet voltage 0 と 1 の混在",           1, [(0, 0, 0), (0, 0, 1)]),
    ("cycle12 例1（2頂点, content 12）",         2, [(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]),
    ("cycle12 例2（content 16）",                2, [(0,1,0),(0,1,1),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]),
    ("cycle12 例3（content 23）",                2, [(0,1,0),(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1),(1,1,1)]),
    ("cycle12 例4（3頂点, content 48）",          3, [(0,1,1),(0,1,1),(0,2,0),(0,2,1),(1,2,1),(1,2,1),(0,0,1),(2,2,1)]),
    ("cycle12 例5（content 9, λ≠1）",            2, [(0,1,0),(0,1,0),(0,1,0),(0,1,1)] + [(0,0,1)]*3 + [(1,1,1)]*3),
    ("cycle12 例6（content 5, 辺4本）",           2, [(0,1,0),(0,1,1),(1,1,1),(1,1,1)]),
    ("多重辺のみ・voltage 全て 0（全 N で非連結）", 2, [(0,1,0),(0,1,0),(0,1,0)]),
    ("voltage が potential（d=0, D≡0）",         3, [(0,1,1),(1,2,2),(0,2,3)]),
    ("d=2（偶数 N で非連結）",                    2, [(0,1,0),(0,1,2),(0,0,4)]),
    ("d=6（N=2,3,6 の倍数で非連結）",              2, [(0,1,0),(0,1,6),(1,1,6)]),
    ("木（サイクル無し, D≡0）",                   3, [(0,1,5),(1,2,7)]),
    ("底グラフ自体が非連結",                      3, [(0,1,1),(2,2,1)]),
    ("ループ voltage 0 を含む 2 頂点",            2, [(0,1,0),(0,1,1),(0,0,0),(1,1,0)]),
    ("負 voltage",                              2, [(0,1,-1),(0,1,2),(1,1,-3)]),
    ("大きめ 4 頂点",                            4, [(0,1,1),(1,2,2),(2,3,1),(3,0,0),(0,2,3),(1,3,1),(0,0,2)]),
]

for (name, m, edges) in CASES:
    D = detL(m, edges)
    k0 = kappa_derived(m, edges, 1)
    print(f"\n[{name}]  m={m}, |E|={len(edges)}")
    print(f"    det L(z) = {D}")
    print(f"    κ(X) = {k0}, content_z = {content_z(D)}")
    ok_all = True
    for N in range(1, 13):
        lhs = N * kappa_derived(m, edges, N)
        rhs = k0 * prod_detL_nontrivial(D, N)
        if lhs != rhs:
            ok_all = False
            print(f"    N={N}: LHS={lhs} RHS={rhs}")
    check(ok_all, f"(★) が {name} で破れた")
    print(f"    (★) N=1..12 全一致: {ok_all}")

print("\n" + "=" * 78)
print("B. 連結性判定: X_N の連結成分数 = gcd(d, N)（d = サイクル voltage の生成元）")
print("=" * 78)
print("   ＋ 系: X_N 連結 ⟺ 全ての ζ ∈ μ_N \\ {1} で det L(ζ) ≠ 0")
for (name, m, edges) in CASES:
    if num_components(m, edges, 1) != 1:
        print(f"\n[{name}] 底が非連結のため d は定義しない（判定命題の仮定外）")
        continue
    d = voltage_index(m, edges)
    D = detL(m, edges)
    rows = []
    ok = True
    for N in range(1, 13):
        c = num_components(m, edges, N)
        pred = gcd(d, N)
        if c != pred:
            ok = False
        # det L(ζ) ≠ 0 (∀ζ≠1) ⟺ ∏_{ζ≠1} det L(ζ) ≠ 0
        nonvanish = (prod_detL_nontrivial(D, N) != 0)
        conn = (c == 1)
        if nonvanish != conn:
            ok = False
        rows.append((N, c, pred))
    check(ok, f"連結性判定が {name} で破れた")
    print(f"\n[{name}] d = {d}: 成分数 = gcd(d,N) と det L(ζ)≠0 同値, N=1..12 全一致: {ok}")

print("\n" + "=" * 78)
print("C. content 保存: content_z(D(z)) = content_T(P(1+T))  （z ↦ 1+T は ℤ 上可逆）")
print("=" * 78)
for (name, m, edges) in CASES:
    D = detL(m, edges)
    if D == 0:
        print(f"[{name}] D ≡ 0（content 未定義, 判定式の仮定外）")
        continue
    M, P = laurent_to_poly(D)
    g = RT(P(1 + TT))
    c1 = content_z(D)
    c2 = gcd([ZZ(c) for c in g.list() if c != 0])
    check(c1 == c2, f"content 不変が {name} で破れた: {c1} vs {c2}")
    print(f"[{name}] content_z = {c1}, content_T(P(1+T)) = {c2}, 一致 = {c1 == c2}")

print("\n" + "=" * 78)
print("D. bouquet（m=1）では content = ループ重複度の gcd（＝μ>0 は ℓ 重多重グラフの自明例のみ）")
print("=" * 78)
from collections import Counter
BOUQUETS = [
    [1], [1, 1], [1, 2], [1, 1, 2, 2], [2, 2, 2], [1, 2, 3],
    [3, 3, 3, 3], [1, 1, 1, 5, 5, 5], [0, 1, 1], [0, 0, 2, 2],
]
for loops in BOUQUETS:
    edges = [(0, 0, a) for a in loops]
    D = detL(1, edges)
    if D == 0:
        print(f"  loops={loops}: D ≡ 0（voltage 0 のみ）")
        continue
    cnt = Counter(abs(a) for a in loops if a != 0)
    g = gcd(list(cnt.values()))
    c = content_z(D)
    check(c == g, f"bouquet content が loops={loops} で破れた: {c} vs {g}")
    print(f"  loops={loops}: det L = {D}, content = {c}, 重複度 gcd = {g}, 一致 = {c == g}")

print("\n" + "=" * 78)
print(f"FAIL 数: {NFAIL}")
print("=" * 78)
