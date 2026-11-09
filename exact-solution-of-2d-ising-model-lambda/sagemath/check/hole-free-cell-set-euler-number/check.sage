# 対象ラベル: claim_hole_free_cell_set_euler_number_one
#
# 頂点単純な閉じた非後退単位格子歩について、右半直線交差が奇数の
# 内側セル集合の Euler 数が 1 であることを ZZ の有限数え上げで検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_interior_cells = 0


def add(point, step):
    return (point[0] + step[0], point[1] + step[1])


def is_nonbacktracking(step_sequence):
    length = len(step_sequence)
    return all(
        step_sequence[(index + 1) % length] != (-step_sequence[index][0], -step_sequence[index][1])
        for index in range(length)
    )


def right_ray_crossing_count(points, cell):
    row, col = cell
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if start[1] == finish[1]
        and col < start[1]
        and {start[0], finish[0]} == {row, row + 1}
    ))


def cell_vertices(cell):
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


for length in range(4, max_length + 1):
    for step_sequence in product(steps, repeat=length):
        if sum(step[0] for step in step_sequence) != 0:
            continue
        if sum(step[1] for step in step_sequence) != 0:
            continue
        if not is_nonbacktracking(step_sequence):
            continue

        points = [(ZZ(0), ZZ(0))]
        for step in step_sequence:
            points.append(add(points[-1], step))
        if len(set(points[:-1])) != length:
            continue

        row_min = min(point[0] for point in points)
        row_max = max(point[0] for point in points)
        col_min = min(point[1] for point in points)
        col_max = max(point[1] for point in points)
        interior = frozenset(
            (ZZ(row), ZZ(col))
            for row in range(row_min, row_max)
            for col in range(col_min, col_max)
            if right_ray_crossing_count(points, (ZZ(row), ZZ(col))) % 2 == 1
        )
        assert interior, points

        vertices = set()
        edges = set()
        for cell in interior:
            vertices.update(cell_vertices(cell))
            edges.update(cell_edges(cell))
        euler_number = ZZ(len(vertices)) - ZZ(len(edges)) + ZZ(len(interior))
        assert euler_number == ZZ(1), (points, sorted(interior), euler_number)

        checked_walks += 1
        checked_interior_cells += len(interior)

print(
    f"PASS: vertex-simple closed nonbacktracking walks={checked_walks}, "
    f"interior cells={checked_interior_cells}, Euler number=1, length<=%d" % max_length
)


def exterior_connected(cells):
    outer = {(r, c) for r in range(-2, 4) for c in range(-2, 4)} - cells
    seen = {(-2, -2)}
    stack = [(-2, -2)]
    while stack:
        r, c = stack.pop()
        for q in ((r + 1, c), (r - 1, c), (r, c + 1), (r, c - 1)):
            if q in outer - seen:
                seen.add(q)
                stack.append(q)
    return seen == outer


def cell_connected(cells):
    if not cells:
        return False
    start = next(iter(cells))
    seen = {start}
    stack = [start]
    while stack:
        r, c = stack.pop()
        for q in ((r + 1, c), (r - 1, c), (r, c + 1), (r, c - 1)):
            if q in cells - seen:
                seen.add(q)
                stack.append(q)
    return seen == cells


base = tuple(product(range(2), repeat=2))
checked_sets = 0
for mask in range(1, 1 << len(base)):
    cells = {base[j] for j in range(len(base)) if mask & (1 << j)}
    if not cell_connected(cells) or not exterior_connected(cells):
        continue
    vertices = set().union(*(cell_vertices(cell) for cell in cells))
    edges = set().union(*(cell_edges(cell) for cell in cells))
    even_edge_sets = sum(
        all(sum(vertex in edge for edge in chosen) % 2 == 0 for vertex in vertices)
        for chosen in (
            {edge for j, edge in enumerate(sorted(edges, key=lambda e: sorted(e))) if choice & (1 << j)}
            for choice in range(1 << len(edges))
        )
    )
    assert even_edge_sets == 2 ** len(cells)
    assert even_edge_sets == 2 ** (len(edges) + 1 - len(vertices))
    assert ZZ(len(vertices)) - ZZ(len(edges)) + ZZ(len(cells)) == 1
    checked_sets += 1

print(f"PASS: connected hole-free cell sets={checked_sets}; both even-edge counts agree")
