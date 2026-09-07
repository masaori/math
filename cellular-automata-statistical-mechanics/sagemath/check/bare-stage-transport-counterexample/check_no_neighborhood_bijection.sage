# 対象ラベル: claim_bare_stage_loses_uniform_transport
# 併せて検証: def_bare_stage_transport_counterexample
# 判定: N_lozenge(u) から N_lozenge(v) への全写像を列挙し、全単射が存在しない。
# 帰属: 有限集合と有限写像。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

source = tuple(sorted(NEIGHBORHOODS['u']))
target = tuple(sorted(NEIGHBORHOODS['v']))
functions = tuple(dict(zip(source, values)) for values in itertools.product(target, repeat=len(source)))
bijections = tuple(
    mapping
    for mapping in functions
    if image(mapping, source) == NEIGHBORHOODS['v'] and len(set(mapping.values())) == len(source)
)

assert len(functions) == 2
assert len(bijections) == 0
print('functions checked:', len(functions))
print('bijections found:', len(bijections))
print('RESULT: PASS')

