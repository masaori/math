# 対象ラベル: claim_vertex_incident_edge_traversal_even /
# def_vertical_edge_traversal_count / def_horizontal_edge_traversal_count
#
# 零巻き付きの閉じた単位格子歩について、各格子点 (a,b) に接する四本の単位辺
# （縦辺 {(a-1,b),(a,b)}, {(a,b),(a+1,b)} と横辺 {(a,b-1),(a,b)}, {(a,b),(a,b+1)}）の
# 通過回数の総和が、一周期の持ち上げ点のうち (a,b) に一致するものの個数の二倍に
# 等しいことを ZZ の比較・加法だけで全列挙検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 8
checked_walks = 0
checked_vertices = 0


def edge_traversal_count(points, endpoint_a, endpoint_b):
    count = ZZ(0)
    for start, finish in zip(points[:-1], points[1:]):
        if {start, finish} == {endpoint_a, endpoint_b}:
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

        for a in range(row_min - 1, row_max + 2):
            for b in range(col_min - 1, col_max + 2):
                vertex = (ZZ(a), ZZ(b))
                incident_sum = (
                    edge_traversal_count(points, (ZZ(a - 1), ZZ(b)), vertex)
                    + edge_traversal_count(points, vertex, (ZZ(a + 1), ZZ(b)))
                    + edge_traversal_count(points, (ZZ(a), ZZ(b - 1)), vertex)
                    + edge_traversal_count(points, vertex, (ZZ(a), ZZ(b + 1)))
                )
                visits = ZZ(sum(1 for point in points[:-1] if point == vertex))
                assert incident_sum == 2 * visits, (points, a, b, incident_sum, visits)
                checked_vertices += 1

        checked_walks += 1

print(f"PASS: closed walks={checked_walks}, checked vertices={checked_vertices}, length<=%d" % max_length)
