# 対象ラベル: claim_cross_power_equality_is_sufficient_for_limit_quantity
# 交差べき等式から二つの乗根列の項別一致を得る可算側の合成を、
# 正の有理数乗根を持つ有限列について本文と同順に確認する。
# 帰属: QQ と有限列だけを使う。実数の極限、浮動小数点、実対数は使わない。

examples = [
    (QQ(8), ZZ(3), QQ(2), QQ(4), ZZ(2), QQ(2)),
    (QQ(27) / 8, ZZ(3), QQ(3) / 2, QQ(9) / 4, ZZ(2), QQ(3) / 2),
    (QQ(1) / 32, ZZ(5), QQ(1) / 2, QQ(1) / 4, ZZ(2), QQ(1) / 2),
]

root_sequence_a = []
root_sequence_b = []

for A, N, a, B, M, b in examples:
    # 段 1: 正の有理数と正の自然数について交差べき等式を有限算術で判定する。
    assert A > 0 and B > 0 and N > 0 and M > 0
    assert A**M == B**N
    # 段 2: a,b が対象の正の乗根であることを有限べきで確認する。
    assert a > 0 and b > 0
    assert a**N == A
    assert b**M == B
    # 段 3: 既存の一箱の主張の結論に対応する乗根一致を確認する。
    assert a == b
    root_sequence_a.append(a)
    root_sequence_b.append(b)

# 段 4: 一箱ごとの結論を有限列へ束ねると項別一致になる。
assert len(root_sequence_a) == len(root_sequence_b)
assert all(a == b for a, b in zip(root_sequence_a, root_sequence_b))

# 段 5: 項別一致なら、任意の有理な候補値に対する差も各項で一致する。
# これは本文の収束移送で行う等式の書き換えの有限な検査である。
limit_candidate = QQ(1)
assert all(
    abs(a - limit_candidate) == abs(b - limit_candidate)
    for a, b in zip(root_sequence_a, root_sequence_b)
)

print("ALL PASS")
