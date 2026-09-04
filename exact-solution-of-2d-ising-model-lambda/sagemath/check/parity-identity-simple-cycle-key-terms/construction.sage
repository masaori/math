"""単純閉路の鍵の四項を、方向列由来の統計の F_2 線型結合で書けるか調べる。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-minimal-standard-representatives/construction.sage")

def is_simple_cycle(side, edges):
    if not edges:
        return False
    if edge_component_count(side, edges) != 1:
        return False
    return all(degree == 2 for degree in vertex_degrees(side, edges))


def cycle_corner_vertices(side, edges):
    kinds = {}
    for edge in edges:
        for vertex in base_endpoints(side, edge):
            kinds.setdefault(vertex, []).append(edge[0])
    return sorted(vertex for vertex, kind_list in kinds.items()
                  if len(set(kind_list)) == 2)


def cycle_statistics(side, doubled, single):
    horizontal_count = ZZ(sum(1 for edge in single if edge[0] == "h"))
    vertical_count = ZZ(sum(1 for edge in single if edge[0] == "v"))
    winding_h, winding_v = subset_parities(side, single)
    corners = cycle_corner_vertices(side, single)
    assert len(corners) % 2 == 0
    selector = key_selector(side, doubled, single)
    target = target_exponent(side, doubled, single, selector)
    pairing = (ZZ(target) + ZZ(winding_h) + ZZ(winding_v)
               + ZZ(winding_h) * ZZ(winding_v)) % 2
    return (
        GF(2)(1),
        GF(2)(len(single)),
        GF(2)(horizontal_count),
        GF(2)(vertical_count),
        GF(2)(winding_h),
        GF(2)(winding_v),
        GF(2)(ZZ(winding_h) * ZZ(winding_v)),
        GF(2)(len(corners) // 2),
        GF(2)(sum(1 for vertex in corners if vertex[0] == 0)),
        GF(2)(sum(1 for vertex in corners if vertex[1] == 0)),
        GF(2)(len(doubled)),
        GF(2)(pairing),
    )


STATISTIC_NAMES = (
    "1", "|E|", "|E_h|", "|E_v|", "eps_h", "eps_v", "eps_h*eps_v",
    "corners/2", "corners@row0", "corners@col0", "|D|", "pairing",
)

TERM_NAMES = ("moved", "vertex", "pair", "target")

expressible_by_side = {}
for side in (2, 3):
    keys = collect_keys(side)
    cycle_keys = [(doubled, single) for doubled, single in keys
                  if is_simple_cycle(side, single)]
    rows = []
    term_columns = [[] for _ in range(4)]
    for doubled, single in cycle_keys:
        rows.append(cycle_statistics(side, doubled, single))
        terms = key_terms(side, doubled, single)
        for index in range(4):
            term_columns[index].append(GF(2)(terms[index]))

    statistic_matrix = matrix(GF(2), rows)
    if side == 3:
        for row, terms in zip(rows, zip(*term_columns)):
            size = row[1]
            winding_product = row[6]
    expressible = []
    for index in range(4):
        term_vector = vector(GF(2), term_columns[index])
        try:
            solution = statistic_matrix.solve_right(term_vector)
            support = [STATISTIC_NAMES[position]
                       for position in range(len(STATISTIC_NAMES))
                       if solution[position] != 0]
            expressible.append((TERM_NAMES[index], support))
        except ValueError:
            expressible.append((TERM_NAMES[index], None))

    expressible_by_side[side] = expressible
