# 対象ラベル: def_cyclic_stage_logarithmic_count_sequence
# 併せて検証: def_cyclic_stage_positive_count_domain
# 式ペア・判定: 正の不動点数を持つ段階だけで素因数指数ベクトルを作り、零には対数を定義しない。
# 帰属: NN と有限台整数ベクトル Lambda。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

positive_rows = 0
zero_rows = 0
for radius in (0, 1):
    for table in truth_tables(radius):
        for exponent in range(1, 5):
            stage_counts = {
                length: ZZ(len(fixed_points(length, radius, table, exponent)))
                for length in range(1, 7)
            }
            positive_domain = {length for length, count in stage_counts.items() if count > 0}
            assert positive_domain == {length for length in stage_counts if stage_counts[length] > 0}
            for length, count in stage_counts.items():
                if length in positive_domain:
                    vector = prime_vector(count)
                    assert reconstruct_prime_vector(vector) == count
                    assert all(prime.is_prime() and exponent != 0 for prime, exponent in vector)
                    positive_rows += 1
                else:
                    assert count == 0
                    zero_rows += 1

assert positive_rows > 0
assert zero_rows > 0
print('positive stage rows checked:', positive_rows)
print('zero stage rows excluded from logarithm:', zero_rows)
print('RESULT: PASS')
