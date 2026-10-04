# 対象ラベル: claim_high_temperature_sector_decomposition
# 帰属: 有限集合、非負整数、ZZ[x]。

load('sagemath/check/torus-homology-sector-partition/construction.sage')


def high_sector_weight(L, subset):
    exponent = ZZ(2 * L * L - len(subset))
    assert exponent >= 0
    return (PolynomialRingZx(1) + x) ** exponent * (PolynomialRingZx(1) - x) ** len(subset)


def high_sector_samples():
    keys = tuple((ZZ(a), ZZ(b)) for a in (0, 1) for b in (0, 1))
    for L in (1, 2, 3):
        even_subsets = tuple(sector_partition_even_subsets(L))
        weights = {subset: high_sector_weight(L, subset) for subset in even_subsets}
        winding_fibers = {
            key: tuple(subset for subset in even_subsets
                       if sector_partition_witness(L, subset) == key)
            for key in keys
        }
        sector_members = {
            key: tuple(subset for subset in even_subsets
                       if sector_partition_membership(L, subset, key))
            for key in keys
        }
        high_polynomial = sum((weights[subset] for subset in even_subsets), PolynomialRingZx(0))
        sector_polynomials = {
            key: sum((high_sector_weight(L, subset) for subset in sector_members[key]),
                     PolynomialRingZx(0))
            for key in keys
        }
        yield L, even_subsets, weights, winding_fibers, sector_members, high_polynomial, sector_polynomials
