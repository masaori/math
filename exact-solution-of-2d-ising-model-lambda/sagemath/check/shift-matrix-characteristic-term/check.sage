# 対象ラベル: claim_shift_char_matrix_entry_zero / claim_shift_char_term_zero /
#             def_orbit_preserving_permutation / claim_fixed_or_shift_preserves_orbit /
#             claim_orbit_preserving_image
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「シフト行列の特性多項式の和のうち、零元でない項を持ちうるのは軌道を保つ置換だけであること」を、
# 小さい L で総当たりに確かめる。すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、
# 浮動小数点は使わない。
#
# 何を確かめるか:
#   1. claim_shift_char_matrix_entry_zero。tau' != tau かつ tau' != S(tau) ならば
#      ch(U)_{tau,tau'} = iota(kappa(0))（零元）であること。行配位の全対を総当たりする。
#      あわせて、そうでない成分（対角と tau' = S(tau)）が実際には零元でないことも見る。
#      「全部の成分が零元」でも主張は成り立ってしまうので、それを排除するためである。
#   2. claim_shift_char_term_zero。ある tau_1 で phi(tau_1) が tau_1 でも S(tau_1) でもない
#      置換 phi の項が零元であること。S_L の全置換を走る。
#      あわせて、条件を満たさない置換の項に零元でないものが実際にあることも見る
#      （全部の項が零元なら主張は空になる）。
#   3. def_orbit_preserving_permutation / claim_fixed_or_shift_preserves_orbit。
#      各 tau を tau か S(tau) へ送る置換が、軌道を保つ置換であること。S_L の全置換を走る。
#   4. claim_orbit_preserving_image。軌道を保つ置換 phi と軌道 O について phi(O) = O であること。
#      軌道を保つ全ての置換と O_L の全ての元の対を走る。
#      **最終の等号だけを見ない。** 人手証明の中身、すなわち
#      (a) 包含 phi(O) ⊂ O と (b) |phi(O)| = |O| を別々に確かめる。
#      等号だけを見ると、包含を出す議論が誤っていても個数が合ってしまう場合を見逃す。
#   5. 上の 1〜3 を合わせた形。chi_U の和を「軌道を保つ置換の項だけ」に絞っても値が変わらないこと。
#      本文はこれを次のセクションで使うので、絞り込みが値を変えないことをここで見ておく。
#      さらに、本文の chi_U が Sage 自身の行列式で作った det(t I - U) と一致することも見る
#      （作り方が独立なので、置換の走らせ方や符号の向きの取り違えを検出できる）。
#
# 次のセクションの目標（chi_U = prod_{O in O_L} (t^{|O|} - 1)）は**まだ証明していない**。
# ここでは参考として、走らせた L でその等式が実際に成り立つことだけ記録する（下の check_target）。
# これは検証であって証明ではない。
#
# 走らせる範囲（打ち切りを隠さない）。
#   成分についての 1 は L = 1, 2, 3, 4 で行配位の全対を総当たりする。
#   置換を走る 2〜5 は L = 1, 2, 3 に限る。置換の個数が (2^L)! であり、
#   L = 3 で 40320 個、L = 4 では 16! となって総当たりできないためである。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


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


def orbit(L, tau):
    """def_row_config_orbit: O(tau) = { S^[k](tau) | k in N }（キーの凍結集合として持つ）。

    反復は高々 L 回でもとへ戻るので k を 0..L-1 まで走らせれば全体が得られる
    （本文の claim_row_config_shift_period による）。
    """
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return {orbit(L, row_config_from_key(key)) for key in row_matrix_keys(L)}


def is_orbit_preserving(L, phi):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        image_key = row_config_key(L, apply_row_permutation(L, phi, tau))
        if image_key not in orbit(L, tau):
            return False
    return True


