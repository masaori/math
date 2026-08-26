# 対象ラベル: claim_composed_neighborhood_distributes_over_pointwise_union
# 合成近傍が点ごとの和に左右から分配することを、本文の証明の同値列に分けて検査する。
# 右分配は合併への所属による証人 u の場合分け、左分配は存在量化の論理和への分配である。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

right_checked = 0
left_checked = 0

for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)

    for left in assignments:
        for right in assignments:
            union = pointwise_union(cells, left, right)
            for third in assignments:
                # 右分配: (N⊔M)*L = (N*L)⊔(M*L)
                composed = compose(cells, union, third)
                separated = pointwise_union(
                    cells, compose(cells, left, third), compose(cells, right, third)
                )
                for v in cells:
                    for w in cells:
                        witness_union = any(w in third[u] for u in union[v])
                        witness_split = any(w in third[u] for u in left[v]) or any(
                            w in third[u] for u in right[v]
                        )
                        assert (w in composed[v]) == witness_union
                        assert witness_union == witness_split
                        assert witness_split == (w in separated[v])
                    assert composed[v] == separated[v]
                assert composed == separated
                right_checked += 1

                # 左分配: L*(N⊔M) = (L*N)⊔(L*M)
                composed_left = compose(cells, third, union)
                separated_left = pointwise_union(
                    cells, compose(cells, third, left), compose(cells, third, right)
                )
                for v in cells:
                    for w in cells:
                        witness_union = any(w in left[u] | right[u] for u in third[v])
                        witness_split = any(w in left[u] for u in third[v]) or any(
                            w in right[u] for u in third[v]
                        )
                        assert (w in composed_left[v]) == witness_union
                        assert witness_union == witness_split
                        assert witness_split == (w in separated_left[v])
                    assert composed_left[v] == separated_left[v]
                assert composed_left == separated_left
                left_checked += 1

print("PASS right_distributive={} left_distributive={}".format(right_checked, left_checked))
