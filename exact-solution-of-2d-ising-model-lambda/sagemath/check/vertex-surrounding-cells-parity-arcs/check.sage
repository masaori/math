# 対象ラベル: claim_vertex_surrounding_cells_form_parity_arcs
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退辺列について、
# 各持ち上げ点に接する四セルの右半直線交差奇偶が巡回順にちょうど二回変わり、
# 内側と外側がそれぞれ一つの非空な弧をなすことを ZZ の有限数え上げで検査する。
# 検査対象の平面歩は持ち上げ点の列そのものであり、主張に現れる量は全て持ち上げ
# 点の列だけから定まる。さらに、L=1,2,3 のトーラスへ射影すると接触対数
# n_ct > 0 となる歩（旧仮定 n_ct = 0 では扱えなかった対象）が実在することを数えて確認する。

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
    assert contact_walks[size] > 0, (
        "expected walks with torus contact pairs (n_ct > 0) for L=%s" % size
    )

print(
    f"PASS: lift-point-distinct closed nonbacktracking walks={checked_walks}, "
    f"visited vertices={checked_vertices}, length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
