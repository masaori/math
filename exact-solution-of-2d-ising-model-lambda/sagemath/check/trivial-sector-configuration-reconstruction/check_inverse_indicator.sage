# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: a(e) = q(delta_L^(-1)(e))
# 帰属: NN。双対逆写像を直接評価する。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

checked = 0
for case in _rc_cases:
    for edge in range(1, 2 * case['L'] * case['L'] + 1):
        assert NN(edge in case['A']) == NN(_rc_inverse_dual(case['L'], edge) in case['B'])
        checked += 1
print('RESULT: PASS (双対逆写像と指示関数: %d 辺)' % checked)
