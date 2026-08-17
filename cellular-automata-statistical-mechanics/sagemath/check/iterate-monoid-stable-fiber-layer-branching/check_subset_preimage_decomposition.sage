# 対象ラベル: claim_iterate_monoid_finite_subset_preimage_decomposition
# 各有限部分集合 T ⊆ A^V で F^{-1}(T) = ∪_{z∈T} Pre_F(z) を、人手証明の所属同値の各段で確かめる。
#   y ∈ F^{-1}(T) ⟺ F(y) ∈ T                (写像の完全逆像の定義)
#              ⟺ ∃z∈T, F(y) = z             (z := F(y))
#              ⟺ ∃z∈T, y ∈ Pre_F(z)         (def_iterate_monoid_stable_fiber_predecessor_set)
#              ⟺ y ∈ ∪_{z∈T} Pre_F(z)       (有限合併への所属の定義)
# T は各舞台の配位集合の全ての部分集合を尽くす（M = 2^|V| <= 8 なので 2^M <= 256 個）。
# 帰属: 有限集合の所属・等号・合併だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

from itertools import combinations

instances = 0
subsets_checked = 0
memberships = 0
for stage_size, rule, table in exhaustive_instances():
    F = table
    M = len(F)
    pre = {z: predecessor_set(F, z) for z in range(M)}
    universe = list(range(M))
    for size in range(M + 1):
        for T in combinations(universe, size):
            T = frozenset(T)
            union = frozenset().union(*(pre[z] for z in T)) if T else frozenset()
            inverse = full_preimage(F, T)
            for y in range(M):                       # 所属同値の各段
                in_inverse = F[y] in T               # 完全逆像の定義
                exists_z = any(F[y] == z for z in T)  # z := F(y) による存在文
                exists_pre = any(y in pre[z] for z in T)  # Pre_F(z) の定義
                in_union = y in union                # 有限合併への所属
                assert in_inverse == exists_z == exists_pre == in_union
                memberships += 1
            assert inverse == union                  # 集合の等号
            subsets_checked += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("subsets checked: {}".format(subsets_checked))
print("membership equivalences checked: {}".format(memberships))
print("RESULT: PASS")
