import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

# 段 1: Z_2 の因数分解が 2(x+1)^4 (x^2+1)^2 (x^4-4x^3+8x^2-4x+1) であること
Z2 = partition_polynomial_by_layer_transfer(2, free_box_edges(2), False)
x = Z2.parent().gen()
q4 = x**4 - 4 * x**3 + 8 * x**2 - 4 * x + 1
assert Z2 == 2 * (x + 1) ** 4 * (x**2 + 1) ** 2 * q4, Z2.factor()
print("PASS: Z_2 = 2(x+1)^4(x^2+1)^2(x^4-4x^3+8x^2-4x+1)")

# 段 2: Z_2 の分解体の Galois 群 G_2 は位数 4 で巡回でない（よって C_2 x C_2）
radical = ((x + 1) * (x**2 + 1) * q4)  # Z_2 の根基（相異なる根を持つ部分）
K = radical.splitting_field("a")
assert K.degree() == 4, K.degree()
G2 = K.galois_group()
assert G2.order() == 4, G2.order()
assert G2.is_abelian()
assert not G2.is_cyclic()
print("PASS: G_2 = Gal(splitting field of Z_2) has order 4, abelian, not cyclic => C_2 x C_2")

# 段 3: Z_3 = c (x+1)^14 g、g は既約 40 次。ゆえに G_3 = G'_2 の位数は 40 の倍数
Z3 = partition_polynomial_by_layer_transfer(3, free_box_edges(3), False)
factors = Z3.factor()
parts = sorted([(f.degree(), m, f) for (f, m) in factors if f.degree() > 0])
assert len(parts) == 2, parts
assert parts[0][:2] == (1, 14) and parts[0][2] == x + 1, parts[0]
(deg_g, mult_g, g) = parts[1]
assert (deg_g, mult_g) == (40, 1), (deg_g, mult_g)
assert g.is_irreducible()
# 分解体の Galois 群は g の 40 個の根へ推移的に作用するので、軌道・固定群定理により位数は 40 の倍数
print("PASS: Z_3 = c (x+1)^14 g with g irreducible of degree 40 => 40 | #G_3")

# 段 4: 位数 4 は 40 の倍数でないので G_2 と G_3 は同型でない
assert 4 % 40 != 0
print("PASS: 4 is not a multiple of 40 => G_2 and G_3 are not isomorphic")
