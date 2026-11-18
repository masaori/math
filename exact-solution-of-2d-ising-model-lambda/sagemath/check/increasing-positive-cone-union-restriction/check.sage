# 対象ラベル: claim_increasing_positive_cone_union_restricts_to_stage
# 有限標本は各部分体の全体ではない。制限等号の具体例だけを検算する。
s = AA(2).sqrt()
t = AA(3).sqrt()
f0 = {AA(a) for a in range(-2, 3)}
f1 = {AA(a) + AA(b) * s for a in range(-2, 3) for b in range(-2, 3)}
f2 = {AA(a) + AA(b) * s + AA(c) * t
      for a in range(-2, 3) for b in range(-2, 3) for c in range(-2, 3)}
fields = [f0, f1, f2]
cones = [{x for x in field if x > 0} for field in fields]
for n in range(2):
    assert fields[n] <= fields[n + 1]
    assert cones[n + 1] & fields[n] == cones[n]
union_cone = set().union(*cones)
for n in range(3):
    assert union_cone & fields[n] == cones[n]
print('PASS: 有限標本の三段で正錐の和集合の制限等号を検算')
