# SageMath: 押し出し像での粗段符号を引き戻し文字の細段符号へ置換する
# 対象ラベル: theorem_quotient_tower_fourier_pushforward_pullback_compatibility
# 帰属: F_2、Z、ZZ[u,v] と有限集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for psi in coarse_characters:
    left = sum(
        (
            integer_sign(character(psi, homology_pushforward(h))) * fine_family[h]
            for h in H_fine
        ),
        R.zero(),
    )
    right = sum(
        (
            integer_sign(character_pullback(psi, h)) * fine_family[h]
            for h in H_fine
        ),
        R.zero(),
    )
    assert left == right

print("RESULT: PASS — integer sign evaluation agrees after homology pushforward and character pullback")
