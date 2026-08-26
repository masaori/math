# 対象ラベル: claim_neighborhood_assignment_transpose_finitely_decidable
# 転置写像の全表が有限個の所属判定で作れること、および対合・合成順序の反転・
# 点ごとの和と積および単位元の保存が、その有限表の上で全入力について比較できることを検査する。
#   |N(V)| = 2^{|V|^2}                        （近傍割り当ての個数）
#   N^T の全値は |V|^2 回の所属判定で決まる    （転置の定義の右辺）
#   よって転置表全体は |N(V)|·|V|^2 回で決まる
#   得られた表は N(V) に閉じ、対合性から N(V) 上の全単射になる
# 併せて、自己転置な近傍割り当ての個数を走査で数える。
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

self_transpose_count = {}
decision_count = {}

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)
    space = frozenset(assignments)

    # 第一段: 近傍割り当ての個数は 2^{|V|^2}
    assert len(assignments) == 2 ** (size * size)
    assert len(space) == 2 ** (size * size)

    # 第二段: 各 N の転置は |V|^2 回の所属判定で決まる
    decisions = 0
    table = {}
    for N in assignments:
        values = []
        for w in cells:
            members = []
            for v in cells:
                decisions += 1
                if w in N[v]:
                    members.append(v)
            values.append(frozenset(members))
        T = tuple(values)
        assert T == transpose(cells, N)
        table[N] = T
    assert decisions == len(assignments) * size * size
    decision_count[size] = decisions

    # 第三段: 転置表は N(V) に閉じている
    for N in assignments:
        assert table[N] in space

    # 第四段: 対合性から転置表は N(V) 上の全単射である
    for N in assignments:
        assert table[table[N]] == N
    assert frozenset(table.values()) == space
    assert len(frozenset(table.values())) == len(assignments)

    # 第五段: 各法則の成否を有限表の上で全入力について比較できる
    identity = identity_assignment(cells)
    assert table[identity] == identity
    for N in assignments:
        for M in assignments:
            assert table[compose(cells, N, M)] == compose(cells, table[M], table[N])
            assert table[pointwise_union(cells, N, M)] == pointwise_union(
                cells, table[N], table[M]
            )
            assert table[pointwise_intersection(cells, N, M)] == pointwise_intersection(
                cells, table[N], table[M]
            )

    self_transpose_count[size] = sum(1 for N in assignments if table[N] == N)

# 走査で得た事実: 自己転置な近傍割り当ては対称な二項関係に対応し 2^{|V|(|V|+1)/2} 個ある
for size, count in self_transpose_count.items():
    assert count == 2 ** (size * (size + 1) // 2)

print("PASS transpose_finite_decision decisions_by_size={}".format(decision_count))
print("     self_transpose_count_by_size={}".format(self_transpose_count))
