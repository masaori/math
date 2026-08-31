# 対象ラベル: claim_vertex_surrounding_cells_form_parity_arcs
#
# 頂点単純な閉じた非後退単位格子歩の各訪問頂点について、接する四セルの
# 右半直線交差奇偶が巡回順にちょうど二回変わり、内側と外側がそれぞれ
# 一つの非空な弧をなすことを ZZ の有限数え上げで検査する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_vertices = 0


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


def edge_traversal_count(points, endpoint_a, endpoint_b):
    return ZZ(sum(
        1
        for start, finish in zip(points[:-1], points[1:])
        if {start, finish} == {endpoint_a, endpoint_b}
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

        for a, b in points[:-1]:
            cells = (
                (a - 1, b - 1),
                (a - 1, b),
                (a, b),
                (a, b - 1),
            )
            inside = tuple(vertical_edge_crossing_count(points, cell) % 2 == 1 for cell in cells)
            transitions = ZZ(sum(inside[index] != inside[(index + 1) % 4] for index in range(4)))

            incident_counts = (
                edge_traversal_count(points, (a - 1, b), (a, b)),
                edge_traversal_count(points, (a, b), (a, b + 1)),
                edge_traversal_count(points, (a, b), (a + 1, b)),
                edge_traversal_count(points, (a, b - 1), (a, b)),
            )
            assert sorted(incident_counts) == [0, 0, 1, 1], (points, (a, b), incident_counts)
            assert all(
                (inside[index] != inside[(index + 1) % 4]) == (incident_counts[index] % 2 == 1)
                for index in range(4)
            ), (points, (a, b), inside, incident_counts)
            assert transitions == 2, (points, (a, b), inside)
            assert any(inside) and not all(inside), (points, (a, b), inside)
            checked_vertices += 1

        checked_walks += 1

print(
    f"PASS: vertex-simple closed nonbacktracking walks={checked_walks}, "
    f"visited vertices={checked_vertices}, length<=%d" % max_length
)
