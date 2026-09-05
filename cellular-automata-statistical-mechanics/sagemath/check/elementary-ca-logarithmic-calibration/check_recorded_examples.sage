# 対象ラベル: def_binary_ca_fiber_logarithmic_entropy
# 式ペア・判定: 校正結果の明示例を有限真理値表から再計算する。
# 帰属: 有限集合・ZZ・QQ・素数指数。一般のセル数・時刻への主張ではない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
examples = {}
for size, rule, mapping, slope, H, n, fixed, fibers, counts, D in calibration_rows():
    if size == 3 and (rule, slope, n) in [(204,1,1),(204,2,1),(170,1,1),(170,1,3),(51,0,1),(51,0,2)]:
        examples[(rule,slope,n)] = (len(fixed), {u:counts[u] for u in sorted(D)})
assert examples == {
    (204,1,1): (8,{0:1,1:3,2:3,3:1}),
    (204,2,1): (8,{0:1,2:3,4:3,6:1}),
    (170,1,1): (2,{0:1,3:1}),
    (170,1,3): (8,{0:1,1:3,2:3,3:1}),
    (51,0,1): (0,{}),
    (51,0,2): (8,{0:8}),
}
for rule in (204,170):
    n = 1 if rule == 204 else 3
    counts = examples[(rule,1,n)][1]
    assert [row_beta(counts,u) for u in (0,1,2)] == [{3:1},{},{3:-1}]
    assert logarithm(QQ(sum(counts.values()))) == {2:3}
delta = sub(row_entropy(examples[(204,2,1)][1],2),row_entropy(examples[(204,2,1)][1],0))
assert delta == {3:1}
assert not ZZ(2).divides(delta[3])
conservation_failure = None
for size, rule, configs, mapping in elementary_maps():
    if size == 4 and rule == 172:
        H = observable(configs,1)
        x = next(x for x in range(len(configs)) if H[mapping[x]] != H[x])
        conservation_failure = (configs[x],configs[mapping[x]],H[x],H[mapping[x]])
        assert H[x] != H[mapping[x]]
assert conservation_failure is not None
print('L=3 examples (rule,slope,n):',examples)
print('rule 172 L=4 failure (x,Fx,Hx,HFx):',conservation_failure)
print('RESULT: PASS')
