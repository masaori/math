# 対象ラベル: def_second_matrix / def_second_determinant / def_indeterminate_element /
#             def_characteristic_matrix / def_characteristic_polynomial /
#             claim_second_const_degree_zero / claim_second_linear_monic /
#             claim_characteristic_polynomial_monic
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   もう 1 つの不定元の多項式を成分とする、行配位を添字とする行列
#   定義   もう 1 つの不定元の多項式を成分とする行列の行列式
#   定義   不定元 t 自身が定める元
#   定義   転送行列の型の行列に対する特性行列
#   定義   転送行列の型の行列に対する特性多項式
#   主張   定数として送った元の次数は 0 以下である
#   主張   不定元に定数を足したものはモニックな次数 1 の元である
#   主張   特性多項式はモニックな次数 2^L の元である
# を、L = 1, 2, 3 で確かめる。
#
# 確かめること。
#   1. def_indeterminate_element。t の係数が本文の 2 つの等式どおりであること
#      （cf_1(t) = kappa(1)、k != 1 で cf_k(t) = kappa(0)）。
#   2. claim_second_const_degree_zero。iota(a) が D_0 に属すること。
#   3. claim_second_linear_monic。t + iota(a) が M_1 に属すること。
#      あわせて、a を足す前の t 自身も M_1 に属すること（a = kappa(0) の場合）。
#   4. def_characteristic_matrix。特性行列の成分が、通常の tI - A の成分と一致すること。
#      本文は符号の反転を ZZ[x] の中で先に済ませる書き方を採っているので、これが
#      「ZZ[x][t] の引き算で書いたもの」と同じ元であることを確かめる（書き方の違いが
#      値の違いになっていないことの確認）。
#   5. def_second_determinant / def_characteristic_polynomial。本文の det_t が SageMath 自身の
#      行列式（Matrix.determinant()）と一致すること。作り方が独立（Sage の行列式は
#      置換にわたる和ではなく分数自由なアルゴリズム）なので、符号の向きや
#      B_{tau,phi(tau)} と B_{phi(tau),tau} の取り違えを検出できる。
#      あわせて det_t の積の添字の並べ方を変えても値が変わらないことを見る。
#   6. claim_characteristic_polynomial_monic。chi_A が M_{2^L} に属すること。
#      本文の述語（係数で書いた D_n / M_n）で判定し、あわせて Sage 自身の
#      degree() / leading_coefficient() でも判定して一致を見る。
#   7. 人手証明の 3 つの準備そのもの。恒等置換の項が M_{2^L} に属すること、
#      恒等でない置換の項が D_{2^L - 2} に属すること、それらの総和が D_{2^L - 2} に
#      属すること。主張だけを見ると、証明の途中の見積もりが誤っていても最終の等式が
#      たまたま成り立つ場合を見逃すので、途中の 3 つも別々に確かめる。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1, 2, 3。行列 A は 3 種類に限る。転送行列 T、成分がすべて異なる x の冪である行列、
#   対角行列である。**行列の全体は無限集合なので総当たりではない。**
#   置換については各 L で全ての置換を走る（L = 3 では 40320 個）。
#   claim_second_const_degree_zero と claim_second_linear_monic は ZZ[x] の 6 元について見る。
#
# 厳密計算のみ（ZZ、ZZ[x]、ZZ[x][t]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def cf(f, k):
    """def_second_polynomial_ring: f の t^k の係数 cf_k(f) を ZZ[x] の元として返す。"""
    return PolynomialRingZx(SecondPolynomialRing(f)[k])


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


def in_deg_le(f, n):
    """def_second_degree_bound: f in D_n か（k > n のすべての k で cf_k(f) = kappa(0) か）。"""
    for k in range(n + 1, n + 8):
        if cf(f, k) != const_poly(0):
            return False
    return True


def in_monic_deg(f, n):
    """def_second_monic: f in M_n か（D_n の元で、cf_n(f) = kappa(1) か）。"""
    return in_deg_le(f, n) and cf(f, n) == const_poly(1)


def characteristic_matrix(L, A):
    """def_characteristic_matrix: ch(A)_{tau,tau} = t + iota(-A_{tau,tau})、

    tau != tau' では ch(A)_{tau,tau'} = iota(-A_{tau,tau'})。
    符号の反転を ZZ[x] の中で済ませてある（本文と同じ書き方）。
    """
    keys = row_matrix_keys(L)
    entries = {}
    for a in keys:
        for b in keys:
            entries[(a, b)] = (t if a == b else SecondPolynomialRing(0)) + iota(-A[(a, b)])
    return entries


def second_determinant(L, B, signed_perms=None, key_order=None):
    """def_second_determinant: det_t B = sum_phi iota(kappa(sgn phi)) * prod_tau B_{tau,phi(tau)}。

    整数である符号を ZZ[x][t] へ入れる経路は iota・kappa だけである（新しい写像を作らない）。
    key_order は積が添字の並べ方によらないことを確かめるためだけに外から与える。
    """
    if signed_perms is None:
        signed_perms = signed_row_permutations(L)
    keys = row_matrix_keys(L) if key_order is None else key_order
    total = SecondPolynomialRing(0)
    for phi, sgn in signed_perms:
        product = SecondPolynomialRing(1)
        for key in keys:
            product *= B[(key, row_config_key(L, phi[key]))]
        total += iota(const_poly(sgn)) * product
    return total


