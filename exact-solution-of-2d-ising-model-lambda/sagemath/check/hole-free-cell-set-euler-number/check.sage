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
