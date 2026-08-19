# SageMath: 商の塔における整数符号文字評価と引き戻しの整合性を厳密検算
# 対象ラベル: theorem_quotient_tower_integer_sign_character_evaluation_pullback_compatibility
# 帰属: 有限第一ホモロジー群、有限文字空間、F_2、Z だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-f2-character-pullback-map/_prelude.sage",
))


def integer_sign(field_value):
    assert field_value in F2
    if field_value == F2.zero():
        return ZZ.one()
    assert field_value == F2.one()
    return -ZZ.one()


checked_equalities = 0
for coarse_character in coarse_characters:
    pulled_character = pullback_character(coarse_character)
    for fine_class in fine_first_homology:
        coarse_image = first_homology_pushforward(fine_class)
        coarse_field_value = coarse_character[coarse_image]
        pulled_field_value = pulled_character[fine_class]

        assert pulled_field_value == coarse_field_value
        assert integer_sign(coarse_field_value) == integer_sign(pulled_field_value)
        assert integer_sign(coarse_character[coarse_image]) == integer_sign(
            pullback_character(coarse_character)[fine_class]
        )
        checked_equalities += 1

print(
    "RESULT: PASS — integer sign evaluation after homology pushforward equals "
    "integer sign evaluation after character pullback for every coarse character "
    f"and fine homology class ({checked_equalities} equalities)"
)
