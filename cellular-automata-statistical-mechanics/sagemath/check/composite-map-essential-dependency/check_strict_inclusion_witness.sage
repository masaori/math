# 対象ラベル: claim_composite_map_support_bound_can_be_strict
# 併せて検証するラベル: def_composite_support_strict_inclusion_witness
# 二元舞台 V_s = {a,b} の明示的な F, G について、証明の各段を分けて検査する。
#   (1) G(x)(a) = G(x)(b) = x(a)、F(y)(a) は y(a), y(b) の相違、F(y)(b) = 0。
#   (2) (F∘G)_a が定値写像であり D_{F∘G}(a) = 空。
#   (3) D_F(a) = {a,b}、D_G(a) = D_G(b) = {a}、(D_F * D_G)(a) = {a}。
#   (4) 空 ⊊ {a} すなわち包含が真の包含であること。
# さらに |V| = 2 の全ての組で真の包含が起きる個数を記録する。
# 帰属: 有限集合と 0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

a, b = 0, 1
cells = (a, b)
states = configurations(cells)

# (1) 反例の二つの有限真理値表
G = {x: (x[a], x[a]) for x in states}
F = {y: (0 if y[a] == y[b] else 1, 0) for y in states}
for x in states:
    assert G[x][a] == x[a] and G[x][b] == x[a]
for y in states:
    assert F[y][a] == (0 if y[a] == y[b] else 1)
    assert F[y][b] == 0

# (2) 合成の a 成分は定値
composite = compose_maps(cells, F, G)
composite_a = cell_map(cells, composite, a)
assert set(composite_a.values()) == {0}
D_composite = dependency_assignment(cells, composite)
assert D_composite[a] == frozenset()

# (3) 各依存台と合成近傍
D_F = dependency_assignment(cells, F)
D_G = dependency_assignment(cells, G)
assert D_F[a] == frozenset({a, b})
assert D_G[a] == frozenset({a})
assert D_G[b] == frozenset({a})
bound = composed_neighborhood(cells, D_F, D_G)
assert bound[a] == frozenset().union(*[D_G[u] for u in D_F[a]])   # 合成近傍の定義
assert bound[a] == D_G[a] | D_G[b]                                 # D_F(a) = {a,b}
assert bound[a] == frozenset({a})                                  # D_G(a) = D_G(b) = {a}

# (4) 真の包含
assert D_composite[a] <= bound[a]
assert D_composite[a] != bound[a]
assert a in bound[a] and a not in D_composite[a]

# |V| = 2 の全ての組での真の包含の個数
maps = tuple(all_maps(cells))
assignments = tuple(dependency_assignment(cells, M) for M in maps)
strict_pairs = 0
for i, P in enumerate(maps):
    for j, Q in enumerate(maps):
        composite_assignment = dependency_assignment(cells, compose_maps(cells, P, Q))
        upper = composed_neighborhood(cells, assignments[i], assignments[j])
        if any(composite_assignment[v] != upper[v] for v in cells):
            strict_pairs += 1
assert strict_pairs > 0

print(f"PASS witness_ok=True strict_pairs_V2={strict_pairs} of {len(maps) ** 2}")
