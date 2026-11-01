# 対象ラベル: sqrt_squared_is_original の検算の準備（共通の定義は sagemath/_shared/polar_trigonometry_exact.sage）
load("../../_shared/polar_trigonometry_exact.sage")

# 複素数 z を座標で直接与え、φ_polar(z) の代表元の候補 (r, θ) と組にする。
s3, s2, s6 = AA(3).sqrt(), AA(2).sqrt(), AA(6).sqrt()
SAMPLE_Z = [
    ((AA(0), AA(0)), (AA(0), Ang(0))),
    ((AA(1), AA(0)), (AA(1), Ang(0))),
    ((AA(-2), AA(0)), (AA(2), pi_)),
    ((AA(0), AA(3)), (AA(3), pi_ / 2)),
    ((AA(0), -AA(1) / 2), (AA(1) / 2, -pi_ / 2)),
    ((AA(1), AA(1)), (s2, pi_ / 4)),
    ((-s3, AA(1)), (AA(2), 5 * pi_ / 6)),
    ((AA(-1), AA(-1)), (s2, -3 * pi_ / 4)),
    ((5 * s3, AA(-5)), (AA(10), -pi_ / 6)),
    ((AA(1) / 2, s3 / 2), (AA(1), pi_ / 3)),
    ((-AA(7) / 2, -7 * s3 / 2), (AA(7), -2 * pi_ / 3)),
    (((s6 + s2) / 4, (s6 - s2) / 4), (AA(1), pi_ / 12)),
]

def reps_of(p):
    """p と同値な代表元をいくつか（p 自身を含む）。半径零なら角度を任意に替え、正なら 2kπ を足す。"""
    rr, t = p
    if rr == 0:
        return [(rr, Ang(0)), (rr, 7 * pi_ / 5), (rr, -3 * pi_)]
    return [(rr, t + 2 * k * pi_) for k in (-2, 0, 1, 3)]
