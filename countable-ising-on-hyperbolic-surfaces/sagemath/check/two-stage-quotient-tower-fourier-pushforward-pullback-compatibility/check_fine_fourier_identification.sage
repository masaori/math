# SageMath: 引き戻し文字による細段和を細段 Fourier 成分として同定する
# 対象ラベル: theorem_quotient_tower_fourier_pushforward_pullback_compatibility
# 帰属: F_2、Z、ZZ[u,v] と有限集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for psi in coarse_characters:
    left = sum(
        (
            integer_sign(character_pullback(psi, h)) * fine_family[h]
            for h in H_fine
        ),
        R.zero(),
    )
    right = fourier_component(
        H_fine,
        fine_family,
        lambda h: character_pullback(psi, h),
    )
    assert left == right

print("RESULT: PASS — the pulled-character sum is exactly the fine Fourier component")
