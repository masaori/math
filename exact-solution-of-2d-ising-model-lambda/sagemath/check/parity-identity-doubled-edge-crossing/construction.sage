"""一辺三の二重辺つき鍵で偶奇恒等式の交差対項を検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/curved-free-class-sign-parity-reduction/construction.sage")


def solve_selector(side, doubled, single):
    edges = sorted(single)
    vertices = sorted({vertex for base in edges
                       for vertex in base_endpoints(side, base)})
    vertex_index = {vertex: index for index, vertex in enumerate(vertices)}
    incidence = matrix(GF(2), len(vertices), len(edges))
    for column, base in enumerate(edges):
        for vertex in base_endpoints(side, base):
            incidence[vertex_index[vertex], column] += 1
    demand = vector(GF(2), len(vertices))
    for base in doubled:
        for vertex in base_endpoints(side, base):
            if vertex not in vertex_index:
                return None
            demand[vertex_index[vertex]] += 1
    try:
        solution = incidence.solve_right(demand)
    except ValueError:
        return None
    return frozenset(edges[column] for column in range(len(edges))
                     if solution[column] == 1)