def characteristic_polynomial(L, A, signed_perms=None):
    """def_characteristic_polynomial: chi_A = det_t(ch(A))。"""
    return second_determinant(L, characteristic_matrix(L, A), signed_perms=signed_perms)


def sage_characteristic_polynomial(L, A):
    """比較用: Sage 自身の行列式で det(t I - A) を作る（作り方が独立）。"""
    keys = row_matrix_keys(L)
    rows = []
    for a in keys:
        row = []
        for b in keys:
            entry = -iota(A[(a, b)])
            if a == b:
                entry = t + entry
            row.append(entry)
        rows.append(row)
    return matrix(SecondPolynomialRing, rows).determinant()


def distinct_power_matrix(L):
    """成分がすべて異なる x の冪である行列（転送行列の対称性で誤りが隠れるのを避ける）。"""
    keys = row_matrix_keys(L)
    entries = {}
    e = 0
    for a in keys:
        for b in keys:
            entries[(a, b)] = x ** ZZ(e)
            e += 1
    return entries


def diagonal_matrix_zx(L):
    """対角行列（対角成分は x の冪、非対角は kappa(0)）。"""
    keys = row_matrix_keys(L)
    entries = {}
    for i, a in enumerate(keys):
        for b in keys:
            entries[(a, b)] = (x ** ZZ(i + 1)) if a == b else const_poly(0)
    return entries


COEFFS = [const_poly(0), const_poly(1), const_poly(2), x, x + const_poly(1), x ** 2 - const_poly(1)]


# --- 1. def_indeterminate_element ------------------------------------------

assert cf(t, 1) == const_poly(1)
for k in [0, 2, 3, 4, 5]:
    assert cf(t, k) == const_poly(0), k
print('OK: 不定元 t の係数が本文の 2 つの等式どおりである（cf_1 = kappa(1)、他は kappa(0)）')


# --- 2, 3. claim_second_const_degree_zero / claim_second_linear_monic -------

for a in COEFFS:
    assert in_deg_le(iota(a), 0), a
    assert in_monic_deg(t + iota(a), 1), a
assert in_monic_deg(t, 1)
print('OK: iota(a) は D_0 に属し、t + iota(a) は M_1 に属する（ZZ[x] の 6 元で確認）')


# --- 4-7. 特性行列・特性多項式 ----------------------------------------------

for L in [1, 2, 3]:
    keys = row_matrix_keys(L)
    signed_perms = signed_row_permutations(L)
    size = ZZ(2) ** L
    assert len(keys) == size

    matrices = {
        '転送行列': transfer_matrix(L),
        '成分がすべて異なる x の冪': distinct_power_matrix(L),
        '対角行列': diagonal_matrix_zx(L),
    }

    for name, A in matrices.items():
        ch = characteristic_matrix(L, A)

        # 4. 特性行列の成分が、ZZ[x][t] の引き算で書いた tI - A の成分と一致すること。
        for a in keys:
            for b in keys:
                expected = -iota(A[(a, b)])
                if a == b:
                    expected = t + expected
                assert ch[(a, b)] == expected, (L, name, a, b)

        chi = characteristic_polynomial(L, A, signed_perms=signed_perms)

        # 5. 本文の det_t が Sage 自身の行列式と一致すること。
        assert chi == sage_characteristic_polynomial(L, A), (L, name)

        # 5. 積の添字の並べ方を変えても値が変わらないこと。
        assert second_determinant(
            L, ch, signed_perms=signed_perms, key_order=list(reversed(keys))
        ) == chi, (L, name)

        # 6. chi_A が M_{2^L} に属すること（本文の述語と Sage の判定の両方で）。
        assert in_monic_deg(chi, size), (L, name)
        assert chi.degree() == size, (L, name)
        assert chi.leading_coefficient() == const_poly(1), (L, name)

        # 7-1. 恒等置換の項が M_{2^L} に属すること（人手証明の準備の第一）。
        identity_term = SecondPolynomialRing(1)
        for key in keys:
            identity_term *= ch[(key, key)]
        assert in_monic_deg(identity_term, size), (L, name)

        # 7-2, 7-3. 恒等でない置換の項が D_{2^L - 2} に属し、その総和も D_{2^L - 2} に属すること
        #           （人手証明の準備の第二・第三）。
        rest = SecondPolynomialRing(0)
        for phi, sgn in signed_perms:
            moved = moved_row_configs(L, phi)
            if not moved:
                continue
            assert len(moved) >= 2, (L, name, phi)
            term = SecondPolynomialRing(1)
            for key in keys:
                term *= ch[(key, row_config_key(L, phi[key]))]
            term *= iota(const_poly(sgn))
            assert in_deg_le(term, size - 2), (L, name, phi)
            rest += term
        assert in_deg_le(rest, size - 2), (L, name)

        # 本体の分解そのもの（chi = 恒等置換の項 + 残り）。
        assert chi == identity_term + rest, (L, name)

    print('OK: L = %d。特性多項式が M_{2^L} に属し、Sage の行列式と一致し、'
          '人手証明の 3 つの準備（恒等の項・恒等でない項・その総和）も成り立つ' % L)

print('すべてのアサーションが成立した（行列は 3 種類に限った標本。置換は全列挙。厳密計算のみ）')
