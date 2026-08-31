# 対象ラベル: claim_vertically_adjacent_cells_boundary_parity /
# def_horizontal_edge_traversal_count / def_right_ray_vertical_crossing_count

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 8
checked_walks = 0
checked_pairs = 0


def right_ray_crossing_count(points, row, col):
    return ZZ(sum(
        start[1] == finish[1]
        and col < start[1]
        and {start[0], finish[0]} == {row, row + 1}
        for start, finish in zip(points[:-1], points[1:])
    ))


def horizontal_edge_traversal_count(points, row, col):
    return ZZ(sum(
        start[0] == finish[0] == row
        and {start[1], finish[1]} == {col, col + 1}
        for start, finish in zip(points[:-1], points[1:])
    ))


for length in range(1, max_length + 1):
    for step_sequence in product(steps, repeat=length):
        if sum(step[0] for step in step_sequence) != 0:
            continue
        if sum(step[1] for step in step_sequence) != 0:
            continue

        points = [(ZZ(0), ZZ(0))]
        for row_step, col_step in step_sequence:
            row, col = points[-1]
            points.append((row + row_step, col + col_step))

        row_min = min(point[0] for point in points)
        row_max = max(point[0] for point in points)
        col_min = min(point[1] for point in points)
        col_max = max(point[1] for point in points)

        for row in range(row_min - 2, row_max + 2):
            for col in range(col_min - 2, col_max + 2):
                upper = right_ray_crossing_count(points, ZZ(row), ZZ(col))
                lower = right_ray_crossing_count(points, ZZ(row) + 1, ZZ(col))
                shared = horizontal_edge_traversal_count(points, ZZ(row) + 1, ZZ(col))
                assert (upper + lower - shared) % 2 == 0, (
                    points, row, col, upper, lower, shared
                )
                checked_pairs += 1

        checked_walks += 1

print(
    f"PASS: closed walks={checked_walks}, checked adjacent pairs={checked_pairs}, "
    f"length<={max_length}"
)
