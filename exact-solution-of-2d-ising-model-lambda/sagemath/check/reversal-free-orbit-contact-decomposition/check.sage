"""反転対を含まない非後退置換の軌道列が頂点単純な閉路族へ分かれることを厳密検査する。

対象: claim_reversal_free_orbit_vertex_simple_decomposition。
一辺 L=2 のトーラスで非後退置換を全列挙し、動く辺の集合が反転対
{(e,0),(e,1)} を含まない置換について、動く辺 e から始まる軌道列
γ = γ_φ(e) を組み、接触対が残る限り最初の接触点で二本へ分ける
整礎帰納（claim_contact_elimination_by_splitting の手続き）を走らせて、
得られた族 (δ_1, ..., δ_n) が三条件を満たすことを検査する:
各 δ_i の接触対数が零であること、台の辺集合が互いに交わらず合併が
γ の台の辺集合に等しいこと、切断線偶奇の和の偶奇が γ のものに等しいこと。
すべて有限集合の数え上げであり、浮動小数点は使わない。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def base_of(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def target(L, edge):
    return endpoints(L, edge)[1]


def is_closed_nonbacktracking(L, walk):
    return (0 < len(walk)
            and all(walk[(r + 1) % len(walk)] in successors(L, edges(L), walk[r])
                    for r in range(len(walk))))


def contact_pairs(L, walk):
    m = len(walk)
    return [(a, b) for a in range(m) for b in range(a + 1, m)
            if target(L, walk[a]) == target(L, walk[b])]


def seam_parity_pair(L, walk):
    total_h = sum(seam_parities(L, edge)[0] for edge in walk)
    total_v = sum(seam_parities(L, edge)[1] for edge in walk)
    return (total_h % 2, total_v % 2)


L = 2
oriented = edges(L)
successor_lists = {edge: successors(L, oriented, edge) for edge in oriented}
edge_count = len(oriented)

# 非後退置換の全列挙。各辺を固定するか後続の一つへ写し、単射なものだけ残す。
# 有限集合の単射な自己写像は全射でもあるので、これで置換が尽くされる。
nonbacktracking_permutations = []


def extend(position, images, used):
    if position == edge_count:
        nonbacktracking_permutations.append(dict(images))
        return
    edge = oriented[position]
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

reversal_free_count = 0
orbit_count = 0
family_size_total = ZZ(0)
split_orbit_count = 0

for phi in nonbacktracking_permutations:
    moved = {edge for edge in oriented if phi[edge] != edge}
    if any(reversal(edge) in moved for edge in moved):
        continue
    reversal_free_count += 1
    for start in moved:
        # 軌道列 γ_φ(start)。最小回帰時刻 r まで反復合成を並べる。
        walk = [start]
        current = phi[start]
        while current != start:
            walk.append(current)
            current = phi[current]
        walk = tuple(walk)
        orbit_count += 1
        # 準備: γ は閉じた非後退辺列で、台の辺は相異なる（既証の二主張の再確認）。
        assert is_closed_nonbacktracking(L, walk)
        bases = [base_of(edge) for edge in walk]
        assert len(set(bases)) == len(bases)
        # claim_contact_elimination_by_splitting の手続き: 接触対が残る限り
        # 最初の接触点で二本へ分ける。接触対数の狭義減少により停止する。
        stack = [walk]
        family = []
        while stack:
            current_walk = stack.pop()
            pairs = contact_pairs(L, current_walk)
            if not pairs:
                family.append(current_walk)
                continue
            a, b = pairs[0]
            part_a = current_walk[a + 1:b + 1]
            part_b = current_walk[b + 1:] + current_walk[:a + 1]
            assert is_closed_nonbacktracking(L, part_a)
            assert is_closed_nonbacktracking(L, part_b)
            assert (len(contact_pairs(L, part_a)) + len(contact_pairs(L, part_b))
                    < len(pairs))
            stack.append(part_a)
            stack.append(part_b)
        # 第一条件: 族は空でなく、各成員の接触対数は零（通過の頂点が相異なる）。
        assert 1 <= len(family)
        assert all(not contact_pairs(L, part) for part in family)
        # 第二条件: 台の辺集合は互いに交わらず、合併が γ の台の辺集合に等しい。
        family_bases = [set(base_of(edge) for edge in part) for part in family]
        assert all(family_bases[i].isdisjoint(family_bases[j])
                   for i in range(len(family_bases))
                   for j in range(i + 1, len(family_bases)))
        assert set().union(*family_bases) == set(bases)
        # 第三条件: 切断線偶奇の和の偶奇が γ の切断線偶奇の組に等しい。
        sum_h = sum(seam_parity_pair(L, part)[0] for part in family)
        sum_v = sum(seam_parity_pair(L, part)[1] for part in family)
        assert (sum_h % 2, sum_v % 2) == seam_parity_pair(L, walk)
        family_size_total += len(family)
        if 2 <= len(family):
            split_orbit_count += 1

# 仮定と手続きが空でないこと（反転対なしの置換・軌道列・実際に分かれる軌道列の実在）。
assert reversal_free_count == 497
assert orbit_count > 0
assert split_orbit_count > 0

print("PASS: reversal-free nonbacktracking permutations =", reversal_free_count)
print("PASS: orbit walks decomposed =", orbit_count)
print("PASS: vertex-simple cycles produced =", family_size_total)
print("PASS: orbit walks that actually split =", split_orbit_count)
print("PASS: decomposition keeps support partition and seam parities (L = 2)")
