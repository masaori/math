# 対象ラベル: claim_interior_cell_set_edge_connected
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退辺列について、右半直線交差が奇数の
# 内側セル全体が空でなく辺連結であることを ZZ の有限数え上げで検査する。
# 各内側セルから右へ進んだ最初の外側セルとの境界辺が歩道に属し、
# その直前の内側セルが歩道沿いの内側帯に属することも検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_interior_cells = 0
checked_row_anchors = 0
torus_sizes = (ZZ(1), ZZ(2), ZZ(3))
contact_walks = {size: 0 for size in torus_sizes}


def add(point, step):
    return (point[0] + step[0], point[1] + step[1])


def is_nonbacktracking(step_sequence):
    length = len(step_sequence)
    return all(
        step_sequence[(index + 1) % length] != (-step_sequence[index][0], -step_sequence[index][1])
        for index in range(length)
    )


def vertical_edge_crossing_count(points, cell):
    row, col = cell
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if start[1] == finish[1] and col < start[1] and {start[0], finish[0]} == {row, row + 1}
    ))


def vertical_edge_traversal_count(points, row, col):
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if {start, finish} == {(row, col), (row + 1, col)}
    ))


def is_edge_adjacent(cell_a, cell_b):
    (row, col), (other_row, other_col) = cell_a, cell_b
    return abs(row - other_row) + abs(col - other_col) == 1


for length in range(4, max_length + 1):
    for step_sequence in product(steps, repeat=length):
        if sum(step[0] for step in step_sequence) != 0 or sum(step[1] for step in step_sequence) != 0:
            continue
        if not is_nonbacktracking(step_sequence):
            continue

        points = [(ZZ(0), ZZ(0))]
        for step in step_sequence:
            points.append(add(points[-1], step))
        if len(set(points[:-1])) != length:
            continue

        min_row = min(point[0] for point in points)
        max_row = max(point[0] for point in points)
        min_col = min(point[1] for point in points)
        max_col = max(point[1] for point in points)
        interior = {
            (row, col)
            for row in range(min_row, max_row)
            for col in range(min_col, max_col)
            if vertical_edge_crossing_count(points, (row, col)) % 2 == 1
        }
        assert interior, points

        band = {
            cell
            for cell in interior
            if any(
                vertex in {
                    cell,
                    (cell[0], cell[1] + 1),
                    (cell[0] + 1, cell[1]),
                    (cell[0] + 1, cell[1] + 1),
                }
                for vertex in points[:-1]
            )
        }
        assert band, points

        for row, col in interior:
            first_exterior_col = col + 1
            while (row, first_exterior_col) in interior:
                first_exterior_col += 1
            anchor = (row, first_exterior_col - 1)
            assert all((row, current_col) in interior for current_col in range(col, first_exterior_col))
            assert vertical_edge_traversal_count(points, row, first_exterior_col) % 2 == 1
            assert anchor in band
            checked_row_anchors += 1

        start_cell = next(iter(interior))
        reached = {start_cell}
        frontier = [start_cell]
        while frontier:
            current = frontier.pop()
            for other in interior:
                if other not in reached and is_edge_adjacent(current, other):
                    reached.add(other)
                    frontier.append(other)
        assert reached == interior, (points, sorted(interior), sorted(reached))

        checked_walks += 1
        checked_interior_cells += len(interior)

        for size in torus_sizes:
            torus_vertices = [(point[0] % size, point[1] % size) for point in points[:-1]]
            contact_pairs = ZZ(sum(
                1
                for first in range(len(torus_vertices))
                for second in range(first + 1, len(torus_vertices))
                if torus_vertices[first] == torus_vertices[second]
            ))
            if contact_pairs > 0:
                contact_walks[size] += 1

for size in torus_sizes:
    assert contact_walks[size] > 0

print(
    f"PASS: lift-point-distinct closed nonbacktracking walks={checked_walks}, "
    f"interior cells={checked_interior_cells}, row anchors={checked_row_anchors}, length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
