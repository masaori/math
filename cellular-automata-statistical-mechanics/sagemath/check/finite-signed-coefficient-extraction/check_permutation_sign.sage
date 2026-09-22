# 対象ラベル: claim_finite_exterior_basis_permutation_top_sign
# 併せて検証: claim_finite_exterior_word_adjacent_swap_sign
# 式ペア: Top_I(m_I(w_pi)) = (-1)^inv(w_pi)、m_I(w') = -m_I(w)。
# 帰属: 有限全順序集合、有限置換、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

permutation_checks = ZZ(0)
adjacent_swap_checks = ZZ(0)
seen_signs = set()

for size in range(1, 7):
    index_set = tuple(ZZ(value) for value in range(size))
    for word in permutations(index_set):
        monomial = word_monomial(index_set, word)
        expected_sign = ZZ(-1) ** word_inversions(word)
        assert top_coefficient(index_set, monomial) == expected_sign
        assert expected_sign in (ZZ(-1), ZZ(1))
        seen_signs.add(expected_sign)
        permutation_checks += 1
        for position in range(size - 1):
            swapped = list(word)
            swapped[position], swapped[position + 1] = swapped[position + 1], swapped[position]
            assert word_monomial(index_set, tuple(swapped)) == scale_table(-1, monomial)
            adjacent_swap_checks += 1

assert permutation_checks == sum(factorial(size) for size in range(1, 7))
assert adjacent_swap_checks == sum((size - 1) * factorial(size) for size in range(1, 7))
assert seen_signs == {ZZ(-1), ZZ(1)}
print('basis permutations checked:', permutation_checks)
print('adjacent swaps checked:', adjacent_swap_checks)
print('integer signs observed:', sorted(seen_signs))
print('RESULT: PASS')
