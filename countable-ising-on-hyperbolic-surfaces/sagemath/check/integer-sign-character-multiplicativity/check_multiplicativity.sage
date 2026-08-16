# SageMath: 整数符号実現が F_2 加法を整数乗法へ送ることを厳密検算
# 対象ラベル: claim_integer_sign_character_multiplicativity
# 対象: finite-fourier-duality.ts のブロック finite_fourier_claim_integer_sign_character_multiplicativity
# 帰属: 有限集合、GF(2)、ZZ。浮動小数点、実数、複素数を使用しない

F2 = GF(2)


def integer_sign(field_value):
    if field_value == F2.zero():
        return ZZ.one()
    if field_value == F2.one():
        return -ZZ.one()
    raise AssertionError("GF(2) has no other value")


checked_equalities = 0

for dimension in range(5):
    homology_space = VectorSpace(F2, dimension)
    homology_classes = list(homology_space)

    for coefficient_vector in homology_space:
        def f2_character(homology_class):
            return coefficient_vector.dot_product(homology_class)

        for first_class in homology_classes:
            for second_class in homology_classes:
                first_value = f2_character(first_class)
                second_value = f2_character(second_class)
                sum_value = f2_character(first_class + second_class)

                assert sum_value == first_value + second_value
                assert integer_sign(sum_value) == (
                    integer_sign(first_value) * integer_sign(second_value)
                )
                assert integer_sign(f2_character(first_class + second_class)) == (
                    integer_sign(f2_character(first_class))
                    * integer_sign(f2_character(second_class))
                )
                checked_equalities += 1

assert checked_equalities == sum(2^dimension * 2^dimension * 2^dimension for dimension in range(5))

print(
    "RESULT: PASS — integer sign realizations send addition to multiplication "
    f"for all {checked_equalities} character-and-class pairs in dimensions 0 through 4"
)
