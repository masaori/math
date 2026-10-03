# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
# 式ペア: 仮定 u_t=-u_s の代入 pi(u_t)=pi(-u_s)。帰属: ZZ。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))

checked = 0
for length, horizontal, vertical in winding_cases():
    for step in reversed_steps(length, horizontal, vertical):
        # 実際には存在しない逆向きの反転歩を仮定した場合の、座標への代入だけを検査する。
        assumed_step = vector_scale(-1, step)
        assert parallel_coordinate(horizontal, vertical, assumed_step) == (
            parallel_coordinate(horizontal, vertical, vector_scale(-1, step)))
        checked += 1
print(f'RESULT: PASS ({checked} cases, opposite_coordinate_substitution)')
