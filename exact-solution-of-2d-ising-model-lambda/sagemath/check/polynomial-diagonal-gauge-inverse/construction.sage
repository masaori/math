import os
_pdgi_construction_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_pdgi_construction_dir, "..", "diagonal-gauge-inverse", "construction.sage"))
_pdgi_ring = PolynomialRing(_dg_field, "x")


def polynomial_diagonal_gauge_case(L, a, b, root_power):
    case = diagonal_gauge_case(L, a, b, root_power)
    case["C"] = _pdgi_ring
    case["Ux"] = case["U"].change_ring(_pdgi_ring)
    case["Vx"] = case["V"].change_ring(_pdgi_ring)
    return case
