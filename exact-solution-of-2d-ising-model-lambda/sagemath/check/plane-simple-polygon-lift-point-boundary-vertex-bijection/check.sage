# 対象ラベル: claim_plane_simple_polygon_cyclic_turning
#
# 証明の段落「一周期の持ち上げ点と境界頂点を対応させる」の三つの事実を、
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退単位格子歩について ZZ の有限数え上げで検査する。
#   (a) 各歩の単位辺 E_j の通過回数はちょうど 1 で、E_j は内側セル集合の境界辺である。
#   (b) 内側セル集合の各境界辺の通過回数は奇数である（縦辺は横に隣り合う二セル、横辺は上下に隣り合う二セル）。
#   (c) k -> P_k は {0,...,m-1} から境界頂点集合への全単射である。
# 座標は (行, 列)。縦辺 {(r,j),(r+1,j)} はセル (r,j-1),(r,j) が共有し、
# 横辺 {(i,c),(i,c+1)} はセル (i-1,c),(i,c) が共有する。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
max_length = 10
checked_walks = 0
checked_step_edges = 0
checked_boundary_edges = 0
checked_boundary_vertices = 0


def interior_cell(points, cell):
    row, col = cell
    crossings = ZZ(0)
    for start, end in zip(points, points[1:]):
        if (start[1] == end[1] and start[1] > col
                and min(start[0], end[0]) <= row < max(start[0], end[0])):
            crossings += 1
    return crossings % 2 == 1


def edge_of(p, q):
    return frozenset((p, q))


for length in range(4, max_length + 1):
    for step_sequence in product(steps, repeat=length):
        if sum(step[0] for step in step_sequence) != 0:
            continue
        if sum(step[1] for step in step_sequence) != 0:
            continue
        if any(step_sequence[(i + 1) % length] == (-step_sequence[i][0], -step_sequence[i][1])
               for i in range(length)):
            continue
        points = [(ZZ(0), ZZ(0))]
        for step in step_sequence:
            points.append((points[-1][0] + step[0], points[-1][1] + step[1]))
        if len(set(points[:-1])) != length:
            continue

        traversal = {}
        for j in range(1, length + 1):
            e = edge_of(points[j - 1], points[j])
            traversal[e] = traversal.get(e, ZZ(0)) + 1

        rows = [p[0] for p in points]
        cols = [p[1] for p in points]
        cells = [(r, c) for r in range(min(rows) - 1, max(rows) + 1)
                 for c in range(min(cols) - 1, max(cols) + 1)]
        interior = set(cell for cell in cells if interior_cell(points, cell))
        assert interior

        boundary = set()
        for (r, c) in interior:
            for (dr, dc) in ((0, -1), (0, 1), (-1, 0), (1, 0)):
                other = (r + dr, c + dc)
                if other in interior:
                    continue
                if dr == 0:
                    j = max(c, other[1])
                    boundary.add(edge_of((r, j), (r + 1, j)))
                else:
                    i = max(r, other[0])
                    boundary.add(edge_of((i, c), (i, c + 1)))

        # (a)
        for j in range(1, length + 1):
            e = edge_of(points[j - 1], points[j])
            assert traversal[e] == 1, (step_sequence, j)
            assert e in boundary, (step_sequence, j)
            checked_step_edges += 1
        # (b)
        for e in boundary:
            assert traversal.get(e, ZZ(0)) % 2 == 1, (step_sequence, e)
            checked_boundary_edges += 1
        # (c)
        boundary_vertices = set(v for e in boundary for v in e)
        lift = [points[k] for k in range(length)]
        assert len(set(lift)) == length
        assert set(lift) == boundary_vertices, step_sequence
        checked_boundary_vertices += len(boundary_vertices)
        checked_walks += 1

print(
    "PASS: lift-point-distinct closed nonbacktracking walks=%s (length<=%s), "
    "step edges traversed once and on the boundary=%s, boundary edges with odd traversal=%s, "
    "boundary vertices matched bijectively by lift points=%s"
    % (checked_walks, max_length, checked_step_edges, checked_boundary_edges, checked_boundary_vertices)
)
