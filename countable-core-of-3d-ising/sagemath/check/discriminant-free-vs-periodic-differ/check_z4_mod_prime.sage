import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

# #E_4 = 3 * 4^2 * (4-1) = 144。次数上界 + 1 個の相異なる点で Z_4 mod p を復元する。
prime = ZZ(65537)
F = GF(prime)
R = PolynomialRing(F, "x")
point_count = 145
points = [
    (
        F(k),
        F(free_partition_value_by_fast_layer_transfer_mod_prime(4, k, prime)),
    )
    for k in range(point_count)
]
Z4_mod_prime = R.lagrange_polynomial(points)

# 次数が 144 のままなので、整数係数 Z_4 の最高次係数は p で消えていない。
assert Z4_mod_prime.degree() == 144
assert Z4_mod_prime(F(1)) == F(2**64)
print("PASS: Z_4 mod 65537 has degree 144 and Z_4(1)=2^64")

# ある素数で次数を保ったまま square-free なら、整数係数 Z_4 の判別式は非零である。
assert gcd(Z4_mod_prime, Z4_mod_prime.derivative()) == R.one()
assert Z4_mod_prime.is_squarefree()
print("PASS: Z_4 mod 65537 is square-free, hence disc(Z_4) != 0 over ZZ")
print("ALL PASS")
