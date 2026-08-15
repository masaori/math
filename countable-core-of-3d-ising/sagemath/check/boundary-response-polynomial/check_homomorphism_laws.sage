# 対象ラベル: claim_boundary_response_specialization_homomorphism
# 代入が加法・乗法・単位元を保存することを確認する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, "_prelude.sage"))

f = 2 * source_variables[0] * source_variables[5] + source_variables[9] - 3
g = source_variables[1] ** 2 - 4 * source_variables[7] + 5
assert specialization(f + g) == specialization(f) + specialization(g)
assert specialization(f * g) == specialization(f) * specialization(g)
assert specialization(source_ring.one()) == target_ring.one()

print("RESULT: PASS")
