# 対象ラベル: claim_composed_neighborhood_monotone
# N <= N' かつ M <= M' から (N*M) <= (N'*M') が従うことを、本文の証明の含意列
#   w ∈ (N*M)(v) ⟺ ∃u ∈ N(v), w ∈ M(u)
#                ⟹ ∃u ∈ N'(v), w ∈ M(u)
#                ⟹ ∃u ∈ N'(v), w ∈ M'(u) ⟺ w ∈ (N'*M')(v)
# の各段に分けて検査する。片方だけを動かした単調性も別に検査する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

checked_pairs = 0
checked_left = 0
checked_right = 0

for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    for outer in assignments:
        for outer_upper in assignments:
            if not precedes(cells, outer, outer_upper):
                continue
            for inner in assignments:
                for inner_upper in assignments:
                    if not precedes(cells, inner, inner_upper):
                        continue
                    small = compose(cells, outer, inner)
                    large = compose(cells, outer_upper, inner_upper)
                    for v in cells:
                        for w in small[v]:
                            # 第一段: 合成近傍の定義から証人 u ∈ N(v) を取る
                            witnesses = [u for u in outer[v] if w in inner[u]]
                            assert witnesses
                            u = witnesses[0]
                            # 第二段: N <= N' により同じ u が N'(v) に入る
                            assert u in outer_upper[v]
                            # 第三段: M <= M' により w ∈ M'(u)
                            assert w in inner_upper[u]
                            # 第四段: 合成近傍の定義に戻る
                            assert w in large[v]
                        assert small[v] <= large[v]
                    assert precedes(cells, small, large)
                    checked_pairs += 1

    # 片側だけを動かした単調性（左単調・右単調）を別に検査する
    for outer in assignments:
        for outer_upper in assignments:
            if not precedes(cells, outer, outer_upper):
                continue
            for inner in assignments:
                assert precedes(
                    cells, compose(cells, outer, inner), compose(cells, outer_upper, inner)
                )
                checked_left += 1
    for inner in assignments:
        for inner_upper in assignments:
            if not precedes(cells, inner, inner_upper):
                continue
            for outer in assignments:
                assert precedes(
                    cells, compose(cells, outer, inner), compose(cells, outer, inner_upper)
                )
                checked_right += 1

print(
    "PASS monotone_quadruples={} left_monotone={} right_monotone={}".format(
        checked_pairs, checked_left, checked_right
    )
)
