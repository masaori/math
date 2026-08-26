# 対象ラベル: claim_self_transpose_neighborhood_assignments_finitely_decidable
# 自己転置な近傍割り当て全体とその個数が有限舞台から有限決定できることを検査する。
# 本文の証明の各段を分けて検査する。
#   N(V) の有限列挙（|N(V)| = 2^{|V|^2}）
#   各 N について転置表を作り、有限個の値の比較で自己転置性を決定する
#   走査して集めた有限集合の元を数える
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

for size in (0, 1, 2, 3, 4):
    cells = tuple(range(size))
    n = ZZ(size)
    enumeration = neighborhood_assignments(cells)

    # 第一段: N(V) の有限列挙の個数
    assert ZZ(len(enumeration)) == 2 ** (n * n)
    assert len(frozenset(enumeration)) == len(enumeration)

    collected = []
    membership_tests = 0
    value_comparisons = 0
    for N in enumeration:
        # 第二段: 転置表は |V|^2 回の所属判定で決まる
        T = tuple(
            frozenset(v for v in cells if w in N[v])
            for w in cells
        )
        membership_tests += size * size
        assert T == transpose(cells, N)

        # 第三段: 自己転置性は有限個の値の比較で決まる
        decision = all(T[v] == N[v] for v in cells)
        value_comparisons += size
        assert decision == (T == N)

        if decision:
            collected.append(N)

    # 第四段: 走査回数は舞台元数だけで決まる
    assert membership_tests == len(enumeration) * size * size
    assert value_comparisons == len(enumeration) * size

    # 第五段: 集めた有限集合の元を数える
    assert ZZ(len(collected)) == 2 ** ((n * (n + 1)) / 2)
    assert tuple(collected) == self_transpose_assignments(cells)

print("PASS finite_decision sizes=0..4")
