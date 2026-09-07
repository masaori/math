# 対象ラベル: claim_bare_stage_loses_uniform_transport
# 併せて検証: def_bare_stage_transport_counterexample, def_state_set
# 式ペア: |A^N_lozenge(u)| = 2^1 = 2 および |A^N_lozenge(v)| = 2^2 = 4。
# 帰属: 有限集合と ZZ。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

inputs_u = local_inputs(NEIGHBORHOODS['u'])
inputs_v = local_inputs(NEIGHBORHOODS['v'])
cardinality_u = ZZ(len(inputs_u))
cardinality_v = ZZ(len(inputs_v))

assert len(set(inputs_u)) == len(inputs_u)
assert len(set(inputs_v)) == len(inputs_v)
assert cardinality_u == ZZ(len(STATES)) ** ZZ(len(NEIGHBORHOODS['u'])) == ZZ(2)
assert cardinality_v == ZZ(len(STATES)) ** ZZ(len(NEIGHBORHOODS['v'])) == ZZ(4)
assert cardinality_u != cardinality_v
print('local input cardinalities:', cardinality_u, cardinality_v)
print('RESULT: PASS')

