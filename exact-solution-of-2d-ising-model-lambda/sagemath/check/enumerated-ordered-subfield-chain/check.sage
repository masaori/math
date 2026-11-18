# 対象ラベル: claim_enumerated_ordered_subfield_chain
# 有限標本で初項・一段ずつの延長・列挙した元の取込条件を検算する。
sqrt2 = AA(2).sqrt()
sqrt3 = AA(3).sqrt()
f0 = {AA(a) for a in range(-2, 3)}
f1 = {AA(a) + AA(b) * sqrt2 for a in range(-2, 3) for b in range(-2, 3)}
f2 = {AA(a) + AA(b) * sqrt2 + AA(c) * sqrt3 + AA(d) * sqrt2 * sqrt3
      for a in range(-2, 3) for b in range(-2, 3)
      for c in range(-2, 3) for d in range(-2, 3)}
fields = [f0, f1, f2]
cones = [{x for x in field if x > 0} for field in fields]
enumerated = [sqrt2, sqrt3]

assert fields[0] == f0 and cones[0] == {x for x in f0 if x > 0}
for n in range(2):
    assert fields[n] <= fields[n + 1]
    assert cones[n + 1] & fields[n] == cones[n]
    assert enumerated[n] in fields[n + 1]

print('PASS: 有限標本の初項・二段の延長・取込条件')
