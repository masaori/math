# cycle 17 / T3 Pure: delta_examples.sage で決め打ちしている例の**出所**を再現する探索。
#
# delta_examples.sage は例を決め打ちしているので、そのままでは
# 「都合のよい例を拾ってきただけではないか」が確認できない。
# 本スクリプトは、それらの例をどの族・どの seed の掃引から拾ったかを再現し、
# 同種の例が何件あるか（＝孤立した偶然ではないこと）を示す。
#
# 探索 1: 乱択掃引（ブーケ・2 頂点・3 頂点）。非退化例の「ずれ指数」と Delta の同時分布。
#         D1・D2・D3 はここ（seed 20260731、頂点数 <= 2、辺数 <= 6、box 3）から拾った。
# 探索 2: 同じ乱択掃引を頂点数 <= 3・辺数 <= 7 に広げたもの。
#         D4・D5・B6 はここから拾った。
# 探索 3: 的を絞った探索（2 頂点 ell 重平行辺 + ループ）。kappa(X) = ell なので
#         v_ell(kappa(X)) = 1 が保証される族。B1・B2・B3 はここから拾った。
#
# 実行: sage search_examples.sage

import os
import sys
import random
from collections import Counter

sys.stdout.reconfigure(line_buffering=True)
HERE = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(HERE, '..', 'cycle16_T3_lower_order', '_defs.sage'))


def eps_profile(D, ell, mu):
    Ev = E_of(D, ell, mu)
    f = f_series(Rzw(Lzw(Ev) * zL**16 * wL**16))
    prof = {}
    for (e, c) in f.dict().items():
        if c == 0:
            continue
        d = e[0] + e[1]
        prof[d] = min(prof.get(d, oo), ZZ(c).valuation(ell))
    return prof


def defect_index(prof, k, ell):
    cand = [prof[d] * (ell - 1) + d for d in prof if d < k]
    return None if not cand else min(cand) - k


def rand_graph(rng, nv_max, emax, box):
    m = rng.randint(1, nv_max)
    r = rng.randint(2, emax)
    edges = []
    for _ in range(r):
        if m == 1:
            u = v = 0
        else:
            u = rng.randrange(m); v = rng.randrange(m)
        edges.append((u, v, (rng.randint(-box, box), rng.randint(-box, box))))
    return m, edges


def sweep(tag, ells, nv_max, emax, box, samples, seed, show=6):
    print()
    print("=" * 74)
    print("%s  （頂点数<=%d、辺数<=%d、voltage in [-%d,%d]^2、%d 標本、seed=%d）"
          % (tag, nv_max, emax, box, box, samples, seed))
    print("=" * 74)
    for ell in ells:
        rng = random.Random(int(seed))
        st = Counter()
        joint = Counter()
        hits = []
        for _ in range(samples):
            m, edges = rand_graph(rng, nv_max, emax, box)
            inv = invariants(m, edges, ell)
            if inv is None:
                continue
            st['有効'] += 1
            if len(inv['zeros']) != 0:
                continue
            st['非退化'] += 1
            prof = eps_profile(inv['D'], ell, inv['mu'])
            d0 = defect_index(prof, inv['k'], ell)
            Dl = delta_correction(inv['D'], ell, inv['mu'], inv['k'], inv['J0'])
            if Dl is None:
                continue
            joint[(d0 is None or d0 > 0, Dl == 0)] += 1
            if Dl != 0:
                st['Delta != 0'] += 1
                hits.append((m, edges, inv, d0, Dl))
        print()
        print("  ell=%d: 有効 %d / 非退化 %d / Delta != 0 %d"
              % (ell, st['有効'], st['非退化'], st['Delta != 0']))
        print("    (ずれ指数>0, Delta=0) 同時分布 = %s"
              % {("delta>0" if a else "delta<=0", "Delta=0" if b else "Delta!=0"): c
                 for ((a, b), c) in sorted(joint.items(), key=lambda x: (not x[0][0], not x[0][1]))})
        print("    うち v_ell(kappa(X))>0 が %d 件、mu>0 が %d 件、両方が %d 件"
              % (len([h for h in hits if h[2]['vkX'] > 0]),
                 len([h for h in hits if h[2]['mu'] > 0]),
                 len([h for h in hits if h[2]['vkX'] > 0 and h[2]['mu'] > 0])))
        for (m, edges, inv, d0, Dl) in hits[:show]:
            print("      m=%d k=%d J0=%d mu=%d kX=%d vkX=%d delta=%s Delta=%s edges=%s"
                  % (m, inv['k'], inv['J0'], inv['mu'], inv['kX'], inv['vkX'], d0, Dl, edges))


