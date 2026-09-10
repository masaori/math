# 対象ラベル: claim_cyclic_stage_shift_logarithmic_density_obstruction
# 式ペア・判定: Z=2 の素因数指数ベクトルは素数 2 の係数だけが 1 で、復元すると 2 に戻る。
# 帰属: NN と有限台整数ベクトル Lambda。浮動小数点、実対数、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

fixed_point_count = ZZ(2)
logarithmic_count = prime_vector(fixed_point_count)

assert logarithmic_count == ((ZZ(2), ZZ(1)),)
assert reconstruct_prime_vector(logarithmic_count) == fixed_point_count
assert dict(logarithmic_count)[ZZ(2)] == ZZ(1)
assert all(prime.is_prime() and coefficient != 0
           for prime, coefficient in logarithmic_count)

print('prime coefficients checked:', len(logarithmic_count))
print('RESULT: PASS')

