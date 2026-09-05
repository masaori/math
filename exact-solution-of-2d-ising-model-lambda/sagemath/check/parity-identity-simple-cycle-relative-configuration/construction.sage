"""一辺二の単純閉路鍵の二項を D と E の相対配置統計で書く。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-key-terms/construction.sage")


def incident_base_slots(side, vertex):
    row, column = vertex
    return (
        ("up", ("v", (row - 1) % side, column)),
        ("down", ("v", row, column)),
        ("left", ("h", row, (column - 1) % side)),
        ("right", ("h", row, column)),
    )


def relative_vertex_signature(side, vertex, doubled, single):
    memberships = tuple(
        (name, ZZ(base in doubled), ZZ(base in single))
        for name, base in incident_base_slots(side, vertex)
    )
    return memberships, vertex_wrap_flags(side, vertex)


side = 2
cycle_keys = [
    (doubled, single)
    for doubled, single in collect_keys(side)
    if is_simple_cycle(side, single)
]

all_signatures = sorted({
    relative_vertex_signature(side, vertex, doubled, single)
    for doubled, single in cycle_keys
    for vertex in sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
})

rows = []
vertex_terms = []
pair_terms = []
target_terms = []
for doubled, single in cycle_keys:
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    counts = {
        signature: GF(2)(sum(
            1 for vertex in vertices
            if relative_vertex_signature(side, vertex, doubled, single)
            == signature
        ))
        for signature in all_signatures
    }
    rows.append(tuple(counts[signature] for signature in all_signatures))
    moved, vertex, pair, target = key_terms(side, doubled, single)
    vertex_terms.append(GF(2)(vertex))
    pair_terms.append(GF(2)(pair))
    target_terms.append(GF(2)(target))

statistic_matrix = matrix(GF(2), rows)
vertex_solution = statistic_matrix.solve_right(vector(GF(2), vertex_terms))

for row, vertex, pair, target in zip(
        rows, vertex_terms, pair_terms, target_terms):
    relative_value = sum(
        row[index] * vertex_solution[index]
        for index in range(len(all_signatures))
    )
