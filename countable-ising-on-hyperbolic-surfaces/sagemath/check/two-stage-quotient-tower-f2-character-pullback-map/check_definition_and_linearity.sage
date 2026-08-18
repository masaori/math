# SageMath: F_2 値文字の引き戻しの作用と線形性を厳密検算する
# 対象ラベル: def_quotient_tower_f2_character_pullback_map

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_actions = 0
checked_linear_combinations = 0
fine_classes = tuple(fine_first_homology)

for coarse_character in coarse_characters:
    pulled_character = pullback_character(coarse_character)
    assert pulled_character in fine_characters

    for fine_class in fine_classes:
        assert pulled_character[fine_class] == coarse_character[
            first_homology_pushforward(fine_class)
        ]
        checked_actions += 1

    for left_class in fine_classes:
        for right_class in fine_classes:
            for left_scalar in F2:
                for right_scalar in F2:
                    scaled_left = left_class if left_scalar == F2.one() else homology_zero(
                        fine_face_boundaries
                    )
                    scaled_right = right_class if right_scalar == F2.one() else homology_zero(
                        fine_face_boundaries
                    )
                    combined_class = homology_class_sum(
                        scaled_left,
                        scaled_right,
                        fine_face_boundaries,
                    )
                    assert pulled_character[combined_class] == (
                        left_scalar * pulled_character[left_class]
                        + right_scalar * pulled_character[right_class]
                    )
                    checked_linear_combinations += 1

print(
    "RESULT: PASS — every coarse F_2-valued character pulls back to a fine "
    "F_2-valued linear character with the stated composite action "
    f"({len(coarse_characters)} coarse characters, {checked_actions} actions, "
    f"{checked_linear_combinations} linear combinations checked)"
)
