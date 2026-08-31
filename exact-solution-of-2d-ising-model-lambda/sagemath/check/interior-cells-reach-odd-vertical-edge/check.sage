# 対象ラベル: claim_interior_cells_reach_odd_vertical_edge /
# def_odd_ray_interior_cells / def_vertical_edge_traversal_count
#
# 零巻き付きの閉じた単位格子歩について、各内側セル (r,c)（右半直線交差数が奇数）に対し
# 最小の g>c で (r,g) が外側になるものを取り、
#   (r,c),...,(r,g-1) がすべて内側であること、
#   共有縦辺の通過回数 V_{r,g} が奇数（したがって 1 以上）であること
# を ZZ の比較・加法だけで全列挙検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 8
checked_walks = 0
checked_interior_cells = 0


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

        for row in range(row_min - 1, row_max + 1):
            for col in range(col_min - 1, col_max + 1):
                if right_ray_crossing_count(points, ZZ(row), ZZ(col)) % 2 != 1:
                    continue

                # 最小の g > col で (row, g) が外側になるものを探す。
                # 有界性の主張により g <= col_max で必ず見つかる。
                g = None
                for candidate in range(col + 1, col_max + 1):
                    if right_ray_crossing_count(points, ZZ(row), ZZ(candidate)) % 2 == 0:
                        g = ZZ(candidate)
                        break
                assert g is not None, (points, row, col)

                for j in range(col, g):
                    assert right_ray_crossing_count(points, ZZ(row), ZZ(j)) % 2 == 1, (
                        points, row, col, g, j)

                shared = vertical_edge_traversal_count(points, ZZ(row), g)
                assert shared % 2 == 1, (points, row, col, g, shared)
                assert shared >= 1, (points, row, col, g, shared)
                checked_interior_cells += 1

        checked_walks += 1

print(f"PASS: closed walks={checked_walks}, checked interior cells={checked_interior_cells}, length<=%d" % max_length)
