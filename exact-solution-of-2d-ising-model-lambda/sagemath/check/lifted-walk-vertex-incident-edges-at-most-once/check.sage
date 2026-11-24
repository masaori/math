# 対象ラベル: claim_lifted_walk_vertex_incident_edges_traversed_at_most_once
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退辺列について、
# 各持ち上げ点 P_j に接する四辺の通過回数を ZZ の有限数え上げで求め、
# 証明の各行を確かめる:
#   総和の鎖: 四辺の総和 = 2 * 訪問回数 = 2 * 1 = 2
#   入る辺 E^- と出る辺 E^+ は P_j に接する四辺の一つで、通過回数は 1 以上
#   E^- != E^+（持ち上げた隣接二歩は逆ベクトルにならない）
#   結論: 四つの通過回数はそれぞれ 1 以下
# 検査対象の平面歩は持ち上げ点の列そのもの（P_m = P_0 は零巻き付きの閉性）である。

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
        # 零巻き付きの閉性 P_m = P_0
        assert points[length] == points[0]

        for j in range(length):
            a, b = points[j]
            incident_edges = (
                frozenset({(a - 1, b), (a, b)}),
                frozenset({(a, b), (a + 1, b)}),
                frozenset({(a, b - 1), (a, b)}),
                frozenset({(a, b), (a, b + 1)}),
            )
            counts = tuple(edge_traversal_count(points, *tuple(edge)) for edge in incident_edges)
            visits = ZZ(sum(1 for k in range(length) if points[k] == (a, b)))
            # 総和の鎖の各行
            assert sum(counts) == 2 * visits
            assert visits == 1
            assert 2 * visits == 2
            # 入る辺と出る辺
            j_minus = j - 1 if j >= 1 else length - 1
            assert points[j_minus + 1] == points[j]
            e_minus = frozenset({points[j_minus], points[j]})
            e_plus = frozenset({points[j], points[j + 1]})
            assert e_minus in incident_edges and e_plus in incident_edges
            assert counts[incident_edges.index(e_minus)] >= 1
            assert counts[incident_edges.index(e_plus)] >= 1
            assert e_minus != e_plus
            # 結論
            assert all(count <= 1 for count in counts), (points, j, counts)
            checked_vertices += 1
        checked_walks += 1

print(
    f"PASS: lift-point-distinct closed nonbacktracking walks={checked_walks}, "
    f"visited vertices={checked_vertices}, length<=%d" % max_length
)
