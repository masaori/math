# 対象ラベル: claim_plane_simple_polygon_cyclic_turning
#
# 一周期の持ち上げ点が二つずつ相異なる零巻き付きの閉じた非後退単位格子歩について、
# 循環総回転数が {+4, -4} に属することを ZZ の有限数え上げで検査する。
# あわせて L=1,2,3 トーラスへの射影で接触対数 n_ct が正になる歩
# （旧仮定 n_ct=0 では扱えなかった対象）が存在することを確認する。
# 射影は各歩の方向を保つので、射影した辺列の循環総回転数は平面歩のそれに等しい。

from itertools import product

steps = ((ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1)))
# 方向番号: (0,1)→0, (1,0)→1, (0,-1)→2, (-1,0)→3（本文の方向単位ベクトルの巡回順）
direction_number = {
    (ZZ(0), ZZ(1)): ZZ(0),
    (ZZ(1), ZZ(0)): ZZ(1),
    (ZZ(0), ZZ(-1)): ZZ(2),
    (ZZ(-1), ZZ(0)): ZZ(3),
}
max_length = 10
checked_walks = 0
turning_values = set()
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


def cyclic_total_turning(step_sequence):
    length = len(step_sequence)
    total = ZZ(0)
    for index in range(length):
        turn = (direction_number[step_sequence[(index + 1) % length]]
                - direction_number[step_sequence[index]]) % 4
        assert turn in (0, 1, 3), (step_sequence, index)
        total += {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]
    return total


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

        turning = cyclic_total_turning(step_sequence)
        assert turning in (ZZ(4), ZZ(-4)), (step_sequence, turning)
        turning_values.add(turning)
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

assert turning_values == {ZZ(4), ZZ(-4)}
for size in torus_sizes:
    assert contact_walks[size] > 0

print(
    f"PASS: lift-point-distinct closed nonbacktracking walks={checked_walks}, "
    f"cyclic total turning in {{+4,-4}} (both attained), length<=%d, " % max_length
    + "walks with n_ct>0 after projection: "
    + ", ".join("L=%s: %s" % (size, contact_walks[size]) for size in torus_sizes)
)
