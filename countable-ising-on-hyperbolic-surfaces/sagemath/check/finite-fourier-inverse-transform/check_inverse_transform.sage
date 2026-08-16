# SageMath: 有限第一ホモロジー群上の Fourier 逆変換を厳密検算
# 対象ラベル: theorem_finite_fourier_inverse_transform
# 対象: finite-fourier-duality.ts のブロック finite_fourier_theorem_inverse_transform
# 帰属: 有限集合、GF(2)、ZZ、QQ 上の多項式環。浮動小数点、実数、複素数を使用しない

F2 = GF(2)


def integer_sign(field_value):
    if field_value == F2.zero():
        return ZZ.one()
    if field_value == F2.one():
        return -ZZ.one()
    raise AssertionError("GF(2) has no other value")


checked_classes = 0
checked_transform_entries = 0

for dimension in range(5):
    homology_space = VectorSpace(F2, dimension)
    homology_classes = list(homology_space)
    character_coefficients = list(homology_space)
    coefficient_ring = PolynomialRing(
        QQ,
        names=[f"A_{index}" for index in range(len(homology_classes))],
    )
    input_polynomials = list(coefficient_ring.gens())

    def character_value(coefficient_vector, homology_class):
        return coefficient_vector.dot_product(homology_class)

    transformed_polynomials = []
    for character_coefficient in character_coefficients:
        transformed_polynomial = sum(
            integer_sign(character_value(character_coefficient, homology_class))
            * input_polynomials[class_index]
            for class_index, homology_class in enumerate(homology_classes)
        )
        transformed_polynomials.append(transformed_polynomial)
        checked_transform_entries += 1

    character_count = QQ(len(character_coefficients))
    assert character_count > QQ.zero()

    for target_index, target_class in enumerate(homology_classes):
        inverse_sum = sum(
            integer_sign(character_value(character_coefficient, target_class))
            * transformed_polynomials[character_index]
            for character_index, character_coefficient in enumerate(character_coefficients)
        )
        expanded_by_class = sum(
            sum(
                integer_sign(character_value(character_coefficient, target_class))
                * integer_sign(character_value(character_coefficient, source_class))
                for character_coefficient in character_coefficients
            )
            * input_polynomials[source_index]
            for source_index, source_class in enumerate(homology_classes)
        )
        orthogonality_reduction = character_count * input_polynomials[target_index]

        assert inverse_sum == expanded_by_class
        assert expanded_by_class == orthogonality_reduction
        assert inverse_sum / character_count == input_polynomials[target_index]
        checked_classes += 1

assert checked_classes == sum(2^dimension for dimension in range(5))
assert checked_transform_entries == sum(2^dimension for dimension in range(5))

print(
    "RESULT: PASS — finite Fourier inversion holds symbolically for all "
    f"{checked_classes} homology classes in dimensions 0 through 4"
)
