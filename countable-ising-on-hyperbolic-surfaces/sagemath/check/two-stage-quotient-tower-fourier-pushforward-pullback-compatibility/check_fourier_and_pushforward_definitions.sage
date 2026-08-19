# SageMath: 粗段 Fourier 成分を押し出しファイバーの二重和へ展開する
# 対象ラベル: theorem_quotient_tower_fourier_pushforward_pullback_compatibility
# 帰属: F_2、Z、ZZ[u,v] と有限集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for psi in coarse_characters:
    left = fourier_component(
        H_coarse,
        pushed_family,
        lambda k: character(psi, k),
    )
    right = sum(
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
    assert left == right

print("RESULT: PASS — the coarse Fourier component expands to the pushforward-fiber double sum")
