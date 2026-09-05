# 対象ラベル: claim_binary_ca_fixed_point_count_bound
# 式ペア・判定: Z_n(F)≤|A^V|=2^|V|
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping in binary_ca_maps():
    size = name[1]
    configs = elementary_configurations(size)
    assert len(configs) == 2**size, name
    assert len(mapping) == len(configs), name
    assert all(0 <= target < len(configs) for target in mapping), name
    for n in range(1, 2*len(mapping) + 1):
        assert 0 <= count_fixed(mapping, n) <= len(configs), (name, n)
        tested += 1
assert tested > 0
print("CA-exponent pairs checked:", tested)
print("RESULT: PASS")
