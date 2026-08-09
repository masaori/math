# 対象ラベル: claim_const_embedding_prod / claim_prod_orbit_decomposition /
#             def_orbit_term_factor / claim_orbit_term_factorization
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「軌道を保つ置換が与える項は、軌道ごとの因子の積である」を、小さい L で総当たりに確かめる。
# すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. claim_const_embedding_prod。iota(kappa(prod n_i)) = prod iota(kappa(n_i))。
#      整数の組を長さ 0〜3 で総当たりする（0 を含む組・負の数を含む組も走らせる）。
#   1. claim_prod_orbit_decomposition。prod_{tau in R_L} f(tau) = prod_O prod_{tau in O} f(tau)。
#      f は行配位ごとに相異なる元を返すものを使う。すべて同じ値を返す f だと、
#      軌道の切り方を取り違えていても等式が成り立ってしまうためである。
#      あわせて、軌道の全体が R_L の分割であること（合併と互いに素）も別に見る。
#   2. def_orbit_term_factor。W_O(B,psi) が本文の定義どおりであること、および
#      O の中の値だけで決まること（O の外の値を別の置換のものへ差し替えても変わらないこと）。
#      **これを別に確かめる理由**: 下の 3 は積の等式なので、O の外の値が紛れ込んでいても
#      たまたま積が合ってしまう場合がある。
#   3. claim_orbit_term_factorization。iota(kappa(sgn phi)) * prod_tau B_{tau,phi(tau)}
#      = prod_O W_O(B, phi|_O)。人手証明の式変形の 3 つの段を**別々に**確かめる。
#      最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
#        (a) iota(kappa(sgn phi)) = prod_O iota(kappa(sgn_O(phi|_O)))（符号の積表示 + 上の 0）
#        (b) prod_tau B_{tau,phi(tau)} = prod_O prod_{tau in O} B_{tau,phi(tau)}（上の 1）
#        (c) 2 つの有限積の積が、成分ごとの積の有限積であること
#      行列 B は 2 つ走らせる。本文が次に使うシフト行列の特性行列 ch(U) と、
#      成分がすべて零元でない一般の行列である。**ch(U) だけでは足りない**——成分の大半が
#      零元なので、多くの項が 0 = 0 になり、積の組み替えを何も確かめない場合があるためである。
#
# 走らせる範囲（打ち切りを隠さない）。
#   0 と 1 は置換を走らせないので L = 1, 2, 3, 4。
#   2 と 3 は軌道を保つ置換 S^O_L を S_L の全列挙から絞って作るので（軌道ごとの置換から
#   組み立てると、その組み立てが前のセクションの主張になっており循環する）L = 1, 2, 3 に限る。
#   L = 4 では 16! 通りで走らせられない。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


def iota_kappa(n):
    """整数を ZZ[x][t] の元として使う唯一の経路 iota o kappa。"""
    return iota(const_poly(n))


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


