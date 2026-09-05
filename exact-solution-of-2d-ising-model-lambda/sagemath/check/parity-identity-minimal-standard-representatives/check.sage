"""直線合併を含まないプラケット変形成分の辺数最小代表を分類する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-minimal-standard-representatives/construction.sage")

for side in (2, 3):
    keys = collect_keys(side)
    straight_table = straight_union_table(side)
    by_doubled = {}
    for doubled, single in keys:
        by_doubled.setdefault(doubled, set()).add(single)

    signatures = {}
    representatives = []
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
            if any(single in straight_table for single in component):
                continue
            representative = min(
                component,
                key=lambda single: (len(single), tuple(sorted(single))))
            signature = representative_signature(side, doubled, representative)
            signatures[signature] = signatures.get(signature, ZZ(0)) + 1
            representatives.append((doubled, representative, signature))

    print("L=%d: missing-components=%d signatures=%d distribution=%s"
          % (side, len(representatives), len(signatures),
             sorted(signatures.items())))
    if side == 3:
        assert len(representatives) == 1
        doubled, representative, signature = representatives[0]
        assert signature == (ZZ(0), ZZ(6), (ZZ(2),) * 6, ZZ(1), (1, 1))
        assert key_terms(side, doubled, representative) == (0, 0, 1, 1)
        print("L=3 canonical crossing representative: D=%s E=%s signature=%s terms=%s"
              % (tuple(sorted(doubled)), tuple(sorted(representative)),
                 signature, key_terms(side, doubled, representative)))
    else:
        assert len(representatives) == 216
        assert all(signature[1:4] == (ZZ(4), (ZZ(2),) * 4, ZZ(1))
                   for _, _, signature in representatives)
        doubled_winding_counts = {}
        for _, _, signature in representatives:
            key = (signature[0], signature[4])
            doubled_winding_counts[key] = \
                doubled_winding_counts.get(key, ZZ(0)) + 1
        assert doubled_winding_counts == {
            (ZZ(0), (1, 1)): ZZ(4),
            (ZZ(1), (0, 0)): ZZ(16), (ZZ(1), (0, 1)): ZZ(16),
            (ZZ(1), (1, 0)): ZZ(16), (ZZ(1), (1, 1)): ZZ(16),
            (ZZ(2), (0, 0)): ZZ(16), (ZZ(2), (0, 1)): ZZ(24),
            (ZZ(2), (1, 0)): ZZ(24), (ZZ(2), (1, 1)): ZZ(24),
            (ZZ(3), (0, 0)): ZZ(16), (ZZ(3), (0, 1)): ZZ(8),
            (ZZ(3), (1, 0)): ZZ(8), (ZZ(3), (1, 1)): ZZ(16),
            (ZZ(4), (0, 1)): ZZ(4), (ZZ(4), (1, 0)): ZZ(4),
            (ZZ(4), (1, 1)): ZZ(4),
        }

print("PASS: 直線合併を含まない全成分の辺数最小代表は、一辺二では四辺単純閉路、"
      "一辺三では巻き付き (1,1) の六辺単純閉路になる")
