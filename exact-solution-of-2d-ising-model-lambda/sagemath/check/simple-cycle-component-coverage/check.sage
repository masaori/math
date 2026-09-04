"""各プラケット変形成分が単純閉路の代表を含むかを全数で検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

固定した反転対 D ごとに、許される鍵 (D,E) をプラケット対称差で結んだ
有限グラフの各連結成分について、単一の単純閉路（全頂点次数 2・辺連結成分 1）
である E を含むかを調べる。合わせて、鍵の E が単純閉路なら選択集合の存在条件
∂D ⊆ V(E)（sagemath/check/simple-cycle-selector-existence）が成り立つことを
鍵の定義から確認する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-minimal-standard-representatives/check.sage")


def is_single_simple_cycle(side, single):
    if not single:
        return False
    if any(value != 2 for value in vertex_degrees(side, single)):
        return False
    return edge_component_count(side, single) == 1


def odd_degree_vertices(side, edges):
    degrees = {}
    for edge in edges:
        for vertex in base_endpoints(side, edge):
            degrees[vertex] = degrees.get(vertex, ZZ(0)) + 1
    return frozenset(vertex for vertex, value in degrees.items()
                     if value % 2 == 1)


for side in (2, 3):
    keys = collect_keys(side)
    straight_table = straight_union_table(side)
    by_doubled = {}
    for doubled, single in keys:
        by_doubled.setdefault(doubled, set()).add(single)

    component_total = ZZ(0)
    with_cycle = ZZ(0)
    with_straight = ZZ(0)
    with_both = ZZ(0)
    with_neither = []
    no_cycle_profile = {}
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
            component_total += 1
            cycles = [single for single in component
                      if is_single_simple_cycle(side, single)]
            for single in cycles:
                vertices = frozenset(
                    vertex for edge in single
                    for vertex in base_endpoints(side, edge))
                assert odd_degree_vertices(side, doubled).issubset(vertices)
            has_cycle = bool(cycles)
            has_straight = any(single in straight_table
                               for single in component)
            with_cycle += ZZ(1) if has_cycle else ZZ(0)
            with_straight += ZZ(1) if has_straight else ZZ(0)
            with_both += ZZ(1) if (has_cycle and has_straight) else ZZ(0)
            if not has_cycle:
                profile = (
                    ZZ(len(doubled)),
                    ZZ(len(odd_degree_vertices(side, doubled))),
                    subset_parities(side, min(
                        component,
                        key=lambda item: tuple(sorted(item)))),
                    min(ZZ(edge_component_count(side, single))
                        for single in component),
                )
                no_cycle_profile[profile] = \
                    no_cycle_profile.get(profile, ZZ(0)) + 1
            if not has_cycle and not has_straight:
                with_neither.append((doubled, min(
                    component,
                    key=lambda single: (len(single), tuple(sorted(single))))))

    print("L=%d: components=%d with-simple-cycle=%d with-straight-union=%d "
          "with-both=%d with-neither=%d"
          % (side, component_total, with_cycle, with_straight, with_both,
             len(with_neither)))
    print("L=%d: no-cycle-profiles=%s" % (side, sorted(no_cycle_profile.items())))
    assert not with_neither
    if side == 2:
        assert (component_total, with_cycle, with_straight, with_both) \
            == (ZZ(324), ZZ(287), ZZ(108), ZZ(71))
        assert sum(no_cycle_profile.values()) == ZZ(37)
        assert no_cycle_profile == {
            (ZZ(2), ZZ(0), (0, 0), ZZ(0)): ZZ(4),
            (ZZ(2), ZZ(0), (0, 0), ZZ(2)): ZZ(4),
            (ZZ(2), ZZ(4), (0, 0), ZZ(2)): ZZ(4),
            (ZZ(4), ZZ(0), (0, 0), ZZ(0)): ZZ(18),
            (ZZ(4), ZZ(0), (0, 0), ZZ(2)): ZZ(2),
            (ZZ(6), ZZ(0), (0, 0), ZZ(0)): ZZ(4),
            (ZZ(8), ZZ(0), (0, 0), ZZ(0)): ZZ(1),
        }
    else:
        assert (component_total, with_cycle, with_straight, with_both) \
            == (ZZ(4), ZZ(4), ZZ(3), ZZ(3))
        assert not no_cycle_profile

print("PASS: 一辺二・三の全てのプラケット変形成分は、単一の単純閉路の代表か"
      "直線ループの合併の代表を含む。一辺二で単純閉路を含まない 37 成分は"
      "全て巻き付き偶奇が零で、27 成分は空集合の E を含み、残る 10 成分の"
      "E は全て辺連結成分二つ以上である。単純閉路の代表は選択集合の存在条件"
      " ∂D ⊆ V(E) を満たす")
