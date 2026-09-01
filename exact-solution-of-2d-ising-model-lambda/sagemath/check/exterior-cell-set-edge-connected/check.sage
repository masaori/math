# 対象ラベル: claim_exterior_cell_set_edge_connected
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退辺列について、外接長方形内の各外側セルが
# 行方向に外側セルだけを通って歩道沿いの外側帯または長方形の外側へ届くこと、
# および有限な検査窓内の外側セルが一つの辺連結成分になることを ZZ で検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_exterior_cells = 0
checked_reaches_band = 0
checked_reaches_outside = 0
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


def right_ray_crossing_count(points, cell):
    row, col = cell
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if start[1] == finish[1]
        and col < start[1]
        and {start[0], finish[0]} == {row, row + 1}
    ))


def vertical_edge_traversal_count(points, row, col):
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if {start, finish} == {(row, col), (row + 1, col)}
    ))


def surrounding_cells(vertex):
    row, col = vertex
    return ((row - 1, col - 1), (row - 1, col), (row, col), (row, col - 1))


def is_edge_adjacent(cell_a, cell_b):
    (row, col), (other_row, other_col) = cell_a, cell_b
    return abs(row - other_row) + abs(col - other_col) == 1


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

        def is_exterior(cell):
            return right_ray_crossing_count(points, cell) % 2 == 0

        exterior_band = frozenset(
            cell
            for vertex in points[:-1]
            for cell in surrounding_cells(vertex)
            if is_exterior(cell)
        )
        outside_cells = frozenset(
            (row, col)
            for row in range(row_min - 1, row_max + 1)
            for col in range(col_min - 1, col_max + 1)
            if row < row_min or row_max <= row or col < col_min or col_max <= col
        )
        assert exterior_band & outside_cells, points

        for row in range(row_min, row_max):
            for col in range(col_min, col_max):
                start = (ZZ(row), ZZ(col))
                if not is_exterior(start):
                    continue

                odd_edges = [
                    ZZ(candidate)
                    for candidate in range(col + 1, col_max + 1)
                    if vertical_edge_traversal_count(points, ZZ(row), ZZ(candidate)) % 2 == 1
                ]
                endpoint_col = min(odd_edges) - 1 if odd_edges else ZZ(col_max)
                path = [(ZZ(row), ZZ(candidate)) for candidate in range(col, endpoint_col + 1)]
                assert all(is_exterior(cell) for cell in path), (points, start, path)
                assert all(is_edge_adjacent(left, right) for left, right in zip(path[:-1], path[1:]))
                if odd_edges:
                    assert path[-1] in exterior_band, (points, start, path[-1])
                    checked_reaches_band += 1
                else:
                    assert path[-1] in outside_cells, (points, start, path[-1])
                    checked_reaches_outside += 1
                checked_exterior_cells += 1

        # 無限補集合の代わりに、外接長方形を一セルずつ広げた有限窓を検査する。
        # 上の到達証明に対応して、この窓の外側セルは一つの成分になる。
        window_exterior = frozenset(
            (ZZ(row), ZZ(col))
            for row in range(row_min - 1, row_max + 1)
            for col in range(col_min - 1, col_max + 1)
            if is_exterior((ZZ(row), ZZ(col)))
        )
        start_cell = next(iter(window_exterior))
        reached = {start_cell}
        frontier = [start_cell]
        while frontier:
            current = frontier.pop()
            for other in window_exterior:
                if other not in reached and is_edge_adjacent(current, other):
                    reached.add(other)
                    frontier.append(other)
        assert reached == set(window_exterior), (points, sorted(window_exterior), sorted(reached))

        checked_walks += 1

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
    f"exterior cells={checked_exterior_cells}, reaches band={checked_reaches_band}, "
    f"reaches outside={checked_reaches_outside}, length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
