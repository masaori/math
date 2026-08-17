# 章「安定ファイバーの層別完全逆像」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・合併、非負整数の加減・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-depth', '_common.sage'))


def full_preimage(F, subset):
    """F^{-1}(subset) = { y ∈ A^V | F(y) ∈ subset }。全配位を走査する完全逆像。"""
    return frozenset(y for y in range(len(F)) if F[y] in subset)


def layer_preimage_scan(F, Q, fibers, sigma, mu_of, layers):
    """各配位 y へ F を一度だけ適用し、F(y) が属すただ一つの層 (q', k) へ振り分けて、
    全ての層の完全逆像 pre[(q', k)] = F^{-1}(L_F(q', k)) を一括で得る走査。
    振り分けが完全逆像に一致する根拠は、ファイバーが配位集合を分割し
    （claim_iterate_monoid_stable_fiber_unique_representative の既証明）、各ファイバーが層で
    分割される（claim_iterate_monoid_stable_fiber_depth_partition の既証明）ことである。
    分割性はこの関数内でも配位数の一致として検査する。"""
    M = len(F)
    fiber_of = {}
    for q in fibers:
        for y in fibers[q]:
            assert y not in fiber_of        # ファイバーの非交差
            fiber_of[y] = q
    assert len(fiber_of) == M               # ファイバーの合併が配位集合全体
    sigma_inv = {sigma[q]: q for q in Q}
    assert len(sigma_inv) == len(Q)         # σ_F は全単射
    pre = {}
    for y in range(M):
        fy = F[y]
        key = (fiber_of[fy], mu_of[fy])
        assert fy in layers[key[0]][key[1]]  # 振り分け先の層の定義どおりの所属
        pre.setdefault(key, set()).add(y)
    return fiber_of, sigma_inv, {key: frozenset(ys) for key, ys in pre.items()}
