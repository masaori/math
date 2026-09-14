# 対象ラベル: claim_forbidden_one_run_words_full_below_cutoff
# 禁制長以下では禁制条件が空な全称量化となり、全二元語が許されることを検査する。
# 帰属: 有限集合、ZZ。浮動小数点、対数、極限、R/C 脱出はない。
from itertools import product


def binary_words(length):
    return tuple(product((ZZ(0), ZZ(1)), repeat=length))


def allowed_words(cutoff, length):
    return tuple(
        word
        for word in binary_words(length)
        if all(
            any(word[index + offset] == 0 for offset in range(cutoff + 1))
            for index in range(length)
            if index + cutoff < length
        )
    )


cutoff_count = ZZ(0)
length_count = ZZ(0)
word_count = ZZ(0)
for cutoff in range(1, 13):
    cutoff_count += 1
    for length in range(1, cutoff + 1):
        words = binary_words(length)
        allowed = allowed_words(cutoff, length)
        assert allowed == words
        assert len(allowed) == ZZ(2) ** length
        length_count += 1
        word_count += len(words)

assert cutoff_count == ZZ(12)
assert length_count == ZZ(78)
assert word_count == ZZ(16356)
print('positive cutoffs checked:', cutoff_count)
print('lengths at or below cutoff checked:', length_count)
print('allowed finite words checked:', word_count)
print('RESULT: PASS')
