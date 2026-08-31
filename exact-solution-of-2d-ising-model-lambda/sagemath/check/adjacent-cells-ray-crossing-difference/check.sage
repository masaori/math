# 対象ラベル: claim_adjacent_cells_ray_crossing_difference /
# def_vertical_edge_traversal_count / def_right_ray_vertical_crossing_count
#
# 閉じた単位格子歩について、横に隣り合う単位正方形の右半直線交差数の差が
# 二つの正方形が共有する縦辺の通過回数に等しいこと
# N_{r,c} = N_{r,c+1} + V_{r,c+1} を ZZ の比較・加法だけで全列挙検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 8
checked_walks = 0
checked_pairs = 0


def right_ray_crossing_count(points, row, col):
    count = ZZ(0)
    for start, finish in zip(points[:-1], points[1:]):
        if start[1] != finish[1]:
            continue
        edge_col = start[1]
        if col < edge_col and {start[0], finish[0]} == {row, row + 1}:
            count += 1
    return count


def vertical_edge_traversal_count(points, row, col):
    count = ZZ(0)
    for start, finish in zip(points[:-1], points[1:]):
        if {start, finish} == {(row, col), (row + 1, col)}:
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
                left = right_ray_crossing_count(points, ZZ(row), ZZ(col))
                right = right_ray_crossing_count(points, ZZ(row), ZZ(col) + 1)
                shared = vertical_edge_traversal_count(points, ZZ(row), ZZ(col) + 1)
                assert left == right + shared, (points, row, col, left, right, shared)
                checked_pairs += 1

        checked_walks += 1

print(f"PASS: closed walks={checked_walks}, checked adjacent pairs={checked_pairs}, length<=%d" % max_length)
