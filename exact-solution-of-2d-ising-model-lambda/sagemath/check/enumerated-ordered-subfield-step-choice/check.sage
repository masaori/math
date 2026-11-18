# 対象ラベル: claim_enumerated_ordered_subfield_step_choice
# 有限標本で延長可能・不能の二つの場合の選択と取込含意を検算する。
sqrt2 = AA(2).sqrt()
f0 = {AA(a) for a in range(-3, 4)}
f1 = {AA(a) + AA(b) * sqrt2 for a in range(-3, 4) for b in range(-3, 4)}
c0 = {a for a in f0 if a > 0}
c1 = {a for a in f1 if a > 0}
assert f0 <= f1
assert c1 & f0 == c0

def choose_step(x, candidates):
    possible = [(e, d) for e, d in candidates if f0 <= e and d & f0 == c0 and x in e]
    return possible[0] if possible else (f0, c0)

for x, candidates in [(sqrt2, [(f1, c1)]), (sqrt2, [(f0, c0)])]:
    e, d = choose_step(x, candidates)
    assert f0 <= e
    assert d & f0 == c0
    possible = any(f0 <= field and cone & f0 == c0 and x in field
                   for field, cone in candidates)
    assert not possible or x in e

print('PASS: 延長可能な標本と候補の無い標本で、一段の選択と取込含意を検算')
