"""軌道の長さの総和が反転対と単純通過で数えられることを厳密検査する。

対象: claim_moved_orbit_length_sum_stratified。
主張は任意の置換 φ ∈ Perm(vec E_L) についての等式

    Σ_{C∈𝒞(φ)} |C| = |M(φ)| = 2|D(φ)| + |E_1(φ)|

である。検査は二段である。

- L=1 で向き付き辺 4 本の置換 24 個を全列挙する（非後退に限らない任意の置換。
  主張の全称の範囲をこの大きさで尽くす）。
- L=2 で非後退置換 30,784 個を全列挙する（行列式の和に実際に現れる範囲）。

各置換について、証明の各段を検査する。

- M(φ) が台の辺ごとの部分集合 {e}×M_e(φ) の互いに素な合併であること。
- E_supp(φ) = D(φ) ⊔ E_1(φ)（互いに素な合併）であること。
- |M_e(φ)| が D(φ) の上で 2、E_1(φ) の上で 1 であること。
- 軌道族 𝒞(φ)（M(φ) 上の φ の軌道の集合）の長さの総和が |M(φ)| に等しいこと。
- |M(φ)| = 2|D(φ)| + |E_1(φ)|（結論）。

すべて有限集合の数え上げであり、浮動小数点は使わない。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")

from itertools import permutations as all_permutations


def stratification_checks(L, phi, oriented):
    moved = [edge for edge in oriented if phi[edge] != edge]
    moved_set = set(moved)
    support = {(kind, i, j) for (kind, i, j, d) in moved}
    doubled = {base for base in support
               if (base + (0,)) in moved_set and (base + (1,)) in moved_set}
    single = support - doubled

    # E_supp = D ⊔ E_1（互いに素な合併）。
    assert single | doubled == support
    assert single & doubled == set()

    # M(φ) は台の辺ごとの互いに素な合併であり、|M_e| は二場合に従う。
    fiber_total = 0
    for base in support:
        fiber = [d for d in (0, 1) if (base + (d,)) in moved_set]
        assert len(fiber) >= 1
        if base in doubled:
            assert len(fiber) == 2
        else:
            assert base in single
            assert len(fiber) == 1
        fiber_total += len(fiber)
    assert fiber_total == len(moved_set)

    # 軌道族の長さの総和は |M(φ)| に等しい。
    remaining = set(moved_set)
    orbit_length_sum = 0
    orbit_count = 0
    while remaining:
        start = next(iter(remaining))
        orbit = {start}
        current = phi[start]
        while current != start:
            assert current in moved_set
            orbit.add(current)
            current = phi[current]
        assert orbit <= remaining
        remaining -= orbit
        orbit_length_sum += len(orbit)
        orbit_count += 1
    assert orbit_length_sum == len(moved_set)

    # 結論: |M(φ)| = 2|D(φ)| + |E_1(φ)|。
    assert len(moved_set) == 2 * len(doubled) + len(single)
    return len(doubled) > 0


# --- L=1: 任意の置換 24 個の全列挙 ---
L1 = 1
oriented1 = edges(L1)
assert len(oriented1) == 4
count1 = 0
with_doubled1 = 0
for images in all_permutations(oriented1):
    phi = dict(zip(oriented1, images))
    if stratification_checks(L1, phi, oriented1):
        with_doubled1 += 1
    count1 += 1
assert count1 == 24
assert with_doubled1 > 0

# --- L=2: 非後退置換 30,784 個の全列挙 ---
L2 = 2
oriented2 = edges(L2)


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


successor_lists = {edge: successors(L2, oriented2, edge) for edge in oriented2}
edge_count2 = len(oriented2)

nonbacktracking_permutations = []


def extend(position, images, used):
    if position == edge_count2:
        nonbacktracking_permutations.append(dict(images))
        return
    edge = oriented2[position]
    for image in [edge] + successor_lists[edge]:
        if image in used:
            continue
        images[edge] = image
        used.add(image)
        extend(position + 1, images, used)
        used.discard(image)
        del images[edge]


extend(0, {}, set())
assert len(nonbacktracking_permutations) == 30784

with_doubled2 = 0
for phi in nonbacktracking_permutations:
    if stratification_checks(L2, phi, oriented2):
        with_doubled2 += 1
assert with_doubled2 > 0

print("PASS: moved-orbit-length-sum-stratified")
print(f"  L=1: 置換 {count1} 個（反転対を含むもの {with_doubled1} 個）")
print(f"  L=2: 非後退置換 {len(nonbacktracking_permutations)} 個"
      f"（反転対を含むもの {with_doubled2} 個）")