def is_fixed_or_shift(L, phi):
    """各 tau について phi(tau) = tau または phi(tau) = S(tau) か（消えない項の条件）。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        image_key = row_config_key(L, apply_row_permutation(L, phi, tau))
        shifted_key = row_config_key(L, row_shift(L, tau))
        if image_key != key and image_key != shifted_key:
            return False
    return True


def permutation_term(L, B, phi, sgn):
    """def_second_determinant の和の phi の項: iota(kappa(sgn phi)) * prod_tau B_{tau,phi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in row_matrix_keys(L):
        image_key = row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
        product *= B[(key, image_key)]
    return iota(const_poly(sgn)) * product


def check_char_matrix_entry_zero(L):
    """1: ch(U)_{tau,tau'} は tau' != tau かつ tau' != S(tau) のとき零元。"""
    ch = characteristic_matrix(L, shift_matrix(L))
    zero = iota(const_poly(0))
    nonzero_seen = 0
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        shifted_key = row_config_key(L, row_shift(L, tau))
        for key_other in row_matrix_keys(L):
            if key_other != key and key_other != shifted_key:
                assert ch[(key, key_other)] == zero, (
                    L, key, key_other, '零元であるべき成分が零元でない')
            else:
                # 「全部の成分が零元」だと主張が空になるので、そうでないことも見る。
                assert ch[(key, key_other)] != zero, (
                    L, key, key_other, '対角または S(tau) の成分が零元になっている')
                nonzero_seen += 1
    print(f'OK: L={L} で ch(U) の成分は対角と tau\'=S(tau) を除いて零元'
          f'（行配位の全 {2 ** L} x {2 ** L} 対を総当たり。零元でない成分は {nonzero_seen} 個）')


def check_term_zero(L, signed_perms):
    """2: phi(tau_1) が tau_1 でも S(tau_1) でもない tau_1 があれば、その項は零元。"""
    ch = characteristic_matrix(L, shift_matrix(L))
    zero = iota(const_poly(0))
    vanishing = 0
    surviving_nonzero = 0
    for phi, sgn in signed_perms:
        term = permutation_term(L, ch, phi, sgn)
        if is_fixed_or_shift(L, phi):
            if term != zero:
                surviving_nonzero += 1
        else:
            assert term == zero, (L, '消えるべき項が零元でない')
            vanishing += 1
    # 条件を満たす置換の項に零元でないものが実際にある（主張が空でない）。
    assert surviving_nonzero > 0, (L, '零元でない項が 1 つも無い')
    print(f'OK: L={L} で「tau_1 でも S(tau_1) でもない値を取る置換」の項は零元'
          f'（全 {len(signed_perms)} 置換のうち {vanishing} 個がこれに当たり、'
          f'残りには零元でない項が {surviving_nonzero} 個ある）')


def check_fixed_or_shift_preserves_orbit(L, signed_perms):
    """3: 各 tau を tau か S(tau) へ送る置換は軌道を保つ。"""
    count = 0
    for phi, _ in signed_perms:
        if is_fixed_or_shift(L, phi):
            assert is_orbit_preserving(L, phi), (L, '軌道を保っていない')
            count += 1
    print(f'OK: L={L} で「各 tau を tau か S(tau) へ送る置換」({count} 個) はすべて軌道を保つ')


def check_orbit_preserving_image(L, signed_perms):
    """4: 軌道を保つ置換 phi と軌道 O について phi(O) = O。包含と個数も別々に見る。"""
    orbits = orbit_set(L)
    count = 0
    for phi, _ in signed_perms:
        if not is_orbit_preserving(L, phi):
            continue
        count += 1
        for o in orbits:
            image = frozenset(
                row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
                for key in o
            )
            # (a) 人手証明の第 1 段: 包含。
            assert image <= o, (L, o, '像が O に含まれない')
            # (b) 人手証明の第 2 段: 単射性から個数が等しい。
            assert len(image) == len(o), (L, o, '像の個数が O と違う')
            # 主張そのもの。
            assert image == o, (L, o, 'phi(O) = O でない')
    print(f'OK: L={L} で軌道を保つ置換 ({count} 個) はどの軌道もそれ自身へ写す'
          f'（軌道は {len(orbits)} 個。包含と個数も別々に確認）')


def check_restriction_to_surviving(L, signed_perms):
    """5: chi_U の和を軌道を保つ置換の項だけに絞っても値が変わらないこと。"""
    ch = characteristic_matrix(L, shift_matrix(L))
    total = SecondPolynomialRing(0)
    restricted = SecondPolynomialRing(0)
    for phi, sgn in signed_perms:
        term = permutation_term(L, ch, phi, sgn)
        total += term
        if is_orbit_preserving(L, phi):
            restricted += term
    assert total == restricted, (L, '軌道を保つ置換だけに絞ると値が変わる')
    # 作り方が独立な比較: Sage 自身の行列式で det(t I - U) を作る。
    keys = row_matrix_keys(L)
    U = shift_matrix(L)
    rows = []
    for a in keys:
        row = []
        for b in keys:
            entry = -iota(U[(a, b)])
            if a == b:
                entry = t + entry
            row.append(entry)
        rows.append(row)
    sage_chi = matrix(SecondPolynomialRing, rows).determinant()
    assert total == sage_chi, (L, '本文の chi_U が Sage の行列式と一致しない')
    print(f'OK: L={L} で chi_U は軌道を保つ置換の項だけの和に等しく、'
          'Sage 自身の行列式とも一致する')


def check_target(L):
    """参考（未証明）: chi_U = prod_{O in O_L} (t^{|O|} - 1) が実際に成り立つこと。

    次のセクションの目標であり、本文ではまだ証明していない。ここでは検証しただけである。
    """
    keys = row_matrix_keys(L)
    U = shift_matrix(L)
    rows = []
    for a in keys:
        row = []
        for b in keys:
            entry = -iota(U[(a, b)])
            if a == b:
                entry = t + entry
            row.append(entry)
        rows.append(row)
    chi = matrix(SecondPolynomialRing, rows).determinant()
    product = SecondPolynomialRing(1)
    for o in orbit_set(L):
        product *= t ** len(o) - SecondPolynomialRing(1)
    assert chi == product, (L, chi, product)
    sizes = sorted(len(o) for o in orbit_set(L))
    print(f'（参考・未証明）L={L} で chi_U = prod_O (t^|O| - 1) が成り立つ（軌道の大きさ {sizes}）')


def main():
    for L in [1, 2, 3, 4]:
        check_char_matrix_entry_zero(L)
    for L in [1, 2, 3]:
        signed_perms = signed_row_permutations(L)
        check_term_zero(L, signed_perms)
        check_fixed_or_shift_preserves_orbit(L, signed_perms)
        check_orbit_preserving_image(L, signed_perms)
        check_restriction_to_surviving(L, signed_perms)
        check_target(L)
    print('すべての検証が通った（シフト行列の特性多項式の消えない項の同定）')


main()
