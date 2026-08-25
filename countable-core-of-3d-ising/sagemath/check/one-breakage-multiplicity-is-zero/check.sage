# 対象ラベル: claim_one_breakage_multiplicity_is_zero
# 本文の三段を、有限箱の辺の構成と全配位の列挙により ZZ の厳密計算で確認する。
from itertools import product

FAIL = []


def unit(direction):
    return tuple(ZZ(1) if k == direction else ZZ(0) for k in range(3))


def add(a, b):
    return tuple(a[k] + b[k] for k in range(3))


def sub(a, b):
    return tuple(a[k] - b[k] for k in range(3))


def box_sites(box_side):
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


def edge_set(box_side):
    # 本文の定義: 始点と方向の組で、第 direction 成分が box_side - 2 以下のもの
    return [
        (start, direction)
        for start in box_sites(box_side)
        for direction in range(3)
        if start[direction] <= box_side - 2
    ]


def configurations(box_side):
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_edges(configuration, box_side):
    return [
        (start, direction)
        for (start, direction) in edge_set(box_side)
        if configuration[start] != configuration[add(start, unit(direction))]
    ]


print("== 段 1: 各辺について同じ面をなす三本の辺が取れる ==")
for box_side in [2, 3, 4]:
    sites = set(box_sites(box_side))
    edges = set(edge_set(box_side))
    ok = True
    for (a, i) in sorted(edges):
        for j in [d for d in range(3) if d != i]:
            if a[j] <= box_side - 2:
                c = a
            else:
                c = sub(a, unit(j))
            f1 = (c, j)
            f2 = (c, i)
            f3 = (add(c, unit(i)), j)
            ok = ok and c in sites
            ok = ok and f1 in edges and f2 in edges and f3 in edges
            ok = ok and (a == c or a == add(c, unit(j)))
    print("  box_side =", box_side, ": すべての辺で構成できる =", ok)
    if not ok:
        FAIL.append(("段 1", box_side))

print("== 段 2: 破れ数がちょうど 1 の配位は存在しない ==")
for box_side in [2]:
    count_one = ZZ(
        sum(1 for s in configurations(box_side) if len(broken_edges(s, box_side)) == 1)
    )
    print("  box_side =", box_side, ": Omega_L(1) =", count_one)
    if count_one != ZZ(0):
        FAIL.append(("段 2", box_side))

print("== 段 3: 破れ数の集合に 1 が現れないこと（多重度の並び） ==")
for box_side in [2]:
    multiplicity = {}
    for s in configurations(box_side):
        m = ZZ(len(broken_edges(s, box_side)))
        multiplicity[m] = multiplicity.get(m, ZZ(0)) + ZZ(1)
    print("  box_side =", box_side, ": 多重度が正の破れ数 =", sorted(multiplicity))
    if multiplicity.get(ZZ(1), ZZ(0)) != ZZ(0):
        FAIL.append(("段 3", box_side))
    if multiplicity.get(ZZ(0), ZZ(0)) != ZZ(2):
        FAIL.append(("段 3（破れ数ゼロが二）", box_side))

print("ALL PASS" if not FAIL else "FAIL: %s" % FAIL)
