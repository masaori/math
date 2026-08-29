# 章「安定ファイバーの層別分岐個数」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・合併・共通部分、非負整数の加算・等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
# depth_data（層 L_F(q,k)）と full_preimage・layer_preimage_scan（完全逆像とその一括走査）
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-layer-preimage', '_common.sage'))


def predecessor_set(F, z):
    """def_iterate_monoid_stable_fiber_predecessor_set: Pre_F(z) = { y ∈ A^V | F(y) = z }。"""
    return frozenset(y for y in range(len(F)) if F[y] == z)


def predecessor_count(F, z):
    """def_iterate_monoid_stable_fiber_predecessor_count: b_F(z) = |Pre_F(z)| ∈ N。"""
    return len(predecessor_set(F, z))


def assert_pairwise_disjoint(sets):
    """claim_iterate_monoid_stable_fiber_predecessors_disjoint の既証明を、対ごとの共通部分の空で検査する。"""
    sets = list(sets)
    for i in range(len(sets)):
        for j in range(i + 1, len(sets)):
            assert not (sets[i] & sets[j])
