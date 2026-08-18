# SageMath: 第一ホモロジー押し出し写像の加法性を一行ずつ検算する
# 対象ラベル: theorem_quotient_tower_first_homology_pushforward_additivity_over_f2

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_cycle_pairs = 0
checked_edge_components = 0
for left_cycle in fine_cycle_tuples:
    for right_cycle in fine_cycle_tuples:
        cycle_sum = add_edge_coefficient_tuples(left_cycle, right_cycle)
        pushed_sum = pushforward_cycle_tuple(cycle_sum)
        sum_of_pushforwards = add_edge_coefficient_tuples(
            pushforward_cycle_tuple(left_cycle),
            pushforward_cycle_tuple(right_cycle),
        )
        for cell_index, _ in enumerate(coarse_edge_cells):
            assert pushed_sum[cell_index] == sum_of_pushforwards[cell_index]
            checked_edge_components += 1
        checked_cycle_pairs += 1

checked_class_pairs = 0
for left_class in fine_first_homology:
    for right_class in fine_first_homology:
        fine_sum = homology_class_sum(
            left_class,
            right_class,
            fine_face_boundaries,
        )
        image_of_sum = first_homology_pushforward(fine_sum)

        left_image = first_homology_pushforward(left_class)
        right_image = first_homology_pushforward(right_class)
        sum_of_images = homology_class_sum(
            left_image,
            right_image,
            coarse_face_boundaries,
        )

        assert image_of_sum == sum_of_images
        checked_class_pairs += 1

print(
    "RESULT: PASS — edge-coefficient pushforward and induced first-homology "
    "pushforward preserve addition "
    f"({checked_cycle_pairs} cycle pairs, {checked_edge_components} coarse-edge "
    f"components, {checked_class_pairs} homology-class pairs checked)"
)
