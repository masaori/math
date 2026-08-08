# 対象ラベル: claim_configuration_partition, claim_coefficient_representation
#
# 本文（structured-latex/content/partition-polynomial.ts）の主張
#     Z_L = sum_{sigma in Sigma_L} x^{b(sigma)} = sum_{m=0}^{2L^2} Omega_L(m) x^m
# と、その証明が使う類別
#     Sigma_L = union_m A_m （互いに素）、A_m = { sigma | b(sigma) = m }
# を、小さい L で総当たりに数え上げて確かめる。
#
# 左辺（定義そのままの和）と右辺（多重度から作った多項式）は作り方が独立である
# （_shared/defs.sage の partition_polynomial と partition_polynomial_from_multiplicity）。
# 独立でないと、この主張の検証は構成から自明になり空になる。
#
# 厳密計算のみ（ZZ / ZZ['x']）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def classes(L):
    """claim_configuration_partition: A_m = { sigma | b(sigma) = m } を m ごとに集める。

    配位は辞書なので、要素の同一性は頂点の順を固定したタプルで表す。
    """
    sites = vertices(L)
    result = {m: set() for m in range(2 * L * L + 1)}
    for sigma in configurations(L):
        key = tuple(sigma[v] for v in sites)
        result[broken_bond_count(L, sigma)].add(key)
    return result


def report(L):
    """L x L 周期格子について、本文の各 Step を数え上げで確かめる。"""
    sites = vertices(L)
    all_configurations = set(
        tuple(sigma[v] for v in sites) for sigma in configurations(L)
    )
    A = classes(L)

    # claim_configuration_partition の Step 1（被覆）: 合併が Sigma_L に一致する。
    union = set()
    for m in A:
        assert A[m] <= all_configurations, (L, m)
        union |= A[m]
    assert union == all_configurations, L

    # claim_configuration_partition の Step 2（互いに素）: m != m' なら共通元を持たない。
    for m in A:
        for m2 in A:
            if m != m2:
                assert A[m] & A[m2] == set(), (L, m, m2)

    # claim_coefficient_representation の Step 1: Omega_L(m) = |A_m|。
    multiplicities = multiplicity_vector(L)
    for m in A:
        assert multiplicities[m] == len(A[m]), (L, m, multiplicities[m], len(A[m]))

    # claim_coefficient_representation の Step 4: 1 つの類の中では単項式が共通で、
    # 類の上の和は Omega_L(m) x^m に等しい。
    for m in A:
        class_sum = PolynomialRingZx(0)
        for sigma in configurations(L):
            if tuple(sigma[v] for v in sites) in A[m]:
                assert broken_bond_count(L, sigma) == m, (L, m)
                class_sum += x ** broken_bond_count(L, sigma)
        assert class_sum == multiplicities[m] * x ** m, (L, m, class_sum)

    # claim_coefficient_representation の Step 5（結論）:
    # 定義どおりの和と、多重度から作った多項式が一致する。
    Z_from_definition = partition_polynomial(L)
    Z_from_multiplicity = partition_polynomial_from_multiplicity(L)
    assert Z_from_definition == Z_from_multiplicity, (
        L, Z_from_definition, Z_from_multiplicity)
    # 係数を 1 つずつ突き合わせる（多項式の相等だけでなく係数の対応も見る）。
    for m in range(2 * L * L + 1):
        assert Z_from_definition[m] == multiplicities[m], (L, m)
    # 次数は破れボンド数の上界 2L^2 を超えない。
    assert Z_from_definition.degree() <= 2 * L * L, (L, Z_from_definition.degree())

    print('L =', L)
    print('  Z_L = sum_sigma x^{b(sigma)}       =', Z_from_definition)
    print('  Z_L = sum_m Omega_L(m) x^m         =', Z_from_multiplicity)
    print('  Omega_L(m) = |A_m| (m = 0..2L^2)   =', multiplicities)


for L in [1, 2, 3]:
    report(L)

print()
print('OK: Z_L = sum_m Omega_L(m) x^m と、その証明が使う類別を L = 1, 2, 3 で確認した（厳密計算）')
