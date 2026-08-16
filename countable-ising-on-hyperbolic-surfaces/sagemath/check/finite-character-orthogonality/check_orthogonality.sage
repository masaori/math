# SageMath: 有限第一ホモロジー群上の文字直交関係を厳密検算
# 対象ラベル: theorem_finite_character_orthogonality
# 対象: finite-fourier-duality.ts のブロック finite_fourier_theorem_character_orthogonality
# 帰属: 有限集合、GF(2)、ZZ。浮動小数点、実数、複素数を使用しない

F2 = GF(2)


def integer_sign(field_value):
    if field_value == F2.zero():
        return ZZ.one()
    if field_value == F2.one():
        return -ZZ.one()
    raise AssertionError("GF(2) has no other value")


checked_pairs = 0
checked_nonzero_pairings = 0

for dimension in range(5):
    homology_space = VectorSpace(F2, dimension)
    homology_classes = list(homology_space)
    character_coefficients = list(homology_space)

    def character_value(coefficient_vector, homology_class):
        return coefficient_vector.dot_product(homology_class)

    for first_class in homology_classes:
        for second_class in homology_classes:
            difference_class = first_class + second_class

            product_sum = sum(
                integer_sign(character_value(coefficient_vector, first_class))
                * integer_sign(character_value(coefficient_vector, second_class))
                for coefficient_vector in character_coefficients
            )
            shifted_sum = sum(
                integer_sign(character_value(coefficient_vector, difference_class))
                for coefficient_vector in character_coefficients
            )

            assert product_sum == shifted_sum

            if first_class == second_class:
                assert difference_class == homology_space.zero()
                assert product_sum == ZZ(len(character_coefficients))
            else:
                assert difference_class != homology_space.zero()
                flipping_coefficients = [
                    coefficient_vector
                    for coefficient_vector in character_coefficients
                    if character_value(coefficient_vector, difference_class) == F2.one()
                ]
                assert flipping_coefficients
                flipping_character = flipping_coefficients[0]

                for coefficient_vector in character_coefficients:
                    paired_coefficient = coefficient_vector + flipping_character
                    assert paired_coefficient + flipping_character == coefficient_vector
                    assert integer_sign(
                        character_value(paired_coefficient, difference_class)
                    ) == -integer_sign(
                        character_value(coefficient_vector, difference_class)
                    )

                assert product_sum == ZZ.zero()
                checked_nonzero_pairings += 1

            checked_pairs += 1

assert checked_pairs == sum(2^dimension * 2^dimension for dimension in range(5))
assert checked_nonzero_pairings == sum(
    2^dimension * (2^dimension - 1) for dimension in range(5)
)

print(
    "RESULT: PASS — finite character orthogonality holds for all "
    f"{checked_pairs} homology-class pairs in dimensions 0 through 4"
)
