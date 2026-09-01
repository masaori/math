# 対象ラベル: claim_boundary_vertex_diagonal_contact_excluded
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退単位格子歩について、
# 任意の格子点に接する四セルのうち
# 内側セルの集合が対角の二セルだけになることが無いことを ZZ の有限数え上げで検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_vertices = 0
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

        def is_interior(cell):
            return right_ray_crossing_count(points, cell) % 2 == 1

        # 内側セルは外接長方形内に限られるので、格子点は長方形を 1 だけ広げた窓で尽くせる。
        for a in range(row_min - 1, row_max + 2):
            for b in range(col_min - 1, col_max + 2):
                surrounding = (
                    (ZZ(a - 1), ZZ(b - 1)),  # C_0
                    (ZZ(a - 1), ZZ(b)),      # C_1
                    (ZZ(a), ZZ(b)),          # C_2
                    (ZZ(a), ZZ(b - 1)),      # C_3
                )
                interior_flags = tuple(is_interior(cell) for cell in surrounding)
                assert interior_flags != (True, False, True, False), (points, a, b)
                assert interior_flags != (False, True, False, True), (points, a, b)
                checked_vertices += 1

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
    f"lattice vertices={checked_vertices}, no diagonal-only interior pair, length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
