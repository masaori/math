# 対象ラベル: claim_neighborhood_assignment_monoid_center_characterization
# 本文の証明の第一段。O_V と I_V が中心に属することを、引いた二つの claim の内容ごとに分けて検査する。
#   claim_empty_neighborhood_assignment_is_composition_absorbing:
#       O_V star M = O_V = M star O_V
#   claim_identity_neighborhood_assignment_is_composition_identity:
#       I_V star M = M = M star I_V
# 各等号を合成近傍の定義から出した値と突き合わせ、そこから def_neighborhood_assignment_monoid_center
# の所属条件を結論する。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

absorbing_count = 0
identity_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    O = empty_assignment(cells)
    I = identity_assignment(cells)
    for M in neighborhood_assignments(cells):
        # 吸収律の二つの向きを別々に検査する
        left = compose(cells, O, M)
        right = compose(cells, M, O)
        for v in cells:
            # (O star M)(v) = ∪_{u in ∅} M(u) = ∅   (合成近傍の定義と空集合を添字とする合併)
            assert O[v] == frozenset()
            assert left[v] == frozenset()
            # (M star O)(v) = ∪_{u in M(v)} ∅ = ∅
            assert right[v] == frozenset()
        assert left == O
        assert right == O
        # def_neighborhood_assignment_monoid_center の所属条件
        assert compose(cells, O, M) == compose(cells, M, O)
        absorbing_count += 1

        # 単位律の二つの向きを別々に検査する
        left_id = compose(cells, I, M)
        right_id = compose(cells, M, I)
        for v in cells:
            # (I star M)(v) = ∪_{u in {v}} M(u) = M(v)
            assert left_id[v] == M[v]
            # (M star I)(v) = ∪_{u in M(v)} {u} = M(v)
            assert right_id[v] == frozenset(M[v])
        assert left_id == M
        assert right_id == M
        assert compose(cells, I, M) == compose(cells, M, I)
        identity_count += 1

    # 全数走査による所属の直接確認
    assert is_central(cells, O)
    assert is_central(cells, I)

print("PASS check_empty_and_identity_are_central")
print("  absorbing pairs:", absorbing_count)
print("  identity pairs:", identity_count)
