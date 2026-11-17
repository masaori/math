# 対象ラベル: claim_enumerated_ordered_subfield_maximality_criterion
# Q と Q(√2) の有限標本で、正錐の制限、取込条件、極大性の含意を検算する。
# 全称性と無限和集合は Lean 二版で示す。
s = AA(2).sqrt()
universe = {AA(a) + AA(b)*s for a in range(-2, 3) for b in range(-2, 3)}
f0 = {AA(a) for a in range(-2, 3)}
f1 = universe
c0 = {x for x in f0 if x > 0}
c1 = {x for x in f1 if x > 0}
assert f0 <= f1
assert c1 & f0 == c0
xi = s
candidates = [(f0, c0), (f1, c1)]
for e, d in candidates:
    extends_f0 = f0 <= e and d & f0 == c0
    if extends_f0 and xi in e:
        assert xi in f1
    extends_union = f1 <= e and d & f1 == c1
    if extends_union:
        assert e == f1
print('PASS: 代数的実数 25 件と延長候補 2 件で制限・取込・極大性を検算')
