"""孤立した横断の平滑化が横断数を一つ減らすことを有限データで厳密検査する。"""

from itertools import product


def step_turning(incoming, outgoing):
    residue = (outgoing - incoming) % 4
    if residue == 0:
        return ZZ(0)
    if residue == 1:
        return ZZ(1)
    if residue == 3:
        return ZZ(-1)
    return None


def transverse(first, second):
    incoming_1, outgoing_1 = first
    incoming_2, outgoing_2 = second
    return (step_turning(incoming_1, outgoing_1) == 0
            and step_turning(incoming_2, outgoing_2) == 0
            and incoming_1 % 2 != incoming_2 % 2)


def crossing_count(vertices, visits):
    return ZZ(sum(1 for i in range(len(visits)) for j in range(i + 1, len(visits))
                  if vertices[i] == vertices[j] and transverse(visits[i], visits[j])))


# claim_isolated_smoothing_crossing_number_update:
# 選択した頂点をちょうど二通過だけが通り、その二通過が横断するとき、
# 出方向を交換した後の横断数が一つ減ることを全有限局所データで確認する。
visits = [(incoming, outgoing) for incoming in range(4) for outgoing in range(4)
          if step_turning(incoming, outgoing) is not None]
checked = 0
for other_count in range(4):
    for selected_first in visits:
        for selected_second in visits:
            if not transverse(selected_first, selected_second):
                continue
            for other_visits in product(visits, repeat=other_count):
                # 選択した頂点 0 は最初の二通過だけが通る。残りは相互の横断も検査するため
                # 頂点 1 または 2 へ全て割り当てる。
                for other_vertices in product((1, 2), repeat=other_count):
                    vertices = [0, 0] + list(other_vertices)
                    before_visits = [selected_first, selected_second] + list(other_visits)
                    after_visits = [
                        (selected_first[0], selected_second[1]),
                        (selected_second[0], selected_first[1]),
                    ] + list(other_visits)
                    assert step_turning(*after_visits[0]) in (ZZ(-1), ZZ(1))
                    assert step_turning(*after_visits[1]) in (ZZ(-1), ZZ(1))
                    before = crossing_count(vertices, before_visits)
                    after = crossing_count(vertices, after_visits)
                    assert before == after + 1
                    assert (before - after) % 2 == 1
                    checked += 1

assert checked > 0
print(f"PASS: 孤立横断の平滑化 {checked} 件で横断数 = 平滑化後 + 1 を確認")
