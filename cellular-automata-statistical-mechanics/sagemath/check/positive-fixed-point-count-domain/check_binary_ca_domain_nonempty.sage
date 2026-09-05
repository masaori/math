# 対象ラベル: claim_binary_ca_positive_count_domain_nonempty
# 式ペア・判定: Pos_F∩[1,2^|V|]_N≠∅（空舞台を含む）
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping in binary_ca_maps():
    bound = ZZ(2)**name[1]
    assert len(mapping) == bound and bound >= 1, name
    assert any(count_fixed(mapping, n) > 0 for n in range(1, bound + 1)), name
    tested += 1
assert tested > 0
print("CA maps checked:", tested)
assert count_fixed((0,), 1) == 1
print("empty stage: one configuration, fixed at exponent 1")
print("RESULT: PASS")
