"""各連結成分の標準代表として直線ループの合併を試し、代表値を直接評価する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

固定した反転対 D ごとに、許される鍵 (D,E) をプラケット対称差で結んだ
有限グラフの各連結成分について、標準代表の候補として
「直線ループの合併」（行ループ = 一つの行の水平辺全部、
列ループ = 一つの列の垂直辺全部、の合併）を試す。調べるのは

  1. 各連結成分が直線ループの合併を代表として含むか。
  2. 含むとき、その代表での四項（動辺数・頂点項・非共有端点対項・標的指数）が
     行集合・列集合の取り方の位置に依らず、行数と列数だけで決まるか。

観測の固定: 直線合併を含む成分では四項は位置に依らない（混在零）。
一辺三（D は空）では、直線合併の頂点項・対項は常に零で、動辺数と標的指数は
行数と列数の和の偶奇に一致する。しかし巻き付き (1,1) の成分は直線合併を含まない
（行ループと列ループの合併は非自明文字なので許される鍵に入らない）。
一辺二では 324 成分のうち直線合併を含むのは 108 成分だけで、含まない 216 成分は
四つの巻き付き類全てに現れる。従って直線ループの合併だけでは標準代表系に足りない。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-plaquette-deformation/check.sage")


def row_loop(side, row):
    return frozenset(("h", row, column) for column in range(side))


def column_loop(side, column):
    return frozenset(("v", row, column) for row in range(side))


def straight_union_table(side):
    table = {}
    for rows in Subsets(range(side)):
        for columns in Subsets(range(side)):
            union = frozenset().union(
                *[row_loop(side, row) for row in rows],
                *[column_loop(side, column) for column in columns])
            table[union] = (ZZ(len(rows)), ZZ(len(columns)))
    return table


for side in (2, 3):
    keys = collect_keys(side)
    straight_table = straight_union_table(side)
    by_doubled = {}
    for doubled, single in keys:
        by_doubled.setdefault(doubled, set()).add(single)

    component_count = ZZ(0)
    with_straight = ZZ(0)
    without_straight = ZZ(0)
    without_straight_windings = {}
    shape_terms = {}
    mixed_shapes = ZZ(0)

    for doubled, singles in sorted(
            by_doubled.items(), key=lambda item: tuple(sorted(item[0]))):
        remaining = set(singles)
        while remaining:
            start = min(remaining, key=lambda item: tuple(sorted(item)))
            stack = [start]
            component = set()
            while stack:
                single = stack.pop()
                if single in component:
                    continue
                component.add(single)
                for row in range(side):
                    for column in range(side):
                        neighbor = frozenset(single.symmetric_difference(
                            plaquette_edges(side, row, column)))
                        if neighbor in singles and neighbor not in component:
                            stack.append(neighbor)
            remaining -= component
            component_count += 1

            straight_members = sorted(
                (single for single in component if single in straight_table),
                key=lambda item: tuple(sorted(item)))
            if not straight_members:
                without_straight += 1
                winding = subset_parities(side, min(
                    component, key=lambda item: tuple(sorted(item))))
                without_straight_windings[winding] = \
                    without_straight_windings.get(winding, ZZ(0)) + 1
                continue
            with_straight += 1
            for representative in straight_members:
                shape = straight_table[representative]
                terms = key_terms(side, doubled, representative)
                if side == 3:
                    signature = shape
                else:
                    signature = (shape, tuple(sorted(doubled)))
                shape_terms.setdefault(signature, set()).add(terms)

    mixed_shapes = sum(
        1 for values in shape_terms.values() if len(values) > 1)
    print("L=%d: components=%d with-straight=%d without-straight=%d "
          "without-straight-windings=%s signatures=%d mixed=%d"
          % (side, component_count, with_straight, without_straight,
             sorted(without_straight_windings.items()), len(shape_terms),
             mixed_shapes))
    if side == 3:
        for shape, values in sorted(shape_terms.items()):
            print("L=3: rows+columns=%s terms=%s" % (shape, sorted(values)))
        assert component_count == 4
        assert with_straight == 3
        assert without_straight == 1
        assert sorted(without_straight_windings.items()) == [((1, 1), ZZ(1))]
        for shape, values in shape_terms.items():
            parity = (shape[0] + shape[1]) % 2
            assert values == {(parity, ZZ(0), ZZ(0), parity)}
    else:
        assert component_count == 324
        assert with_straight == 108
        assert without_straight == 216
        assert sorted(without_straight_windings.items()) == [
            ((0, 0), ZZ(48)), ((0, 1), ZZ(52)),
            ((1, 0), ZZ(52)), ((1, 1), ZZ(64))]
    assert mixed_shapes == 0

print("PASS: 直線ループの合併を含む成分では代表の四項は位置に依らないが、"
      "直線合併を含まない成分（一辺三の巻き付き (1,1) 類、一辺二の 216 成分）"
      "があるため、直線ループの合併だけでは標準代表系に足りない")
