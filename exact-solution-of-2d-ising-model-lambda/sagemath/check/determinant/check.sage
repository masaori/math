# 対象ラベル: def_constant_polynomial / def_identity_matrix / def_determinant
#
# 本文（structured-latex/content/main-text.ts）の章「固有値の代数性」の
#   定義   定数多項式を与える写像、単位行列、そして行列式
# を、小さい L で総当たりに確かめる。
#
# 確かめること。
#   1. def_constant_polynomial。kappa が和と積を保つこと、kappa(0) が零元・kappa(1) が
#      単位元であること、kappa が単射であること（整数と定数多項式が 1 対 1 であること）。
#   2. def_determinant。定義の右辺が確定すること、および積の添字 R_L に順序を入れていないこと。
#      後者は、添字を並べる順序をいくつか変えて同じ値が出ることで確かめる
#      （本文は「ZZ[x] の積が可換なので順序によらない」と述べており、それが空でない主張である）。
#   3. 本文の行列式が SageMath 自身の行列式と一致すること。本文の det は置換にわたる和で
#      定めており、Sage の Matrix.determinant() は別の作り方（分数自由なアルゴリズム）なので、
#      一致は定義の取り違え（符号の向き、A_{phi(tau),tau} と A_{tau,phi(tau)} の取り違え）を
#      検出する。
#   4. 転送行列 T の行列式も 3 で突き合わせる（本文が実際に扱う行列で確かめるため）。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1: 行配位 2 個、置換 2 個。1〜4 をすべて走る。
#   L = 2: 行配位 4 個、置換 24 個。1〜4 をすべて走る。
#   L = 3: 行配位 8 個、置換 40320 個。
#          2・3・4 は行列式が 40320 項の和になるので、行列は転送行列と
#          「成分がすべて異なる x の冪である行列」と対角行列の 3 つに限る（行列についての標本）。
#
# 厳密計算のみ（ZZ、ZZ[x]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def check_const_poly():
    """def_constant_polynomial: kappa は和と積を保ち、単射である。"""
    values = [ZZ(n) for n in range(-4, 5)]
    for m in values:
        for n in values:
            assert const_poly(m + n) == const_poly(m) + const_poly(n), (m, n)
            assert const_poly(m * n) == const_poly(m) * const_poly(n), (m, n)
        assert const_poly(m) * const_poly(1) == const_poly(m), m
        assert const_poly(m) * const_poly(0) == const_poly(0), m
        assert const_poly(m) + const_poly(0) == const_poly(m), m
        for n in values:
            if m != n:
                assert const_poly(m) != const_poly(n), (m, n)
    assert const_poly(0) == PolynomialRingZx(0)
    assert const_poly(1) == PolynomialRingZx(1)
    print('OK: kappa は和と積を保ち、kappa(0) は零元・kappa(1) は単位元であり、単射である')


def distinct_power_matrix(L):
    """成分がすべて異なる x の冪である行列（対称性で誤りが隠れないようにするため）。"""
    keys = row_matrix_keys(L)
    entries = {}
    exponent = 0
    for a in keys:
        for b in keys:
            entries[(a, b)] = x ** ZZ(exponent)
            exponent += 1
    return entries


def diagonal_matrix_over_zx(L):
    """対角成分だけが非零な行列（対角成分は互いに異なる x の冪 + 定数）。"""
    keys = row_matrix_keys(L)
    entries = {(a, b): const_poly(0) for a in keys for b in keys}
    for index, key in enumerate(keys):
        entries[(key, key)] = x ** ZZ(index + 1) + const_poly(index + 2)
    return entries


def sage_matrix_of(L, A):
    """本文の行列（辞書）を Sage の行列へ移す。添字の並べ方は row_matrix_keys の順。"""
    keys = row_matrix_keys(L)
    return matrix(PolynomialRingZx, len(keys), len(keys),
                  [[A[(a, b)] for b in keys] for a in keys])

def check_determinant_matches_sage(L, signed_perms, matrices):
    """本文の det（置換にわたる和）と Sage の determinant()（別の作り方）が一致する。"""
    for name, A in matrices:
        left = determinant(L, A, signed_perms)
        right = sage_matrix_of(L, A).determinant()
        assert left == right, (L, name, left, right)


def check_product_order_independent(L, signed_perms, A):
    """det の定義の積が、添字 R_L を並べる順序によらないこと。"""
    keys = row_matrix_keys(L)
    base = determinant(L, A, signed_perms, key_order=keys)
    for order in [list(reversed(keys)), sorted(keys), sorted(keys, reverse=True)]:
        assert determinant(L, A, signed_perms, key_order=order) == base, (L, order)
    return base


def check_all(L):
    signed_perms = signed_row_permutations(L)
    keys = row_matrix_keys(L)
    matrices = [
        ('transfer', transfer_matrix(L)),
        ('distinct-powers', distinct_power_matrix(L)),
        ('diagonal', diagonal_matrix_over_zx(L)),
        ('identity', identity_row_matrix(L)),
    ]
    check_determinant_matches_sage(L, signed_perms, matrices)
    check_product_order_independent(L, signed_perms, distinct_power_matrix(L))
    det_transfer = determinant(L, transfer_matrix(L), signed_perms)
    print(
        'L =', L,
        ': 行配位', len(keys), '個・置換', len(signed_perms), '個。',
        'Sage の行列式との一致を行列', len(matrices), '種で確認。',
        'det T =', det_transfer,
    )


check_const_poly()
for L in (1, 2, 3):
    check_all(L)
print('すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）')
