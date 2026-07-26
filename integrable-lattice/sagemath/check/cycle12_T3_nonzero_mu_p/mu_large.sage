# cycle 12 / T3 Pure: μ_2 をどこまで大きくできるかの探索（2 頂点底グラフ, 広めの範囲）。
# 判定基準 (☆) μ_ℓ = v_ℓ(content_z(det L(z)))。辺重複度 gcd = 1 のもの（＝ℓ 重多重グラフ
# ではない非自明例）だけを「非自明」として集計する。

R = LaurentPolynomialRing(ZZ, 'z')
z = R.gen()
from itertools import combinations_with_replacement
from collections import Counter

def det_and_content(edges):
    L = matrix(R, 2, 2)
    for (u, v, a) in edges:
        if u == v:
            L[u, u] += 2 - z**a - z**(-a)
        else:
            L[u, u] += 1; L[v, v] += 1
            L[u, v] -= z**a; L[v, u] -= z**(-a)
    D = det(L)
    if D == 0:
        return D, 0
    return D, gcd([ZZ(c) for c in D.coefficients()])

def mult_gcd(edges):
    c = Counter(tuple(sorted((u, v))) + (a,) for (u, v, a) in edges)
    return gcd(list(c.values()))

VMAX = 4          # 平行辺 voltage は 0..VMAX
KMAX = 6          # 平行辺の本数 ≤ KMAX
LOOPV = [1, 2, 3] # ループ voltage
LMAX = 3          # 各頂点のループ本数 ≤ LMAX

loopsets = []
for k in range(0, LMAX + 1):
    for B in combinations_with_replacement(LOOPV, k):
        loopsets.append(B)

best = {}
total = 0
for ka in range(1, KMAX + 1):
    for A in combinations_with_replacement(range(0, VMAX + 1), ka):
        if A[0] != 0:      # 平行辺 voltage の一斉平行移動で det は不変 → min A = 0 に正規化
            continue
        for B in loopsets:
            for C in loopsets:
                edges = [(0, 1, a) for a in A] + [(0, 0, b) for b in B] + [(1, 1, b) for b in C]
                D, cont = det_and_content(edges)
                if cont == 0:
                    continue
                total += 1
                mg = mult_gcd(edges)
                for p in [2, 3, 5]:
                    v = ZZ(cont).valuation(p)
                    if v > 0:
                        key = (p, mg == 1)
                        if key not in best or v > best[key][0]:
                            best[key] = (v, A, B, C, cont, D)

print("=" * 78)
print("μ_ℓ の最大値探索（2 頂点底グラフ）")
print(f"探索範囲: 平行辺 voltage ⊂ {{0..{VMAX}}} 本数 ≤ {KMAX}（min=0 正規化）, ")
print(f"          各頂点のループ voltage ⊂ {LOOPV} 本数 ≤ {LMAX}")
print(f"検査した底グラフ数: {total}")
print("=" * 78)
for p in [2, 3, 5]:
    for nontrivial in [True, False]:
        key = (p, nontrivial)
        tag = "非自明(辺重複度gcd=1)" if nontrivial else "自明含む(辺重複度gcd>1)"
        if key not in best:
            print(f"\nℓ={p} / {tag}: 該当なし")
            continue
        v, A, B, C, cont, D = best[key]
        print(f"\nℓ={p} / {tag}: 最大 μ_{p} = {v}")
        print(f"  A(平行辺 voltage)={A}, loop@0={B}, loop@1={C}")
        print(f"  det L(z) = {D}")
        print(f"  content = {factor(cont)}")

print("\n" + "=" * 78)
print("正直な注記: これは上記の有限探索範囲内での最大値であり、μ_2 が有界であることの")
print("根拠ではない。範囲を広げれば大きな μ が出うる（探索範囲は上に明示）。")
print("=" * 78)
