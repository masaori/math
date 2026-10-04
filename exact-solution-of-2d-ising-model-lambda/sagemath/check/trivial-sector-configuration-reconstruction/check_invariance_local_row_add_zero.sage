# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \delta = \delta+0
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_row', 1, 2, '横辺の一項：零を加える')
