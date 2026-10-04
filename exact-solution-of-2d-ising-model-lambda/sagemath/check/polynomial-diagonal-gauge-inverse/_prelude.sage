import os
_pdgi_dir = os.path.dirname(os.path.abspath(__file__))
if "_pdgi_rows" not in globals():
    load(os.path.join(_pdgi_dir, "construction.sage"))
    _pdgi_cases = [polynomial_diagonal_gauge_case(L, a, b, root_power)
                   for L in (1, 2, 3) for a, b in product((0, 1), repeat=2)
                   for root_power in (1, 3, 5, 7)]
    _pdgi_rows = {kind: [] for kind in ("empty", "insert", "diagonal", "off_diagonal", "product")}
    for case in _pdgi_cases:
        C, z = case["C"], case["z"]
        size = case["U"].nrows()
        field_zero, poly_zero = _dg_field.zero(), C.zero()
        values = tuple(z^(i % 8) + _dg_field(i - 2 + case["a"] + 2 * case["b"])
                       for i in range(size))
        _pdgi_rows["empty"].append((C(sum((), field_zero)), C(field_zero),
                                    poly_zero, sum((), poly_zero)))
        for h in range(size):
            rest = sum(values[:h], field_zero)
            mapped_rest = sum((C(v) for v in values[:h]), poly_zero)
            _pdgi_rows["insert"].append((
                C(sum(values[:h + 1], field_zero)), C(values[h] + rest),
                C(values[h]) + C(rest), C(values[h]) + mapped_rest,
                sum((C(v) for v in values[:h + 1]), poly_zero)))
        Iq = identity_matrix(_dg_field, size)
        Ix = identity_matrix(C, size)
        for i in range(size):
            for j in range(size):
                value = _dg_field(1 if i == j else 0)
                kind = "diagonal" if i == j else "off_diagonal"
                _pdgi_rows[kind].append((C(Iq[i, j]), C(value), C.one() if i == j else C.zero(), Ix[i, j]))
        for M, N, Mx, Nx in ((case["U"], case["V"], case["Ux"], case["Vx"]),
                              (case["V"], case["U"], case["Vx"], case["Ux"])):
            source_product, target_product = M * N, Mx * Nx
            for i in range(size):
                for j in range(size):
                    _pdgi_rows["product"].append((
                        target_product[i, j],
                        sum((Mx[i, g] * Nx[g, j] for g in range(size)), poly_zero),
                        sum((C(M[i, g]) * C(N[g, j]) for g in range(size)), poly_zero),
                        sum((C(M[i, g] * N[g, j]) for g in range(size)), poly_zero),
                        C(sum((M[i, g] * N[g, j] for g in range(size)), field_zero)),
                        C(source_product[i, j]), C(Iq[i, j]), Ix[i, j]))
