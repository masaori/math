# <def_partition_function_2d_ising>: 定義から従う対称性と、周期境界条件が実際に効いていること
#
# check_01 が扱っていない 3 点だけを検査する。
#   (a) 全スピン反転 s ↦ -s で指数の肩が不変（したがって Z は偶数個の等しい項の和）。
#   (d) 周期境界条件を外した「自由境界」版を別に計算し、Z と**一致しない**ことを見る。
#       一致してしまうなら他の対称性チェックはどんな境界条件でも通ってしまい、
#       「周期境界の定義を検査している」ことにならない（否定コントロール）。
#   (e) 行方向・列方向の巡回シフトで Z が不変（周期境界条件の直接の帰結）。
#
# 転置対称性 Z_{M,N}(J,J') = Z_{N,M}(J',J) と J=J'=0 での Z = 2^{MN} は
# check_01_definition_sanity.sage（独立経路 2 および冒頭のループ）が既に検査しているので、
# ここでは重複させない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
load(os.path.join(_dir, "_prelude.sage"))

rep = CheckReport("def_partition_function_2d_ising: 対称性と周期境界条件")

# _prelude.sage の Z_bruteforce(J, Jp, M, N) と同じ規約（J が第1引数方向・周期 M、
# Jp が第2引数方向・周期 N）で、指数の肩だけを取り出したもの。
def energy_of_config(s, J, Jp, M, N):
    """def_partition_function_2d_ising の指数の肩。s は M×N の 2 重リスト（0-origin）。"""
    e = 0.0
    for i in range(M):
        for j in range(N):
            e += J * s[i][j] * s[(i + 1) % M][j]
            e += Jp * s[i][j] * s[i][(j + 1) % N]
    return e


def Z_free_boundary(J, Jp, M, N):
    """周期境界条件を課さない（i+1 > M, j+1 > N の項を落とす）版。比較対照。"""
    total = 0.0
    for bits in itertools.product([-1, 1], repeat=M * N):
        s = [[bits[i * N + j] for j in range(N)] for i in range(M)]
        e = 0.0
        for i in range(M):
            for j in range(N):
                if i + 1 < M:
                    e += J * s[i][j] * s[i + 1][j]
                if j + 1 < N:
                    e += Jp * s[i][j] * s[i][j + 1]
        total += float(np.exp(e))
    return total


def Z_shifted(J, Jp, M, N, di, dj):
    """スピン配位を (di, dj) だけ巡回シフトしてから足し上げる（値は Z と同じはず）。"""
    total = 0.0
    for bits in itertools.product([-1, 1], repeat=M * N):
        s0 = [[bits[i * N + j] for j in range(N)] for i in range(M)]
        s = [[s0[(i + di) % M][(j + dj) % N] for j in range(N)] for i in range(M)]
        total += float(np.exp(energy_of_config(s, J, Jp, M, N)))
    return total


# J ≠ J' を必ず含める。高温側・低温側・臨界点近傍（sinh 2J sinh 2J' = 1）を混ぜる。
JJ_PAIRS = [(0.3, 0.7), (0.7, 0.3), (0.1, 1.3), (0.4406868, 0.4406868)]

for (M, N) in [(2, 2), (2, 3), (3, 2), (3, 3), (2, 4), (4, 2), (3, 4)]:
    for (J, Jp) in JJ_PAIRS:
        Zv = Z_bruteforce(J, Jp, M, N)

        # (a) 全スピン反転で指数の肩が不変。全 2^{MN} 配位について確かめる。
        worst = 0.0
        for bits in itertools.product([-1, 1], repeat=M * N):
            s = [[bits[i * N + j] for j in range(N)] for i in range(M)]
            sflip = [[-x for x in row] for row in s]
            worst = max(worst, abs(energy_of_config(s, J, Jp, M, N)
                                   - energy_of_config(sflip, J, Jp, M, N)))
        rep.close(worst, 0.0,
                  f"(a) M={M} N={N} J={J} Jp={Jp}: 全 2^(MN) 配位で全反転により指数の肩が不変")

        # (e) 巡回シフト不変性
        rep.close(Zv, Z_shifted(J, Jp, M, N, 1, 0), f"(e) M={M} N={N}: 行方向シフト不変")
        rep.close(Zv, Z_shifted(J, Jp, M, N, 0, 1), f"(e) M={M} N={N}: 列方向シフト不変")

    # (d) 自由境界版とは一致しないこと（周期境界条件が効いている）
    Zp = Z_bruteforce(0.3, 0.7, M, N)
    Zf = Z_free_boundary(0.3, 0.7, M, N)
    rep.truth(abs(Zp - Zf) / Zp > 1e-3, f"(d) M={M} N={N}: 周期境界と自由境界で値が異なる")
    print("  M=%d N=%d : Z(周期)=%.6e  Z(自由境界)=%.6e  相対差=%.3f"
          % (M, N, Zp, Zf, abs(Zp - Zf) / Zp))

rep.finish()
