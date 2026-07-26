# 250-02: Z の定義から従うはずの対称性と、周期境界条件が実際に効いていることの確認
#
# (a) 全スピン反転 s ↦ -s で被加数が不変（したがって Z は偶数個の等しい項の和）。
# (b) 格子の転置 (i,j) ↦ (j,i) は 𝔖_{M,N} → 𝔖_{N,M} の全単射で J と J' を入れ替えるので
#     Z_{M,N}(J,J') = Z_{N,M}(J',J)。M ≠ N で確かめる（M = N なら Z(J,J') = Z(J',J)）。
# (c) J = J' = 0 のとき Z = 2^{MN}（被加数がすべて 1）。
# (d) 周期境界条件を外した「自由境界」版を別に計算し、Z と**一致しない**ことを見る。
#     一致してしまうなら (a)-(c) はどんな境界条件でも通ってしまい、check として無意味である。
# (e) 行方向・列方向の巡回シフトで Z が不変（周期境界条件の直接の帰結）。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '../252_partition_function_via_transfer_matrix/_prelude.sage'))

import itertools
import numpy as np

rep = CheckReport("def_partition_function_2d_ising: 対称性と周期境界条件")


def Z_free_boundary(M, N, J, Jp):
    """周期境界条件を課さない（i+1 > M, j+1 > N の項を落とす）版。比較対照。"""
    M = int(M); N = int(N)
    tot = 0.0
    for flat in itertools.product((-1, 1), repeat=M * N):
        s = [[flat[i * N + j] for j in range(N)] for i in range(M)]
        e = 0.0
        for i in range(M):
            for j in range(N):
                if i + 1 < M:
                    e += J * s[i][j] * s[i + 1][j]
                if j + 1 < N:
                    e += Jp * s[i][j] * s[i][j + 1]
        tot += float(np.exp(e))
    return tot


def Z_shifted(M, N, J, Jp, di, dj):
    """スピン配位を (di, dj) だけ巡回シフトしてから足し上げる（値は Z と同じはず）。"""
    M = int(M); N = int(N)
    tot = 0.0
    for flat in itertools.product((-1, 1), repeat=M * N):
        s0 = [[flat[i * N + j] for j in range(N)] for i in range(M)]
        s = [[s0[(i + di) % M][(j + dj) % N] for j in range(N)] for i in range(M)]
        tot += float(np.exp(energy_of_config(s, M, N, J, Jp)))
    return tot


for (M, N) in [(2, 2), (2, 3), (3, 2), (3, 3), (2, 4), (4, 2), (3, 4)]:
    for (J, Jp) in JJ_PAIRS[:4]:
        Z = brute_force_Z(M, N, J, Jp)

        # (a) 全スピン反転で被加数（指数の肩）が不変。全配位について確かめる。
        worst = 0.0
        for flat in itertools.product((-1, 1), repeat=M * N):
            s = [[flat[i * N + j] for j in range(N)] for i in range(M)]
            sflip = [[-x for x in row] for row in s]
            worst = max(worst, abs(energy_of_config(s, M, N, J, Jp)
                                   - energy_of_config(sflip, M, N, J, Jp)))
        rep.close(worst, 0.0, "(a) M=%d N=%d: 全 2^{MN} 配位で全反転により指数の肩が不変" % (M, N))

        # (b) 転置対称性
        rep.close(Z, brute_force_Z(N, M, Jp, J), "(b) M=%d N=%d: Z_{M,N}(J,J')=Z_{N,M}(J',J)" % (M, N))

        # (e) 巡回シフト不変性
        rep.close(Z, Z_shifted(M, N, J, Jp, 1, 0), "(e) M=%d N=%d: 行方向シフト不変" % (M, N))
        rep.close(Z, Z_shifted(M, N, J, Jp, 0, 1), "(e) M=%d N=%d: 列方向シフト不変" % (M, N))

    # (c) J = J' = 0
    rep.close(brute_force_Z(M, N, 0.0, 0.0), float(2 ** (M * N)), "(c) M=%d N=%d: Z(0,0)=2^{MN}" % (M, N))

    # (d) 自由境界版とは一致しないこと（周期境界条件が効いている）
    Zp = brute_force_Z(M, N, 0.3, 0.7)
    Zf = Z_free_boundary(M, N, 0.3, 0.7)
    rep.truth(abs(Zp - Zf) / Zp > 1e-3, "(d) M=%d N=%d: 周期境界と自由境界で値が異なる" % (M, N))
    print("  M=%d N=%d : Z(周期)=%.6e  Z(自由境界)=%.6e  相対差=%.3f"
          % (M, N, Zp, Zf, abs(Zp - Zf) / Zp))

rep.finish()
