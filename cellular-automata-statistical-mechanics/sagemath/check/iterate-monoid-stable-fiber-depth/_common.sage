# 章「安定ファイバーの最小前周期層」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属、非負整数の加減・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-dynamics', '_common.sage'))


def orbit(F, y, last_exponent):
    """F^0 y, F^1 y, ..., F^{last_exponent} y の列（def_finite_self_map_iterate の反復を一段ずつ適用）。"""
    values = [y]
    for _ in range(last_exponent):
        values.append(F[values[-1]])
    return tuple(values)


def is_periodicity_pair(F, y, i, p, window):
    """def_periodicity_pairs: p >= 1 かつ 全ての n in [i, i+window] で F^{n+p} y = F^n y。
    有限集合上では、配位数 M に対して window >= M ととれば n >= i の全称文と同値である
    （F^n y は高々 M 個の値しか取らず、i から i+M の間で必ず再訪するため）。"""
    if p < 1:
        return False
    orb = orbit(F, y, i + window + p)
    return all(orb[n + p] == orb[n] for n in range(i, i + window + 1))


def min_preperiod_period(F, y):
    """def_min_preperiod / def_min_period: μ(y) = min I(y)、π(y) = min{ p : (μ(y), p) ∈ P(y) }。
    候補は claim_min_preperiod_period_finite_decidability の走査範囲 [0,M]×[1,M-i] だが、
    各候補の所属は定義どおり全称文（窓 M）で判定する。"""
    M = len(F)
    for i in range(M + 1):
        for p in range(1, M - i + 1):
            if is_periodicity_pair(F, y, i, p, M):
                return i, p
    raise AssertionError("no periodicity pair found")


def depth_layers(F, fibers, mu_of):
    """def_iterate_monoid_stable_fiber_depth_layer: L_F(q,k) = { y ∈ B_F(q) | μ(y) = k } を
    q ごと・k ∈ [0, M] ごとに frozenset で返す。"""
    M = len(F)
    return {
        q: {k: frozenset(y for y in fibers[q] if mu_of[y] == k) for k in range(M + 1)}
        for q in fibers
    }


def depth_data(table):
    """F、E_F、Q_F、安定ファイバー、σ_F、各配位の (μ(y), π(y))、層 L_F(q,k) を返す。"""
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    mp = {y: min_preperiod_period(F, y) for y in range(len(F))}
    mu_of = {y: mp[y][0] for y in mp}
    layers = depth_layers(F, fibers, mu_of)
    return F, E, Q, fibers, sigma, mp, mu_of, layers
