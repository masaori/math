# 対象ラベル: def_second_matrix / def_second_determinant / def_indeterminate_element /
#             def_characteristic_matrix / def_characteristic_polynomial
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   もう 1 つの不定元の多項式を成分とする、行配位を添字とする行列
#   定義   もう 1 つの不定元の多項式を成分とする行列の行列式
#   定義   不定元 t 自身が定める元
#   定義   転送行列の型の行列に対する特性行列
#   定義   転送行列の型の行列に対する特性多項式
# を、L = 1, 2, 3 で確かめる。
#
# 確かめること。
#   1. def_indeterminate_element。t の係数が本文の 2 つの等式どおりであること
#      （cf_1(t) = kappa(1)、k != 1 で cf_k(t) = kappa(0)）。
#   2. def_characteristic_matrix。特性行列の成分が、通常の tI - A の成分と一致すること。
#      本文は符号の反転を ZZ[x] の中で先に済ませる書き方を採っているので、これが
#      「ZZ[x][t] の引き算で書いたもの」と同じ元であることを確かめる（書き方の違いが
#      値の違いになっていないことの確認）。
#   3. def_second_determinant / def_characteristic_polynomial。本文の det_t が SageMath 自身の
#      行列式（Matrix.determinant()）と一致すること。作り方が独立（Sage の行列式は
#      置換にわたる和ではなく分数自由なアルゴリズム）なので、符号の向きや
#      B_{tau,phi(tau)} と B_{phi(tau),tau} の取り違えを検出できる。
#      あわせて det_t の積の添字の並べ方を変えても値が変わらないことを見る。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1, 2, 3。行列 A は 3 種類に限る。転送行列 T、成分がすべて異なる x の冪である行列、
#   対角行列である。**行列の全体は無限集合なので総当たりではない。**
#   置換については各 L で全ての置換を走る（L = 3 では 40320 個）。
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


# --- 2, 3. 特性行列・特性多項式 ----------------------------------------------

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

        # 2. 特性行列の成分が、ZZ[x][t] の引き算で書いた tI - A の成分と一致すること。
        for a in keys:
            for b in keys:
                expected = -iota(A[(a, b)])
                if a == b:
                    expected = t + expected
                assert ch[(a, b)] == expected, (L, name, a, b)

        chi = characteristic_polynomial(L, A, signed_perms=signed_perms)

        # 3. 本文の det_t が Sage 自身の行列式と一致すること。
        assert chi == sage_characteristic_polynomial(L, A), (L, name)

        # 3. 積の添字の並べ方を変えても値が変わらないこと。
        assert second_determinant(
            L, ch, signed_perms=signed_perms, key_order=list(reversed(keys))
        ) == chi, (L, name)

    print('OK: L = %d。特性行列の成分が tI - A どおりであり、'
          '特性多項式が Sage の行列式と一致し、積の添字の順序によらない' % L)

print('すべてのアサーションが成立した（行列は 3 種類に限った標本。置換は全列挙。厳密計算のみ）')
