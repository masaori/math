# 対象ラベル: claim_neighborhood_assignment_intersection_and_distributivity_finite_decidable
# 点ごとの積の演算表、合成が積に分配する三つ組の集合、分配しない反例の有無が、
# 有限回の所属判定だけで決定できることを検査する。
# 走査の結果、分配する三つ組と分配しない三つ組の個数は舞台ごとに次の値になった。
#   |V| = 0, 1 : 反例なし
#   |V| = 2    : 4096 三つ組のうち左右それぞれ 420 個が反例
# すなわち非分配性を示す最小の舞台は |V| = 2 であり、本文が挙げた三元の反例は最小ではない。
# 本文はどの反例も最小であるとは主張していないので、これは記述の誤りではない。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

expected_bad = {0: 0, 1: 0, 2: 420}
report = []

for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)

    # 点ごとの積の演算表を有限走査で作り、値が再び N(V) に属することを確認する
    meet_table = {}
    for left in assignments:
        for right in assignments:
            value = pointwise_intersection(cells, left, right)
            assert value in set(assignments)
            meet_table[(left, right)] = value
    assert len(meet_table) == len(assignments) ** 2

    left_ok = 0
    left_bad = 0
    right_ok = 0
    right_bad = 0
    for left in assignments:
        for right in assignments:
            for third in assignments:
                # 左分配 (N⊓M)*L = (N*L)⊓(M*L)
                lhs = compose(cells, pointwise_intersection(cells, left, right), third)
                rhs = pointwise_intersection(
                    cells, compose(cells, left, third), compose(cells, right, third)
                )
                if lhs == rhs:
                    left_ok += 1
                else:
                    left_bad += 1
                # 右分配 L*(N⊓M) = (L*N)⊓(L*M)
                lhs2 = compose(cells, third, pointwise_intersection(cells, left, right))
                rhs2 = pointwise_intersection(
                    cells, compose(cells, third, left), compose(cells, third, right)
                )
                if lhs2 == rhs2:
                    right_ok += 1
                else:
                    right_bad += 1

    # 分配する組と反例の個数がどちらも有限走査で確定すること
    assert left_ok + left_bad == len(assignments) ** 3
    assert right_ok + right_bad == len(assignments) ** 3
    assert left_bad == expected_bad[cell_count]
    assert right_bad == expected_bad[cell_count]
    report.append((cell_count, len(assignments), len(meet_table), left_ok, left_bad, right_ok, right_bad))

# |V| = 3 では三つ組が 512^3 通りなので全数走査しない。
# 代わりに、本文が与えた二つの明示反例が有限回の所属判定で反例と判定されることだけを確認する。
a, b, c = 0, 1, 2
cells3 = (a, b, c)
N = (frozenset({b}), frozenset(), frozenset())
M = (frozenset({c}), frozenset(), frozenset())
L = (frozenset(), frozenset({a}), frozenset({a}))
assert compose(cells3, pointwise_intersection(cells3, N, M), L) != pointwise_intersection(
    cells3, compose(cells3, N, L), compose(cells3, M, L)
)
Lp = (frozenset({b, c}), frozenset(), frozenset())
Np = (frozenset(), frozenset({a}), frozenset())
Mp = (frozenset(), frozenset(), frozenset({a}))
assert compose(cells3, Lp, pointwise_intersection(cells3, Np, Mp)) != pointwise_intersection(
    cells3, compose(cells3, Lp, Np), compose(cells3, Lp, Mp)
)

for cell_count, size, table, left_ok, left_bad, right_ok, right_bad in report:
    print(
        "PASS |V|={} |N(V)|={} meet_table={} left(ok={},counterexamples={}) right(ok={},counterexamples={})".format(
            cell_count, size, table, left_ok, left_bad, right_ok, right_bad
        )
    )
print("PASS |V|=3 both explicit witnesses decided as counterexamples")
