import os
_dg_dir = os.path.dirname(os.path.abspath(__file__))
if "_dg_cases" not in globals():
    load(os.path.join(_dg_dir, "construction.sage"))
    _dg_cases = [diagonal_gauge_case(L, a, b, root_power)
                 for L in (1, 2, 3) for a, b in product((0, 1), repeat=2)
                 for root_power in (1, 3, 5, 7)]

def diagonal_gauge_scalar_rows(preparation=False):
    for case in _dg_cases:
        for i in range(len(case["edges"])):
            p, q = case["ps"][i], case["qs"][i]
            yield dict(z=case["z"], p=p, q=q, u=case["us"][i], v=case["vs"][i])
            if preparation:
                yield dict(z=case["z"], p=-q, q=-p, u=case["vs"][i], v=case["us"][i])

def diagonal_gauge_matrix_rows(kind):
    for case in _dg_cases:
        for M, N in ((case["U"], case["V"]), (case["V"], case["U"])):
            size = M.nrows()
            product_matrix = M * N
            identity = identity_matrix(_dg_field, size)
            for i in range(size):
                if kind == "zero":
                    for g in range(size):
                        if g != i:
                            # N の行の非零成分と零成分を一つずつ調べる。
                            for j in (g, (g + 1) % size):
                                yield dict(M=M, N=N, i=i, j=j, g=g)
                else:
                    for j in range(size):
                        if kind == "diagonal" and i != j:
                            continue
                        if kind == "off_diagonal" and i == j:
                            continue
                        yield dict(M=M, N=N, i=i, j=j, size=size,
                                   product_matrix=product_matrix,
                                   identity=identity,
                                   m=M[i,i], n=N[i,i])
