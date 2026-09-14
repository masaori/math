# 対象ラベル: claim_finite_word_counts_do_not_determine_next_length
# 長さ K+1 では全一語だけが除かれ、二語族の個数が一だけ分かれることを検査する。
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
shared_table_entry_count = ZZ(0)
next_length_word_count = ZZ(0)
for cutoff in range(1, 13):
    for length in range(1, cutoff + 1):
        assert len(allowed_words(cutoff, length)) == len(binary_words(length))
        shared_table_entry_count += 1

    next_length = cutoff + 1
    words = binary_words(next_length)
    allowed = allowed_words(cutoff, next_length)
    excluded = set(words).difference(allowed)
    all_one_word = (ZZ(1),) * next_length
    assert excluded == {all_one_word}
    assert len(words) == ZZ(2) ** next_length
    assert len(allowed) == ZZ(2) ** next_length - 1
    assert len(words) - len(allowed) == 1
    cutoff_count += 1
    next_length_word_count += len(words)

assert cutoff_count == ZZ(12)
assert shared_table_entry_count == ZZ(78)
assert next_length_word_count == ZZ(16380)
print('positive cutoffs checked:', cutoff_count)
print('shared finite count-table entries checked:', shared_table_entry_count)
print('next-length finite words checked:', next_length_word_count)
print('RESULT: PASS')
