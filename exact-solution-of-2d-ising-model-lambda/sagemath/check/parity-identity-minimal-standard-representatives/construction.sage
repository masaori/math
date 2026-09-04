"""直線合併を含まないプラケット変形成分の辺数最小代表を分類する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-standard-representative/construction.sage")

def vertex_degrees(side, edges):
    degrees = {}
    for edge in edges:
        for vertex in base_endpoints(side, edge):
            degrees[vertex] = degrees.get(vertex, ZZ(0)) + 1
    return tuple(sorted(degrees.values()))


def edge_component_count(side, edges):
    remaining = set(edges)
    count = ZZ(0)
    while remaining:
        count += 1
        stack = [remaining.pop()]
        while stack:
            edge = stack.pop()
            incident_vertices = set(base_endpoints(side, edge))
            neighbors = {
                other for other in remaining
                if incident_vertices.intersection(base_endpoints(side, other))
            }
            remaining -= neighbors
            stack.extend(neighbors)
    return count


def representative_signature(side, doubled, single):
    return (
        ZZ(len(doubled)),
        ZZ(len(single)),
        vertex_degrees(side, single),
        edge_component_count(side, single) if single else ZZ(0),
        subset_parities(side, single),
    )


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

    if side == 3:
        doubled, representative, signature = representatives[0]
    else:
        doubled_winding_counts = {}
        for _, _, signature in representatives:
            key = (signature[0], signature[4])
            doubled_winding_counts[key] = \
                doubled_winding_counts.get(key, ZZ(0)) + 1
