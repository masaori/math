"""プラケット変形で切断辺を除ける範囲を調べる。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

固定した反転対 D ごとに、許される鍵 (D,E) をプラケット対称差で結んだ
有限グラフを作る。各連結成分で E の水平・垂直巻き付き偶奇と切断辺数の
最小値を計算し、切断辺を全て除いた代表へ到達できる条件を確定する。
有限集合、F_2、整数だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-plaquette-deformation/check.sage")


def seam_edge_count(side, single):
    return ZZ(sum(base_seam_parities(side, edge) != (0, 0) for edge in single))


for side in (2, 3):
    keys = collect_keys(side)
    by_doubled = {}
    for doubled, single in keys:
        by_doubled.setdefault(doubled, set()).add(single)

    component_count = ZZ(0)
    zero_winding_components = ZZ(0)
    nonzero_winding_components = ZZ(0)
    zero_winding_without_cut_free = ZZ(0)
    nonzero_winding_with_cut_free = ZZ(0)
    minimum_counts = {}
    zero_winding_counterexample = None

    for doubled, singles in by_doubled.items():
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

            parities = {subset_parities(side, single) for single in component}
            assert len(parities) == 1
            winding = next(iter(parities))
            minimum = min(seam_edge_count(side, single) for single in component)
            minimum_counts[minimum] = minimum_counts.get(minimum, ZZ(0)) + 1
            component_count += 1
            if winding == (0, 0):
                zero_winding_components += 1
                zero_winding_without_cut_free += ZZ(minimum != 0)
                if minimum != 0 and zero_winding_counterexample is None:
                    representative = min(
                        component, key=lambda item: (seam_edge_count(side, item),
                                                     tuple(sorted(item))))
                    zero_winding_counterexample = (
                        tuple(sorted(doubled)), tuple(sorted(representative)), minimum)
            else:
                nonzero_winding_components += 1
                nonzero_winding_with_cut_free += ZZ(minimum == 0)

    print("L=%d: doubled-sets=%d components=%d zero-winding=%d "
          "zero-winding-without-cut-free=%d nonzero-winding=%d "
          "min-seam-distribution=%s"
          % (side, len(by_doubled), component_count, zero_winding_components,
             zero_winding_without_cut_free, nonzero_winding_components,
             sorted(minimum_counts.items())))
    print("L=%d: zero-winding counterexample=%s"
          % (side, zero_winding_counterexample))
    if side == 2:
        assert zero_winding_without_cut_free == 48
        assert zero_winding_counterexample is not None
    else:
        assert zero_winding_without_cut_free == 0
        assert zero_winding_counterexample is None
    assert nonzero_winding_with_cut_free == 0
    assert nonzero_winding_components > 0

print("PASS: プラケット変形で任意の鍵を切断非接触代表へ運ぶ方針には、非零巻き付きに加え、"
      "零巻き付きでも固定した反転対と許される鍵の制約による反例がある")
