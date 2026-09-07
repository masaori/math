# 対象ラベル: claim_bare_stage_loses_uniform_transport
# 併せて検証: def_bare_stage_transport_counterexample
# 式ペア: sigma[N_lozenge(u)] = {v} != {u,v} = N_lozenge(sigma(u))。
# 帰属: 有限集合と有限写像。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

left = image(SWAP, NEIGHBORHOODS['u'])
right = NEIGHBORHOODS[SWAP['u']]

assert left == frozenset(('v',))
assert right == frozenset(('u', 'v'))
assert 'u' not in left
assert 'u' in right
assert left != right
print('swap image:', sorted(left))
print('target neighborhood:', sorted(right))
print('RESULT: PASS')

