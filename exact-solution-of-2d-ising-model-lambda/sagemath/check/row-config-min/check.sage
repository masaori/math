# 対象ラベル: claim_row_config_min_unique / def_row_config_min / claim_orbit_min_ne
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「行配位の空でない部分集合は最小元をちょうど 1 つ持つ」「相異なる軌道の最小元は相異なる」を、
# 小さい L で総当たりに確かめる。すべて有限集合の比較と数え上げで、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. claim_row_config_min_unique の存在。空でない部分集合 X について、
#      条件「tau_0 in X かつ 任意の tau in X で tau = tau_0 または tau_0 ≺ tau」を満たす
#      元が少なくとも 1 つあること。
#   2. claim_row_config_min_unique の一意性。その元がちょうど 1 つであること。
#      **存在と一意性を別々に確かめる。** 一意性だけを見ると、条件を満たす元が
#      1 つも無い場合（存在の破れ）が「ちょうど 1 つでない」に含まれず見逃される。
#   3. def_row_config_min。mu(X) が X に属し、X のすべての元に対して条件を満たすこと。
#      定義が主張から取り出したものであることの確認である。
#   4. claim_orbit_min_ne。相異なる軌道の最小元が相異なること。
#      あわせて mu が軌道の全体から R_L への単射であることも見る（主張の言い換え）。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - 最小元が X の「たまたま最初の元」ではないこと、すなわち mu(X) が X の
#     並べ方によらないことを見るため、X の元をいくつかの順で並べ替えても同じ元になるかを見る。
#   - claim_orbit_min_ne は |O_L| >= 2 でなければ空虚である。どの L で軌道が 2 つ以上あるかを記録する。
#
# 走らせる範囲:
#   - 部分集合を総当たりする主張（1・2・3）は 2^(2^L) 通りの部分集合を走るので L = 1, 2, 3 まで。
#     L = 4 では 2^16 = 65536 通りの部分集合それぞれについて最小元を探すことになるので、
#     元の個数が 3 以下の部分集合だけに絞って走らせる（この打ち切りは overview.md にも書く）。
#   - 軌道についての主張（4）は L = 1, ..., 6 まで走らせる（軌道の個数は高々 2^L）。

import itertools
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。"""
    return (y + 1) % L


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def row_shift_iterate(L, k, tau):
    """def_row_config_shift_iterate: S^[0] = id、S^[k+1] = S o S^[k]。"""
    if k == 0:
        return dict(tau)
    return row_shift(L, row_shift_iterate(L, k - 1, tau))


def orbit_of_key(L, key):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    tau = row_config_from_key(key)
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def less(L, key1, key2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key1), row_config_from_key(key2))


def is_min(L, subset, key0):
    """claim_row_config_min_unique の条件そのもの。"""
    if key0 not in subset:
        return False
    return all(key == key0 or less(L, key0, key) for key in subset)


def minimums(L, subset):
    """条件を満たす元をすべて集める（存在と一意性を別々に見るため個数を返せる形にする）。"""
    return [key for key in subset if is_min(L, subset, key)]


def row_config_min(L, subset):
    """def_row_config_min: mu(X)。条件を満たす元がちょうど 1 つであることを使う。"""
    found = minimums(L, subset)
    assert len(found) == 1, 'mu(X) が定まらない（最小元がちょうど 1 つでない）'
    return found[0]


def nonempty_subsets(L, max_card=None):
    """R_L の空でない部分集合を並べる。max_card を与えたら元の個数をそこで打ち切る。"""
    keys = row_matrix_keys(L)
    upper = len(keys) if max_card is None else min(max_card, len(keys))
    for size in range(1, upper + 1):
        for combo in itertools.combinations(keys, size):
            yield frozenset(combo)


def check_min_exists_and_unique(L, max_card=None):
    """1・2・3 を確かめる。"""
    count = 0
    for subset in nonempty_subsets(L, max_card):
        found = minimums(L, subset)
        assert len(found) >= 1, f'L={L} で最小元が存在しない部分集合がある: {sorted(subset)}'
        assert len(found) <= 1, f'L={L} で最小元が 2 つ以上ある部分集合がある: {sorted(subset)}'
        mu = found[0]
        # def_row_config_min が書いている 2 つの性質。
        assert mu in subset, f'L={L} で mu(X) が X に属していない'
        for key in subset:
            assert key == mu or less(L, mu, key), f'L={L} で mu(X) が最小でない'
        count += 1
    limit = '' if max_card is None else f'（元の個数 {max_card} 以下に絞った）'
    print(f'OK: L={L} で空でない部分集合 {count} 個すべてに最小元がちょうど 1 つある{limit}')


def check_min_independent_of_order(L, max_card=None):
    """mu(X) が元の並べ方によらないこと（実装が「最初の元」を返していないことの確認）。"""
    count = 0
    for subset in nonempty_subsets(L, max_card):
        keys = sorted(subset)
        mu = row_config_min(L, subset)
        for permuted in itertools.islice(itertools.permutations(keys), 6):
            found = [key for key in permuted if is_min(L, frozenset(permuted), key)]
            assert found == [mu], f'L={L} で mu(X) が並べ方に依存している'
        count += 1
    print(f'OK: L={L} で mu(X) は元の並べ方によらない（部分集合 {count} 個）')


def check_orbit_min_ne(L):
    """4 を確かめる。相異なる軌道の最小元は相異なる。"""
    orbits = orbit_set(L)
    mins = {}
    for O in orbits:
        mu = row_config_min(L, O)
        assert mu in O, f'L={L} で mu(O) が O に属していない'
        mins[O] = mu
    pairs = 0
    for O1, O2 in itertools.combinations(orbits, 2):
        assert mins[O1] != mins[O2], f'L={L} で相異なる軌道の最小元が一致した'
        pairs += 1
    # 単射であることの言い換え（値の個数が軌道の個数に等しい）。
    assert len({mins[O] for O in orbits}) == len(orbits)
    print(
        f'OK: L={L} で相異なる軌道の最小元は相異なる'
        f'（軌道 {len(orbits)} 個、相異なる対 {pairs} 組）'
    )


def check_not_vacuous(L):
    """主張が空でないことの記録。"""
    orbits = orbit_set(L)
    has_pair = len(orbits) >= 2
    # 最小元が「集合の中で条件を満たすただ 1 つの元」であることが自明でない例、
    # すなわち元が 2 つ以上ある部分集合が実際にあるか。
    has_big_subset = len(row_matrix_keys(L)) >= 2
    print(
        f'記録: L={L} で軌道の相異なる対は'
        f'{"ある" if has_pair else "無い"}（軌道 {len(orbits)} 個）、'
        f'元が 2 つ以上の部分集合は{"ある" if has_big_subset else "無い"}'
        f'（相異なる対が無い L では claim_orbit_min_ne は空虚である）'
    )


def main():
    for L in [1, 2, 3]:
        check_min_exists_and_unique(L)
        check_min_independent_of_order(L)
    # L=4 は部分集合が 2^16 通りあるので、元の個数 3 以下に絞って走らせる。
    check_min_exists_and_unique(4, max_card=3)
    for L in [1, 2, 3, 4, 5, 6]:
        check_orbit_min_ne(L)
        check_not_vacuous(L)
    print('すべての検証が通った（行配位の空でない部分集合の最小元）')


main()
