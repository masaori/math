# SageMath: 第一ホモロジー押し出し写像の加法性の共通有限データ
# 対象ラベル: theorem_quotient_tower_first_homology_pushforward_additivity_over_f2
# 帰属: 有限剰余類セル集合と F_2 上の有限商集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-homology-pushforward-map-over-f2/_prelude.sage",
))


def homology_class_sum(left_class, right_class, boundary_space):
    left_representative = next(iter(left_class))
    right_representative = next(iter(right_class))
    return boundary_coset(
        add_edge_coefficient_tuples(left_representative, right_representative),
        boundary_space,
    )
