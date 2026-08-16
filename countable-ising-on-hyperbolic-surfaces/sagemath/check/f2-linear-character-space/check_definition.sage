# SageMath: 有限 F_2 ベクトル空間の F_2 値文字空間の定義を厳密検算
# 対象ラベル: def_f2_linear_character_space
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_f2_linear_character_space
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

F2 = GF(2)

for dimension in range(5):
    homology_space = VectorSpace(F2, dimension)
    homology_classes = list(homology_space)
    characters = []

    for coefficient_vector in homology_space:
        def character(homology_class):
            return coefficient_vector.dot_product(homology_class)

        for first_scalar in F2:
            for second_scalar in F2:
                for first_class in homology_classes:
                    for second_class in homology_classes:
                        assert character(
                            first_scalar * first_class + second_scalar * second_class
                        ) == (
                            first_scalar * character(first_class)
                            + second_scalar * character(second_class)
                        )

        characters.append(tuple(character(value) for value in homology_classes))

    assert len(set(characters)) == 2^dimension
    assert all(
        character[homology_classes.index(homology_space.zero())] == F2.zero()
        for character in characters
    )

print("RESULT: PASS — the F_2-valued character space is finite and every enumerated character is linear in dimensions 0 through 4")
