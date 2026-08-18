import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))


def irreducible_factor_type(poly):
    # 非零多項式の、相異なる既約因子（原始的・最高次係数正）の (次数, 重複度) の有限多重集合
    parts = []
    for (f, m) in poly.factor():
        if f.degree() > 0:
            assert f.is_irreducible()
            parts.append((f.degree(), m))
    return sorted(parts)


# 段 1: Z_2 の既約分解の型は {(1,4),(2,2),(4,1)}
Z2 = partition_polynomial_by_layer_transfer(2, free_box_edges(2), False)
type_Z2 = irreducible_factor_type(Z2)
assert type_Z2 == [(1, 4), (2, 2), (4, 1)], type_Z2
print("PASS: factor type of Z_2 is {(1,4),(2,2),(4,1)}")

# 段 2: Z'_2 = Z_3 の既約分解の型は {(1,14),(40,1)}
Z3 = partition_polynomial_by_layer_transfer(3, free_box_edges(3), False)
type_Z3 = irreducible_factor_type(Z3)
assert type_Z3 == [(1, 14), (40, 1)], type_Z3
print("PASS: factor type of Z'_2 = Z_3 is {(1,14),(40,1)}")

# 段 3: 二つの多重集合は異なる
assert type_Z2 != type_Z3
print("PASS: the two factor-type multisets differ")
