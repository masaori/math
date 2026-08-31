# 対象ラベル: claim_odd_ray_interior_cells_bounded / def_odd_ray_interior_cells /
# def_right_ray_vertical_crossing_count
#
# 閉じた単位格子歩について、各単位正方形から右へ延びる半直線と縦辺との
# 交差数が奇数になり得るセルは歩道の有限な外接長方形内に限ることを、
# ZZ の比較・加法・奇偶だけで全列挙検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 8
checked_walks = 0
checked_cells = 0


def right_ray_crossing_count(points, row, col):
    count = ZZ(0)
    for start, finish in zip(points[:-1], points[1:]):
        if start[1] != finish[1]:
            continue
        edge_col = start[1]
        if col < edge_col and {start[0], finish[0]} == {row, row + 1}:
            count += 1
    return count


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
                crossings = right_ray_crossing_count(points, ZZ(row), ZZ(col))
                if crossings % 2 == 1:
                    assert row_min <= row < row_max, (points, row, col, crossings)
                    assert col_min <= col < col_max, (points, row, col, crossings)
                checked_cells += 1

        checked_walks += 1

print(f"PASS: closed walks={checked_walks}, checked cells={checked_cells}, length<=%d" % max_length)
