# SageMath: 押し出しファイバーの二重和を細段類の一重和へ添字付け替えする
# 対象ラベル: theorem_quotient_tower_fourier_pushforward_pullback_compatibility
# 帰属: F_2、Z、ZZ[u,v] と有限集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for psi in coarse_characters:
    left = sum(
        (
            integer_sign(character(psi, k))
            * sum(
                (fine_family[h] for h in H_fine if homology_pushforward(h) == k),
                R.zero(),
            )
            for k in H_coarse
        ),
        R.zero(),
    )
    right = sum(
        (
            integer_sign(character(psi, homology_pushforward(h))) * fine_family[h]
            for h in H_fine
        ),
        R.zero(),
    )
    assert left == right

print("RESULT: PASS — the finite fibers partition the fine homology classes and reindex the sum exactly")
