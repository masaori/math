# 対象ラベル: claim_tail_cross_power_equality_is_sufficient_for_limit_quantity
# 交差べき等式がある添字 L0 以降だけで成り立つとき、L0 未満での不一致を許したまま
# L0 以降の乗根列の項別一致が得られることを、正の有理数乗根を持つ有限列で確認する。
# 帰属: QQ と有限列だけを使う。実数の極限、浮動小数点、実対数は使わない。

# L0 = 2（添字 1 では交差べき等式を仮定しない・実際に成り立たない例を混ぜる）。
L0 = 2

# 各項は (L, A, N, a, B, M, b, holds_cross_power) の形。
# holds_cross_power は「この添字で交差べき等式 A^M = B^N が成り立つか」を記録する
# （L < L0 では成り立たない項を意図的に混ぜて、L0 未満の成立を仮定しないことを示す）。
examples = [
    (1, QQ(2), ZZ(1), QQ(2), QQ(3), ZZ(1), QQ(3)),  # L=1 < L0: 交差べき等式は成り立たず a != b
    (2, QQ(8), ZZ(3), QQ(2), QQ(4), ZZ(2), QQ(2)),
    (3, QQ(27) / 8, ZZ(3), QQ(3) / 2, QQ(9) / 4, ZZ(2), QQ(3) / 2),
    (4, QQ(1) / 32, ZZ(5), QQ(1) / 2, QQ(1) / 4, ZZ(2), QQ(1) / 2),
]

root_sequence_a = []
root_sequence_b = []
holds_at = {}

for L, A, N, a, B, M, b in examples:
    assert A > 0 and B > 0 and N > 0 and M > 0
    assert a > 0 and b > 0
    # a, b は主張中の a(L)=A(L)^{1/N(L)}, b(L)=B(L)^{1/M(L)} に当たる乗根であることを確認する。
    assert a**N == A
    assert b**M == B
    holds_at[L] = (A**M == B**N)
    root_sequence_a.append((L, a))
    root_sequence_b.append((L, b))

# 段 1: L0 未満では交差べき等式を仮定していないことを確認する
#（実際に L=1 では成り立たず、対応する乗根も一致しない）。
assert not holds_at[1]
a1 = dict(root_sequence_a)[1]
b1 = dict(root_sequence_b)[1]
assert a1 != b1

# 段 2: L >= L0 のすべての添字で交差べき等式が成り立つことを確認する
#（claim_cross_power_equality_implies_root_equality を適用できる仮定）。
for L in range(L0, 5):
    assert holds_at[L]

# 段 3: L >= L0 の各添字で、claim_cross_power_equality_implies_root_equality の結論
# に当たる乗根一致 a(L) = b(L) を得る（一箱ごとの適用）。
for L, a in root_sequence_a:
    if L < L0:
        continue
    b = dict(root_sequence_b)[L]
    assert a == b

# 段 4: L >= L0 の項だけを束ねると項別一致になる
#（claim_tail_cross_power_equality_is_sufficient_for_limit_quantity の証明前半）。
tail_a = [a for L, a in root_sequence_a if L >= L0]
tail_b = [b for L, b in root_sequence_b if L >= L0]
assert len(tail_a) == len(tail_b)
assert all(a == b for a, b in zip(tail_a, tail_b))

# 段 5: L0 以降の項別一致があれば、任意の有理な候補値との差も L0 以降の各項で一致する
#（claim_tail_equal_positive_real_sequences_transfer_limit の証明が行う等式の書き換えの
# 有限な検査。L0 未満の項はこの差の比較に使わない）。
limit_candidate = QQ(1)
assert all(
    abs(a - limit_candidate) == abs(b - limit_candidate)
    for a, b in zip(tail_a, tail_b)
)

print("ALL PASS")
