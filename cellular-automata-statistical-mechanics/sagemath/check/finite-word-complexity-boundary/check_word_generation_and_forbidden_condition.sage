# 対象ラベル: def_finite_two_symbol_word_set
# 併せて検証: def_forbidden_one_run_word_family
# 有限二元語の生成と、指定長の連続した一を禁じる有限条件の一致を検査する。
# 帰属: 有限集合、ZZ。浮動小数点、対数、極限、R/C 脱出はない。
from itertools import product


def binary_words(length):
    return tuple(product((ZZ(0), ZZ(1)), repeat=length))


def satisfies_definition(word, cutoff):
    length = len(word)
    return all(
        any(word[index + offset] == 0 for offset in range(cutoff + 1))
        for index in range(length)
        if index + cutoff < length
    )


def has_no_forbidden_run(word, cutoff):
    forbidden_length = cutoff + 1
    return all(
        tuple(word[index:index + forbidden_length]) != (ZZ(1),) * forbidden_length
        for index in range(len(word) - forbidden_length + 1)
    )


word_count = ZZ(0)
predicate_comparison_count = ZZ(0)
for cutoff in range(1, 9):
    for length in range(1, 10):
        words = binary_words(length)
        assert len(words) == ZZ(2) ** length
        assert len(set(words)) == len(words)
        word_count += len(words)
        for word in words:
            assert satisfies_definition(word, cutoff) == has_no_forbidden_run(word, cutoff)
            predicate_comparison_count += 1

assert word_count == ZZ(8176)
assert predicate_comparison_count == word_count
print('finite binary words generated:', word_count)
print('forbidden-condition comparisons:', predicate_comparison_count)
print('RESULT: PASS')
