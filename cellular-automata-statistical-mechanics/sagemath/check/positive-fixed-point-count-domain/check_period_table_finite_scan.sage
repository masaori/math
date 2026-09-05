# 対象ラベル: claim_positive_count_domain_finitely_decidable
# 式ペア・判定: 有限走査の μ,π から μ=0 の周期を重複除去し Len_F を復元
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping in cases():
    scanned = []
    for x in range(len(mapping)):
        prefix = iterate_map(mapping, x, len(mapping))
        mu, pi, candidates = scanned_min_preperiod_period(prefix, len(mapping))
        assert (mu, pi) == direct_min_preperiod_period(prefix), (name, mapping, x)
        assert 1 <= pi <= len(mapping), (name, x)
        if mu == 0:
            scanned.append(pi)
    table = set(scanned)
    assert table == realized_lengths(mapping), (name, mapping)
    assert table <= set(range(1, len(mapping) + 1)), (name, mapping)
    tested += 1
assert tested > 0
print("maps checked:", tested)
print("RESULT: PASS")
