# SageMath: F_2 値文字から整数値の符号文字への写像を厳密検算
# 対象ラベル: def_integer_sign_character_realization
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_integer_sign_character_realization
# 帰属: 有限集合、GF(2)、ZZ。浮動小数点、実数、複素数を使用しない

F2 = GF(2)


def integer_sign(field_value):
    if field_value == F2.zero():
        return ZZ.one()
    if field_value == F2.one():
        return -ZZ.one()
    raise AssertionError("GF(2) has no other value")


for dimension in range(5):
    homology_space = VectorSpace(F2, dimension)
    homology_classes = list(homology_space)

    for coefficient_vector in homology_space:
        def f2_character(homology_class):
            return coefficient_vector.dot_product(homology_class)

        sign_character = {
            tuple(homology_class): integer_sign(f2_character(homology_class))
            for homology_class in homology_classes
        }

        assert set(sign_character.values()).issubset({ZZ.one(), -ZZ.one()})
        for homology_class in homology_classes:
            field_value = f2_character(homology_class)
            expected = ZZ.one() if field_value == F2.zero() else -ZZ.one()
            assert sign_character[tuple(homology_class)] == expected

print("RESULT: PASS — every F_2-valued character in dimensions 0 through 4 maps pointwise to the stated integer sign")
