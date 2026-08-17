import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

# 段 1: L=2 で列挙と層転送が一致する（自由・周期の両方）
for periodic in [False, True]:
    edges = periodic_box_edges(2) if periodic else free_box_edges(2)
    by_enum = partition_polynomial_by_enumeration(2, edges)
    by_layer = partition_polynomial_by_layer_transfer(2, edges, periodic)
    assert by_enum == by_layer, (periodic, by_enum, by_layer)
    assert by_enum(1) == 2**8
print("PASS: L=2 enumeration == layer transfer")

# 段 2: L=2 では判別式は一致する（どちらも 0）。周期辺が各対に二重に付くので Z^per_2(x)=Z_2(x^2)
Z2 = partition_polynomial_by_layer_transfer(2, free_box_edges(2), False)
Z2p = partition_polynomial_by_layer_transfer(2, periodic_box_edges(2), True)
x = Z2.parent().gen()
assert Z2p == Z2(x**2)
assert Z2.discriminant() == 0 and Z2p.discriminant() == 0
assert not Z2.is_squarefree() and not Z2p.is_squarefree()
print("PASS: L=2: Z^per_2 = Z_2(x^2), disc both 0 (equal)")

# 段 3: L=3 で disc(Z_3) = 0 != disc(Z_3^per)
Z3 = partition_polynomial_by_layer_transfer(3, free_box_edges(3), False)
Z3p = partition_polynomial_by_layer_transfer(3, periodic_box_edges(3), True)
assert Z3.degree() == 54 and Z3(1) == 2**27 and Z3p(1) == 2**27
d3 = Z3.discriminant()
d3p = Z3p.discriminant()
assert d3 == 0 and not Z3.is_squarefree()
assert d3p != 0 and Z3p.is_squarefree()
assert d3 != d3p
print("PASS: L=3: disc(Z_3)=0, disc(Z_3^per)!=0, differ")

# 段 4: 自由境界の高速層転送核は密行列版から得た厳密多項式の値と一致する
for box_side, polynomial in [(2, Z2), (3, Z3)]:
    for point_value in [0, 1, 2]:
        fast_value = free_partition_value_by_fast_layer_transfer(box_side, point_value)
        assert fast_value == polynomial(point_value), (box_side, point_value, fast_value, polynomial(point_value))
print("PASS: fast free-boundary layer transfer agrees at L=2,3 and x=0,1,2")
print("ALL PASS")
