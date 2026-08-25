# 対象ラベル: claim_neighborhood_assignment_composition_not_commutative
# 併せて検証するラベル: def_noncommutative_neighborhood_assignment_witness
# 3 セル舞台 V_nc = {a,b,c} の明示的な N, M について (N*M)(a) = {c}、(M*N)(a) = 空、
# したがって N*M != M*N であることを、証明の各段に分けて検査する。
# さらに |V| <= 3 の全ての組を走査し、可換でない組が実在すること（と |V| = 1 では
# 合成が可換であること）を確かめる。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

a, b, c = 0, 1, 2
cells = (a, b, c)
N = (frozenset({b}), frozenset(), frozenset())
M = (frozenset(), frozenset({c}), frozenset())

# 証明の各段
left = compose(cells, N, M)
right = compose(cells, M, N)
assert N[a] == frozenset({b})
assert left[a] == frozenset().union(*[M[u] for u in N[a]])   # 合成近傍の定義
assert left[a] == M[b]                                        # N(a) = {b}
assert left[a] == frozenset({c})                              # M(b) = {c}
assert M[a] == frozenset()
assert right[a] == frozenset()                                # 空集合を添字とする合併
assert c in left[a] and c not in right[a]
assert left[a] != right[a]
assert left != right

# 可換でない組の存在と、|V| = 1 での可換性
noncommuting = {}
for cell_count in range(1, 4):
    stage = tuple(range(cell_count))
    assignments = neighborhood_assignments(stage)
    count = 0
    for outer in assignments:
        for inner in assignments:
            if compose(stage, outer, inner) != compose(stage, inner, outer):
                count += 1
    noncommuting[cell_count] = count
assert noncommuting[1] == 0
assert noncommuting[2] > 0
assert noncommuting[3] > 0

print(f"PASS witness_ok=True noncommuting_pairs={noncommuting}")
