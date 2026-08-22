# 対象ラベル: claim_cofinal_cross_power_equality_is_sufficient_for_limit_quantity
# 対象ラベル: claim_cofinal_equal_positive_real_sequences_share_limit
# 対象ラベル: remark_cofinal_agreement_does_not_give_existence
# 交差べき等式が「共終な添字」でだけ成り立つとき（成り立たない添字がいくらでも大きい
# ところに残っていてよい）、乗根列の一致する添字も共終になることを、正の有理数乗根を
# 持つ有限列で確認する。あわせて、共終な一致だけからは箱サイズ極限の存在が導けない
# ことを示す注意の反例を、有限の場合分けで確認する。
# 帰属: QQ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。共終性は「どの L1 を取っても L1 以上に成立する添字が
# 検査範囲内に見つかる」ことで検査するので、L1 の走査は L_MAX まで、証人の探索は
# L_TOP = L_MAX + 1 までとする（証人が範囲外へはみ出さないため）。
L_MAX = 12
L_TOP = L_MAX + 1

# 交差べき等式が成り立つ添字を奇数だけに取る（偶数の添字では成り立たないので、
# 「ある添字以降のすべて」では書けない。すなわち尾部版の仮定は満たさない）。
def is_agreement_index(L):
    return L % 2 == 1

# 各添字での (A, N, a, B, M, b) を作る。
# 奇数の添字: A = 8, N = 3, a = 2 / B = 4, M = 2, b = 2 で A^M = 8^2 = 64 = 4^3 = B^N。
# 偶数の添字: A = 8, N = 3, a = 2 / B = 9, M = 2, b = 3 で A^M = 64 != 729 = B^N。
def data_at(L):
    if is_agreement_index(L):
        return (QQ(8), ZZ(3), QQ(2), QQ(4), ZZ(2), QQ(2))
    return (QQ(8), ZZ(3), QQ(2), QQ(9), ZZ(2), QQ(3))

root_sequence_a = {}
root_sequence_b = {}
holds_cross_power = {}

for L in range(1, L_TOP + 1):
    A, N, a, B, M, b = data_at(L)
    assert A > 0 and B > 0 and N > 0 and M > 0
    assert a > 0 and b > 0
    # a, b は主張中の a(L) = A(L)^{1/N(L)}, b(L) = B(L)^{1/M(L)} に当たる乗根である。
    assert a**N == A
    assert b**M == B
    holds_cross_power[L] = (A**M == B**N)
    root_sequence_a[L] = a
    root_sequence_b[L] = b

# 段 1: 交差べき等式が成り立つ添字が共終であること
#（すべての L1 に対し、L >= L1 かつ成立する L が検査範囲内に取れる）。
for L1 in range(1, L_MAX + 1):
    witnesses = [L for L in range(L1, L_TOP + 1) if holds_cross_power[L]]
    assert len(witnesses) > 0

# 段 2: 尾部版の仮定は満たさないこと
#（どの L0 を取っても、L0 以降に交差べき等式が破れる添字が残る）。
for L0 in range(1, L_MAX + 1):
    failures = [L for L in range(L0, L_TOP + 1) if not holds_cross_power[L]]
    assert len(failures) > 0

# 段 3: 交差べき等式が成り立つ各添字で、claim_cross_power_equality_implies_root_equality
# の結論に当たる乗根一致 a(L) = b(L) を得る（一箱ごとの適用）。
for L in range(1, L_TOP + 1):
    if holds_cross_power[L]:
        assert root_sequence_a[L] == root_sequence_b[L]

# 段 4: したがって a と b が一致する添字も共終である
#（claim_cofinal_cross_power_equality_is_sufficient_for_limit_quantity の証明前半）。
for L1 in range(1, L_MAX + 1):
    witnesses = [
        L for L in range(L1, L_TOP + 1) if root_sequence_a[L] == root_sequence_b[L]
    ]
    assert len(witnesses) > 0

# 段 5: 共終な一致から極限値の一致を導く段が使う量の有限な検査。
# 証明は |l - l'| <= |a(L) - l| + |b(L) - l'| を共終な L で評価する。
# 一致する添字では a(L) = b(L) なので、任意の有理な候補値 l, l' について
# |l - l'| <= |a(L) - l| + |b(L) - l'| が実際に厳密に成り立つことを確かめる。
for l_candidate in [QQ(2), QQ(5) / 2, QQ(3)]:
    for l_prime_candidate in [QQ(2), QQ(5) / 2, QQ(3)]:
        for L in range(1, L_TOP + 1):
            if not (root_sequence_a[L] == root_sequence_b[L]):
                continue
            left = abs(l_candidate - l_prime_candidate)
            right = abs(root_sequence_a[L] - l_candidate) + abs(
                root_sequence_b[L] - l_prime_candidate
            )
            assert left <= right

# 段 6: 一致する添字では、二つの候補値の差が各項での差の和で押さえられるだけでなく、
# 候補値が等しいときにその和が 0 になりうること（等号が達成される場合）を確認する。
# これは l = l' = a(L) = b(L) のときであり、証明の矛盾の取り方が空でないことを示す。
L_witness = min(L for L in range(1, L_TOP + 1) if holds_cross_power[L])
l_exact = root_sequence_a[L_witness]
assert abs(l_exact - l_exact) == QQ(0)
assert (
    abs(root_sequence_a[L_witness] - l_exact)
    + abs(root_sequence_b[L_witness] - l_exact)
    == QQ(0)
)

# 段 7: 注意 remark_cofinal_agreement_does_not_give_existence の反例。
# a(L) = 1、b(L) は奇数で 1・偶数で 2。一致する添字（奇数）は共終だが、
# b は箱サイズ極限を持たない。非存在は「どの候補値 l' と N を取っても、
# N 以上の奇数と N 以上の偶数の両方で |b(L) - l'| < 1/2 にはできない」ことで検査する。
a_flat = {L: QQ(1) for L in range(1, L_TOP + 1)}
b_alternating = {L: (QQ(1) if L % 2 == 1 else QQ(2)) for L in range(1, L_TOP + 1)}

for L1 in range(1, L_MAX + 1):
    witnesses = [L for L in range(L1, L_TOP + 1) if a_flat[L] == b_alternating[L]]
    assert len(witnesses) > 0

epsilon = QQ(1) / 2
for numerator in range(0, 25):
    l_prime_candidate = QQ(numerator) / 8
    for N in range(1, L_MAX + 1):
        odd_indices = [L for L in range(N, L_TOP + 1) if L % 2 == 1]
        even_indices = [L for L in range(N, L_TOP + 1) if L % 2 == 0]
        assert len(odd_indices) > 0 and len(even_indices) > 0
        close_on_odd = all(
            abs(b_alternating[L] - l_prime_candidate) < epsilon for L in odd_indices
        )
        close_on_even = all(
            abs(b_alternating[L] - l_prime_candidate) < epsilon for L in even_indices
        )
        assert not (close_on_odd and close_on_even)

print("ALL PASS")
