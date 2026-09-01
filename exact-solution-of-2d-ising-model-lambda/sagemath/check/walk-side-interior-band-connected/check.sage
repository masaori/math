# 対象ラベル: claim_walk_side_interior_band_edge_connected
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退辺列について、歩道沿いの内側帯
# （訪問頂点を四隅に持つ内側セルの集合）が空でなく辺連結であることを
# ZZ の有限数え上げで検査する。あわせて証明の部品である
# 各訪問頂点の内側セル集合 A_j の非空性と、隣り合う訪問頂点の
# A_j ∩ A_{j+1} の非空性（歩の辺を挟む二セルのうちちょうど一方が内側で
# あること）も検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_bridges = 0
checked_band_cells = 0
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
    count = ZZ(0)
    for start, finish in zip(points[:-1], points[1:]):
        if start[1] != finish[1]:
            continue
        if start[1] <= col:
            continue
        if {start[0], finish[0]} == {row, row + 1}:
            count += 1
    return count


def surrounding_cells(vertex):
    a, b = vertex
    return (
        (a - 1, b - 1),
        (a - 1, b),
        (a, b),
        (a, b - 1),
    )


def is_edge_adjacent(cell_a, cell_b):
    (r, c), (rr, cc) = cell_a, cell_b
    if rr == r and cc in (c - 1, c + 1):
        return True
    if cc == c and rr in (r - 1, r + 1):
        return True
    return False


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

        def is_interior(cell):
            return vertical_edge_crossing_count(points, cell) % 2 == 1

        # 各訪問頂点の内側セル集合 A_j
        interior_sets = []
        for vertex in points[:-1]:
            interior_cells = frozenset(
                cell for cell in surrounding_cells(vertex) if is_interior(cell)
            )
            assert interior_cells, (points, vertex)
            interior_sets.append(interior_cells)

        # 橋: 歩の辺を挟む二セルのうちちょうど一方が内側で、A_j ∩ A_{j+1} に入る
        for index in range(length):
            start = points[index]
            finish = points[index + 1]
            if start[1] == finish[1]:
                row = min(start[0], finish[0])
                col = start[1]
                flanking = ((row, col - 1), (row, col))
            else:
                row = start[0]
                col = min(start[1], finish[1])
                flanking = ((row - 1, col), (row, col))
            interior_flags = tuple(is_interior(cell) for cell in flanking)
            assert interior_flags.count(True) == 1, (points, index, flanking, interior_flags)
            bridge = flanking[0] if interior_flags[0] else flanking[1]
            assert bridge in interior_sets[index], (points, index, bridge)
            assert bridge in interior_sets[(index + 1) % length], (points, index, bridge)
            checked_bridges += 1

        # 帯 = ∪ A_j。空でないこと・辺連結であることを幅優先で検査する
        band = frozenset().union(*interior_sets)
        assert band, points
        start_cell = next(iter(band))
        reached = {start_cell}
        frontier = [start_cell]
        while frontier:
            current = frontier.pop()
            for other in band:
                if other not in reached and is_edge_adjacent(current, other):
                    reached.add(other)
                    frontier.append(other)
        assert reached == set(band), (points, sorted(band), sorted(reached))
        checked_band_cells += len(band)

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
    f"bridges={checked_bridges}, band cells={checked_band_cells}, length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