def orbit(L, tau):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def is_orbit_preserving_map(L, phi_keys):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か。"""
    return all(phi_keys[key] in orbit_of_key(L, key) for key in row_matrix_keys(L))


def orbit_preserving_permutations_by_enumeration(L):
    """S^O_L を S_L の全列挙から絞って得る（組み立てを前提にしない）。キーの辞書で返す。"""
    result = []
    for phi in row_permutations(L):
        as_keys = {
            key: row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
            for key in row_matrix_keys(L)
        }
        if is_orbit_preserving_map(L, as_keys):
            result.append(as_keys)
    return result


def ordered_pair_keys(L):
    """def_inversion_count: P_L をキーの対で持つ。"""
    keys = row_matrix_keys(L)
    return [
        (key_1, key_2) for key_1 in keys for key_2 in keys if less(L, key_1, key_2)
    ]


def inversion_count(L, phi, pairs):
    """def_inversion_count: inv(phi) = |Inv(phi)|。"""
    return len([
        (key_1, key_2) for (key_1, key_2) in pairs if less(L, phi[key_2], phi[key_1])
    ])


def permutation_sign(L, phi, pairs):
    """def_permutation_sign: sgn(phi) = (-1)^{inv(phi)}。"""
    return (-1) ** inversion_count(L, phi, pairs)


def orbit_inversion_count(L, phi, o):
    """def_orbit_inversion_count: inv_O(phi|_O)。台は F(O,O)。"""
    return len([
        (key_1, key_2)
        for key_1 in sorted(o)
        for key_2 in sorted(o)
        if less(L, key_1, key_2) and less(L, phi[key_2], phi[key_1])
    ])


def orbit_permutation_sign(L, phi, o):
    """def_orbit_permutation_sign: sgn_O(phi|_O) = (-1)^{inv_O(phi|_O)}。"""
    return (-1) ** orbit_inversion_count(L, phi, o)


def orbit_factor(L, B, o, phi):
    """def_orbit_term_factor: W_O(B,psi) = iota(kappa(sgn_O(psi))) * prod_{tau in O} B_{tau,psi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in sorted(o):
        product *= B[(key, phi[key])]
    return iota_kappa(orbit_permutation_sign(L, phi, o)) * product


def permutation_term(L, B, phi, sgn):
    """def_second_determinant の和の phi の項。"""
    product = SecondPolynomialRing(1)
    for key in row_matrix_keys(L):
        product *= B[(key, phi[key])]
    return iota_kappa(sgn) * product


def shift_matrix(L):
    """def_shift_matrix: U_{tau,tau'} は tau' = S(tau) なら kappa(1)、そうでなければ kappa(0)。"""
    keys = row_matrix_keys(L)
    entries = {}
    for key in keys:
        shifted_key = row_config_key(L, row_shift(L, row_config_from_key(key)))
        for key_other in keys:
            entries[(key, key_other)] = (
                const_poly(1) if key_other == shifted_key else const_poly(0)
            )
    return entries


def characteristic_matrix(L, A):
    """def_characteristic_matrix: 対角は t + iota(-A_{tau,tau})、他は iota(-A_{tau,tau'})。"""
    keys = row_matrix_keys(L)
    entries = {}
    for a in keys:
        for b in keys:
            entries[(a, b)] = (t if a == b else SecondPolynomialRing(0)) + iota(-A[(a, b)])
    return entries


def generic_matrix(L):
    """成分がすべて零元でない行列（ch(U) だけでは項の多くが 0 = 0 になるため）。"""
    keys = row_matrix_keys(L)
    entries = {}
    for i, a in enumerate(keys):
        for j, b in enumerate(keys):
            entries[(a, b)] = t * iota_kappa(i + 1) + iota_kappa(j + 2)
    return entries


def distinct_valued_map(L):
    """行配位ごとに相異なる元を返す f（軌道の切り方の取り違えを検出するため）。"""
    keys = row_matrix_keys(L)
    return {key: t * iota_kappa(i + 1) + iota_kappa(1) for i, key in enumerate(keys)}


def check_const_embedding_prod(L):
    """0: iota(kappa(prod n_i)) = prod iota(kappa(n_i))。"""
    values = [-2, -1, 0, 1, 3]
    count = 0
    for length in range(4):
        for combo in itertools.product(values, repeat=length):
            left = iota_kappa(prod(combo) if combo else 1)
            right = SecondPolynomialRing(1)
            for n in combo:
                right *= iota_kappa(n)
            assert left == right, (combo, 'iota o kappa が有限積を保たない')
            count += 1
    print(f'OK: iota(kappa(prod n_i)) = prod iota(kappa(n_i))（整数の組 {count} 通り。'
          '長さ 0（空の積）から 3 まで、0 と負の数を含む）')


def check_orbit_partition(L, orbits):
    """1 の前半: 軌道の全体が R_L の分割であること（合併と互いに素）。"""
    keys = set(row_matrix_keys(L))
    union = set()
    for o in orbits:
        assert o, (L, '空の軌道がある')
        union |= set(o)
    assert union == keys, (L, '軌道の合併が R_L でない')
    for i, o_1 in enumerate(orbits):
        for o_2 in orbits[i + 1:]:
            assert not (set(o_1) & set(o_2)), (L, '相異なる軌道が交わっている')
    print(f'OK: L={L} で軌道の全体は R_L の分割（軌道 {len(orbits)} 個、行配位 {len(keys)} 個）')


def check_prod_orbit_decomposition(L, orbits):
    """1 の後半: prod_{tau in R_L} f(tau) = prod_O prod_{tau in O} f(tau)。"""
    f = distinct_valued_map(L)
    assert len(set(f.values())) == len(f), (L, 'f が相異なる値を返していない')
    left = SecondPolynomialRing(1)
    for key in row_matrix_keys(L):
        left *= f[key]
    right = SecondPolynomialRing(1)
    for o in orbits:
        inner = SecondPolynomialRing(1)
        for key in sorted(o):
            inner *= f[key]
        right *= inner
    assert left == right, (L, '有限積の軌道ごとの分解が破れた')
    print(f'OK: L={L} で prod_tau f(tau) = prod_O prod_{{tau in O}} f(tau)'
          '（f は行配位ごとに相異なる値を返す）')


def check_orbit_factor_definition(L, perms, orbits, matrices):
    """2: W_O の定義が本文どおりで、O の外の値に依らないこと。"""
    keys = row_matrix_keys(L)
    for name, B in matrices:
        for phi in perms:
            for o in orbits:
                value = orbit_factor(L, B, o, phi)
                # 定義そのもの（符号の因子と成分の積へ分けて組み直す）。
                product = SecondPolynomialRing(1)
                for key in sorted(o):
                    product *= B[(key, phi[key])]
                assert value == iota_kappa(orbit_permutation_sign(L, phi, o)) * product, (
                    L, name, 'W_O が定義と一致しない')
                # O の外の値を（O の中の値はそのままに）別の置換のものへ差し替える。
                for other in perms:
                    modified = {
                        key: (phi[key] if key in o else other[key]) for key in keys
                    }
                    assert orbit_factor(L, B, o, modified) == value, (
                        L, name, 'W_O が O の外の値に依存した')
    print(f'OK: L={L} で W_O は定義どおりで、O の中の値だけで決まる'
          f'（行列 {len(matrices)} 種 x 置換 {len(perms)} 個 x 軌道 {len(orbits)} 個）')


def check_term_factorization(L, perms, orbits, pairs, matrices):
    """3: 項の分解と、人手証明の式変形の 3 段 (a)(b)(c)。"""
    nonzero_terms = {name: 0 for name, _ in matrices}
    for name, B in matrices:
        for phi in perms:
            sgn = permutation_sign(L, phi, pairs)
            # (a) 符号の因子が軌道ごとの因子の積であること。
            sign_left = iota_kappa(sgn)
            sign_right = SecondPolynomialRing(1)
            for o in orbits:
                sign_right *= iota_kappa(orbit_permutation_sign(L, phi, o))
            assert sign_left == sign_right, (L, name, '符号の因子の積表示が破れた')
            # (b) 成分の積が軌道ごとの積の積であること。
            entry_left = SecondPolynomialRing(1)
            for key in row_matrix_keys(L):
                entry_left *= B[(key, phi[key])]
            entry_inner = []
            for o in orbits:
                inner = SecondPolynomialRing(1)
                for key in sorted(o):
                    inner *= B[(key, phi[key])]
                entry_inner.append(inner)
            entry_right = SecondPolynomialRing(1)
            for inner in entry_inner:
                entry_right *= inner
            assert entry_left == entry_right, (L, name, '成分の積の軌道ごとの分解が破れた')
            # (c) 2 つの有限積の積が、成分ごとの積の有限積であること。
            combined = SecondPolynomialRing(1)
            for o, inner in zip(orbits, entry_inner):
                combined *= iota_kappa(orbit_permutation_sign(L, phi, o)) * inner
            assert sign_right * entry_right == combined, (
                L, name, '2 つの有限積の積が成分ごとの積の有限積と一致しない')
            # 主張そのもの。
            term = permutation_term(L, B, phi, sgn)
            factor_product = SecondPolynomialRing(1)
            for o in orbits:
                factor_product *= orbit_factor(L, B, o, phi)
            assert term == factor_product, (L, name, '項の軌道ごとの因子への分解が破れた')
            if term != SecondPolynomialRing(0):
                nonzero_terms[name] += 1
    for name, _ in matrices:
        print(f'OK: L={L}（{name}）で項 = prod_O W_O(B, phi|_O)'
              f'（置換 {len(perms)} 個。式変形の 3 段 (a)(b)(c) を別々に確認。'
              f'零元でない項は {nonzero_terms[name]} 個）')
    return nonzero_terms


def main():
    for L in [1, 2, 3, 4]:
        orbits = orbit_set(L)
        check_orbit_partition(L, orbits)
        check_prod_orbit_decomposition(L, orbits)
    check_const_embedding_prod(1)
    print('（0 と 1 は置換を走らせないので L=4 まで走らせた）')

    nonzero_seen = {'ch(U)': 0, '一般の行列': 0}
    for L in [1, 2, 3]:
        perms = orbit_preserving_permutations_by_enumeration(L)
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        matrices = [
            ('ch(U)', characteristic_matrix(L, shift_matrix(L))),
            ('一般の行列', generic_matrix(L)),
        ]
        check_orbit_factor_definition(L, perms, orbits, matrices)
        counts = check_term_factorization(L, perms, orbits, pairs, matrices)
        for name in nonzero_seen:
            nonzero_seen[name] += counts[name]
        print(f'記録: L={L} で軌道を保つ置換は {len(perms)} 個、軌道は {len(orbits)} 個')
    assert nonzero_seen['ch(U)'] > 0, 'ch(U) の項がすべて零元（主張が空虚）'
    assert nonzero_seen['一般の行列'] > 0, '一般の行列の項がすべて零元（主張が空虚）'
    print('（置換を走らせる検証で L=4 以上は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った（軌道を保つ置換が与える項は、軌道ごとの因子の積である）')


main()
