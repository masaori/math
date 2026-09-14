# 対象ラベル: claim_bare_stage_loses_uniform_transport
# 併せて検証: def_bare_stage_transport_counterexample
# 式ペア: |N_lozenge(u)| = 1 および |N_lozenge(v)| = 2。
# 帰属: 有限集合と ZZ。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cardinality_u = ZZ(len(NEIGHBORHOODS['u']))
cardinality_v = ZZ(len(NEIGHBORHOODS['v']))

assert cardinality_u == ZZ(1)
assert cardinality_v == ZZ(2)
assert cardinality_u != cardinality_v
print('neighborhood cardinalities:', cardinality_u, cardinality_v)
print('RESULT: PASS')

