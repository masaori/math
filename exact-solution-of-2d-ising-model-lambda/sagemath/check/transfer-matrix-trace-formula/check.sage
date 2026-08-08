# 対象ラベル: claim_rows_bijection, claim_transfer_weight_product
#
# 本文（structured-latex/content/main-text.ts）の章「転送行列」の 2 つの主張
#   (1) 配位全体と行配位の族全体は 1 対 1 に対応する
#         rows: Sigma_L -> C_L が全単射で、逆写像は conf: C_L -> Sigma_L
#   (2) 配位の重みは、行に沿った転送行列の成分の積である
#         prod_i T_{rho_i(sigma), rho_{i+1}(sigma)} = x^{b(sigma)}
# を、小さい L で総当たりに確かめる。
#
# (2) の左辺は転送行列の成分（行内・行間の破れの本数から作る）を掛けたもの、
# 右辺は _shared/defs.sage の broken_bond_count（辺の番号を全部走って数える）から作る。
# 両者は作り方が独立である。独立でないと、この検証は構成から自明になり空になる。
#
# 厳密計算のみ（ZZ / ZZ[x]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def check_row_family_count(L):
    """def_row_family: 行配位の族の個数が (2^L)^L = 2^(L^2) であること。"""
    families = list(row_families(L))
    assert len(families) == (2 ** L) ** L, L
    assert len(families) == 2 ** (L * L), L
    assert len(set(families)) == len(families), L


def check_rows_bijection(L):
    """claim_rows_bijection: rows が全単射で、逆写像が conf であること。"""
    # Step 1: conf(rows(sigma)) = sigma。
    images = []
    for sigma in configurations(L):
        c = rows_map(L, sigma)
        images.append(c)
        assert config_from_rows(L, c) == sigma, (L, sorted(sigma.items()))

    # Step 2: rows(conf(c)) = c。
    for c in row_families(L):
        assert rows_map(L, config_from_rows(L, c)) == c, (L, c)

    # Step 3: 逆写像を持つので全単射。像が重複なく C_L を尽くすことでも確かめる。
    assert len(set(images)) == len(images), L
    assert set(images) == set(row_families(L)), L


def check_weight_product(L):
    """claim_transfer_weight_product: 行に沿った成分の積が x^{b(sigma)} に等しいこと。"""
    T = transfer_matrix(L)
    for sigma in configurations(L):
        rows = rows_map(L, sigma)
        left = PolynomialRingZx(1)
        for i in range(L):
            left *= T[(rows[i], rows[(i + 1) % L])]
        right = x ** ZZ(broken_bond_count(L, sigma))
        assert left == right, (L, sorted(sigma.items()), left, right)


def check_matrix_operations(L):
    """def_matrix_over_row_configs: 積・冪・トレースが定義どおりであること。

    冪については A^1 = A と A^{k+1} = A^k A を、トレースについては対角成分の和を
    それぞれ定義そのままの形で確かめる（次の節で Tr(T^L) を使うための足場）。
    """
    T = transfer_matrix(L)
    keys = row_matrix_keys(L)
    assert len(keys) == 2 ** L, L

    assert row_matrix_pow(L, T, 1) == T, L
    power = T
    for k in range(1, 4):
        assert row_matrix_pow(L, T, k) == power, (L, k)
        power = row_matrix_product(L, power, T)

    trace = row_matrix_trace(L, T)
    assert trace == sum((T[(key, key)] for key in keys), PolynomialRingZx(0)), L


def report(L):
    check_row_family_count(L)
    check_rows_bijection(L)
    check_weight_product(L)
    check_matrix_operations(L)
    print('L = %d: 行配位の族の個数 2^%d・rows の全単射性・重みの積・行列演算 をすべて確認'
          % (L, L * L))


for L in [1, 2, 3]:
    report(L)

print('すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）')
