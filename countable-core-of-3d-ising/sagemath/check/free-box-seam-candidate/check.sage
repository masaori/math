# 固定候補の n=1 のみを検査する。全 n の定理の検査ではない。
from pathlib import Path
load(str(Path(__file__).resolve().parents[2] / "_shared" / "defs.sage"))

n = ZZ(1)
vertices = box_vertices(2*n)
edges = free_box_edges(2*n)
blocks = list(product(range(2), repeat=3))
block_of = lambda v: tuple(c // n for c in v)
seams = [(u,v) for u,v in edges if block_of(u) != block_of(v)]
internal = [(u,v) for u,v in edges if block_of(u) == block_of(v)]
assert len(seams) == 12*n**2
assert len(internal) == 8*len(free_box_edges(n))
seen = set()
weighted = ZZ(0)
disconnected = ZZ(0)
for values in product([-1,1], repeat=len(vertices)):
    sigma = dict(zip(vertices, values))
    restrictions = tuple(tuple(sigma[tuple(n*t[j]+a[j] for j in range(3))]
                               for a in box_vertices(n)) for t in blocks)
    assert restrictions not in seen
    seen.add(restrictions)
    reconstructed = {tuple(n*t[j]+a[j] for j in range(3)): restrictions[k][h]
                     for k,t in enumerate(blocks) for h,a in enumerate(box_vertices(n))}
    assert reconstructed == sigma
    broken = ZZ(sum(sigma[u] != sigma[v] for u,v in edges))
    local_broken = ZZ(sum(sigma[u] != sigma[v] for u,v in internal))
    seam_broken = ZZ(sum(sigma[u] != sigma[v] for u,v in seams))
    assert broken == local_broken + seam_broken
    assert 0 <= seam_broken <= len(seams)
    local_weight = ZZ(2)**local_broken
    weight = ZZ(2)**broken
    assert weight == local_weight * ZZ(2)**seam_broken
    assert local_weight <= weight <= ZZ(2)**len(seams)*local_weight
    weighted += weight
    disconnected += local_weight
assert len(seen) == (ZZ(2)**(n**3))**8
small = partition_polynomial_by_enumeration(n, free_box_edges(n))
large = partition_polynomial_by_enumeration(2*n, edges)
assert disconnected == small(2)**8
assert weighted == large(2)
assert disconnected <= weighted <= ZZ(2)**(12*n**2)*disconnected
print("n=1: configurations=%s seams=%s Z_1(2)=%s Z_2(2)=%s interval=[%s,%s]" %
      (len(seen),len(seams),small(2),weighted,disconnected,ZZ(2)**12*disconnected))
print("RESULT: PASS (finite candidate evidence only; no limit existence claim)")