# 探索 1: D1・D2・D3 の出所
sweep("探索 1: Delta != 0 の例の出所（D1・D2・D3）", [2, 3, 5, 7],
      nv_max=int(2), emax=int(6), box=int(3), samples=int(4000), seed=int(20260731))

# 探索 2: D4・D5・B6 の出所（3 頂点・7 辺まで広げる）
sweep("探索 2: 3 寄与同時の例の出所（D4・D5・B6）", [2, 3],
      nv_max=int(3), emax=int(7), box=int(3), samples=int(6000), seed=int(20260801))

# 探索 3: B1・B2・B3 の出所
print()
print("=" * 74)
print("探索 3: v_ell(kappa(X))>0 かつ非退化（2 頂点 ell 重平行辺 + ループ、kappa(X)=ell）")
print("=" * 74)
for ell in [3, 5, 7, 11, 13]:
    rng = random.Random(int(20260731))
    got = []
    tried = 0
    for _ in range(4000):
        nl = rng.randint(0, 2)
        edges = [(0, 1, (rng.randint(-2, 2), rng.randint(-2, 2))) for _ in range(ell)] \
              + [(0, 0, (rng.randint(-2, 2), rng.randint(-2, 2))) for _ in range(nl)]
        tried += 1
        inv = invariants(2, edges, ell)
        if inv is None:
            continue
        if inv['vkX'] > 0 and len(inv['zeros']) == 0:
            got.append((edges, inv))
            if len(got) >= 4:
                break
    print()
    print("  ell=%2d: 試行 %d、非退化かつ v_ell(kappa(X))>0 が %d 件" % (ell, tried, len(got)))
    for (edges, inv) in got:
        print("    kX=%d vkX=%d mu=%d k=%d J0=%d edges=%s"
              % (inv['kX'], inv['vkX'], inv['mu'], inv['k'], inv['J0'], edges))

# 探索 3': B4・B5 の出所（平行辺の voltage を (0,0) に固定し、ループ 2 本を系統的に振る）
print()
print("=" * 74)
print("探索 3': 同じ族の系統列挙（平行辺は全て voltage (0,0)、ループ 2 本を全数列挙）")
print("=" * 74)
import itertools
VBOX = [(a, b) for a in range(-2, 3) for b in range(-2, 3)]
for ell in [3, 5, 7]:
    got = []
    tried = 0
    for (l1, l2) in itertools.combinations_with_replacement(VBOX, int(2)):
        edges = [(0, 1, (0, 0))] * ell + [(0, 0, l1), (0, 0, l2)]
        tried += 1
        inv = invariants(2, edges, ell)
        if inv is None:
            continue
        if inv['vkX'] > 0 and len(inv['zeros']) == 0:
            got.append((edges, inv))
    print()
    print("  ell=%2d: 列挙 %d、非退化かつ v_ell(kappa(X))>0 が %d 件" % (ell, tried, len(got)))
    for (edges, inv) in got[:3]:
        print("    kX=%d vkX=%d mu=%d k=%d J0=%d edges=%s"
              % (inv['kX'], inv['vkX'], inv['mu'], inv['k'], inv['J0'], edges))

print()
print("=" * 74)
print("注: この族では kappa(X)=ell（2 頂点 p 本平行辺の全域木数は p）なので")
print("    v_ell(kappa(X))=1 が構成から保証される。cycle 16 が『2 頂点 ell 重平行辺で")
print("    狙ったが構成した候補はすべて退化した』と報告したのは、平行辺だけでは")
print("    voltage の自由度が足りないためである。ループを 2 本足すと（探索 3'）")
print("    ell=3 と ell=7 では非退化例が大量に出る（それぞれ 208 / 248 件）。")
print("    ell=5 が探索 3' で 0 件なのは偶然ではない: この族は平行辺が voltage を")
print("    運ばずループ 2 本だけが運ぶので H はトーラス型 -(T^2+S^2) になり、")
print("    非退化 <=> -1 が F_ell の平方でない（cycle14 §8.4）。-1 は mod 3, mod 7 で")
print("    非平方、mod 5 で平方（-1 = 2^2）なので ell=5 だけ必ず退化する。")
print("    ell=5 の例 B4 は探索 3（平行辺の voltage も振る側）から取っており、")
print("    ell=3 の例 B5 は探索 3' から取っている。")
print("=" * 74)
print("終了 %s" % el())
