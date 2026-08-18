# SageMath: 商の塔が誘導する F_2 値文字の引き戻し写像の共通有限データ
# 対象ラベル: def_quotient_tower_f2_character_pullback_map
# 帰属: 有限第一ホモロジー群、有限文字空間、F_2 だけを用いる。

import os
from itertools import product

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-homology-pushforward-additivity-over-f2/_prelude.sage",
))


def homology_zero(boundary_space):
    zero = tuple(F2.zero() for _ in next(iter(boundary_space)))
    return boundary_coset(zero, boundary_space)


def enumerate_linear_characters(homology_space, boundary_space):
    classes = tuple(homology_space)
    zero_class = homology_zero(boundary_space)
    characters = []
    for values in product(F2, repeat=len(classes)):
        character = dict(zip(classes, values))
        if character[zero_class] != F2.zero():
            continue
        if all(
            character[homology_class_sum(left, right, boundary_space)]
            == character[left] + character[right]
            for left in classes
            for right in classes
        ):
            characters.append(character)
    return tuple(characters)


fine_characters = enumerate_linear_characters(
    fine_first_homology,
    fine_face_boundaries,
)
coarse_characters = enumerate_linear_characters(
    coarse_first_homology,
    coarse_face_boundaries,
)


def pullback_character(coarse_character):
    return {
        fine_class: coarse_character[first_homology_pushforward(fine_class)]
        for fine_class in fine_first_homology
    }
