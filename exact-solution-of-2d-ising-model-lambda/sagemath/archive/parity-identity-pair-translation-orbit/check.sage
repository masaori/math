"""非共有端点対の寄与を相対座標（平行移動軌道）で分類する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

有向辺対の反転指示値の和（終点順序の反転と始点順序の反転の F_2 和）は、
二つの有向辺だけで決まる関数である。端点を共有しない対を相対座標の類
（二辺の種類・向きと、位置の差ベクトル mod L）で分類すると、各類は
ちょうど一つの対角平行移動軌道になる。検査するのは

  (1) 寄与は対の順序交換で不変である（類を無順序で定義できる）、
  (2) 寄与は類の上で一定ではない（混在する類の個数を記録する。従って
      相対座標だけによる対ごとの直接対応は組めない）、
  (3) 平行移動不変量は軌道合計の偶奇である。辺長が偶数（L=2,4,6）なら
      全ての類で軌道合計が偶になり、辺長が奇数（L=3,5,7）では奇の類が
      存在する、
  (4) 奇数辺長の奇の類は、二辺の種類が水平と垂直の混合か、または
      同じ列内の逆向き垂直辺対（種類 v・向き 0 と 1）に限る。同種で
      同じ向きの辺対の類は全て偶である、
  (5) 全配置が寄与する類は、辺長 3 以上では同じ列の逆向き垂直辺対
      （相対座標 (0,j)、j≠0）にちょうど一致する（軌道の大きさが L^2 なので
      奇数辺長でだけ軌道合計の奇に効く）。辺長 2 だけは、対角位置
      （相対座標 (1,1)）の同じ向きの垂直辺対二類も全配置で寄与する、

である。有限集合と整数の厳密演算だけを使い、浮動小数点は使わない。
"""


def edge_endpoints_base(side, base):
    kind, i, j = base
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def directed_endpoints(side, directed):
    kind, i, j, orientation = directed
    first, second = edge_endpoints_base(side, (kind, i, j))
    return (first, second) if orientation == 0 else (second, first)


def pair_contribution(side, left, right):
    row = ZZ(
        (directed_endpoints(side, left)[1], left)
        > (directed_endpoints(side, right)[1], right)
    )
    column = ZZ(
        (directed_endpoints(side, left)[0], left)
        > (directed_endpoints(side, right)[0], right)
    )
    return (row + column) % 2


def all_directed_edges(side):
    return [(kind, i, j, orientation)
            for kind in ("h", "v")
            for i in range(side) for j in range(side)
            for orientation in (0, 1)]


def relative_class(side, left, right):
    def form(first, second):
        kind_f, i_f, j_f, orientation_f = first
        kind_s, i_s, j_s, orientation_s = second
        return (kind_f, orientation_f, kind_s, orientation_s,
                (i_s - i_f) % side, (j_s - j_f) % side)
    return min(form(left, right), form(right, left))


def classify(side):
    classes = {}
    edges = all_directed_edges(side)
    for left_index in range(len(edges)):
        for right_index in range(left_index + 1, len(edges)):
            left = edges[left_index]
            right = edges[right_index]
            if (set(directed_endpoints(side, left))
                    & set(directed_endpoints(side, right))):
                continue
            value = pair_contribution(side, left, right)
            assert value == pair_contribution(side, right, left)
            key = relative_class(side, left, right)
            zero, one = classes.get(key, (ZZ(0), ZZ(0)))
            classes[key] = (zero + ZZ(value == 0), one + ZZ(value == 1))
    return classes


for side in (2, 3, 4, 5, 6, 7):
    classes = classify(side)
    mixed = sum(1 for zero, one in classes.values() if zero > 0 and one > 0)
    odd_classes = sorted(key for key, (zero, one) in classes.items()
                         if one % 2 == 1)
    full_classes = sorted(key for key, (zero, one) in classes.items()
                          if zero == 0)
    expected_full = sorted(
        ("v", 0, "v", 1, 0, offset) for offset in range(1, side))
    if side == 2:
        expected_full = sorted(expected_full
                               + [("v", 0, "v", 0, 1, 1),
                                  ("v", 1, "v", 1, 1, 1)])
    assert full_classes == expected_full
    if side % 2 == 0:
        assert not odd_classes
    else:
        assert odd_classes
        assert mixed > 0
        for kind_f, orientation_f, kind_s, orientation_s, _, _ in odd_classes:
            mixed_kinds = (kind_f == "h" and kind_s == "v")
            opposite_vertical = (kind_f == "v" and kind_s == "v"
                                 and orientation_f != orientation_s)
            assert mixed_kinds or opposite_vertical
    print("L=%d: classes=%d mixed=%d odd-orbit=%d all-contributing=%d"
          % (side, len(classes), mixed, len(odd_classes), len(full_classes)))

print("PASS: 非共有端点対の寄与は相対座標の類の上で一定ではないが、"
      "軌道合計の偶奇は偶数辺長で全て零、奇数辺長では水平垂直混合か"
      "同列逆向き垂直の類だけに奇が残り、全配置寄与の類は同列逆向き垂直"
      "（相対座標 (0,j)、j≠0）にちょうど一致する")
