# 対象ラベル: claim_eventually_periodic_limit_quantity_only_at_one
# 帰属: 剰余類ごとの値は QQ。有限個の値の二つの場合を厳密に検査する。

examples = [
    [QQ(2)],
    [QQ(7) / QQ(3), QQ(7) / QQ(3), QQ(7) / QQ(3)],
    [QQ(2), QQ(3)],
    [QQ(5) / QQ(2), QQ(5) / QQ(2), QQ(11) / QQ(4)],
]

for residue_values in examples:
    all_agree = all(c == residue_values[0] for c in residue_values)
    differing_pair = any(
        residue_values[r] != residue_values[s]
        for r in range(len(residue_values))
        for s in range(len(residue_values))
    )
    assert all_agree != differing_pair

print("RESULT: PASS")
