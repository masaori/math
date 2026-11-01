# 対象ラベル: claim_cell_complex_one_cell_increment
#
# 有限セル集合 S とそれに属さないセル x について、Euler 数の増分等式
#   χ(S∪{x}) = χ(S) + 1 + e_x(S) − v_x(S)
# を、二つの有限窓のすべての部分集合とすべての追加セルにわたって ZZ で検査する。
# あわせて χ(∅)=0 と、一セルの頂点集合・辺集合の元の個数が 4 であることも検査する。

checked_increments = 0
checked_single_cells = 0


def cell_corners(cell):
    row, col = cell
    return frozenset({
        (row, col), (row, col + 1), (row + 1, col), (row + 1, col + 1),
    })


def cell_edges(cell):
    row, col = cell
    return frozenset({
        frozenset({(row, col), (row, col + 1)}),
        frozenset({(row + 1, col), (row + 1, col + 1)}),
        frozenset({(row, col), (row + 1, col)}),
        frozenset({(row, col + 1), (row + 1, col + 1)}),
    })


def vertex_set(cells):
    out = set()
    for cell in cells:
        out |= cell_corners(cell)
    return out


def edge_set(cells):
    out = set()
    for cell in cells:
        out |= cell_edges(cell)
    return out


def euler_number(cells):
    return ZZ(len(vertex_set(cells))) - ZZ(len(edge_set(cells))) + ZZ(len(cells))


assert euler_number(frozenset()) == ZZ(0), "χ(∅) が 0 でない"

windows = [
    tuple((row, col) for row in range(3) for col in range(3)),
    tuple((row, col) for row in range(2) for col in range(4)),
]

for window in windows:
    for cell in window:
        assert ZZ(len(cell_corners(cell))) == ZZ(4), ("頂点数が 4 でない", cell)
        assert ZZ(len(cell_edges(cell))) == ZZ(4), ("辺数が 4 でない", cell)
        checked_single_cells += 1

for window in windows:
    size = len(window)
    for mask in range(2 ** size):
        cells = frozenset(window[i] for i in range(size) if (mask >> i) & 1)
        base_euler = euler_number(cells)
        base_vertices = vertex_set(cells)
        base_edges = edge_set(cells)
        for extra in window:
            if extra in cells:
                continue
            shared_vertices = ZZ(len(base_vertices & cell_corners(extra)))
            shared_edges = ZZ(len(base_edges & cell_edges(extra)))
            left_side = euler_number(cells | {extra})
            right_side = base_euler + ZZ(1) + shared_edges - shared_vertices
            assert left_side == right_side, (cells, extra, left_side, right_side)
            checked_increments += 1

print(
    "PASS: 一セル追加の増分等式 {} 件、単一セルの頂点数・辺数 {} 件を ZZ で検査した".format(
        checked_increments, checked_single_cells,
    )
)
