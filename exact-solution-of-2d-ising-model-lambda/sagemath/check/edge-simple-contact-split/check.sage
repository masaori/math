"""台の辺が相異なる閉歩道を接触点で二本の短い閉歩道へ分けることを厳密検査する。"""

L = 2
MAX_LENGTH = 8

oriented_edges = [(kind, i, j, d)
                  for kind in ("h", "v") for i in range(L) for j in range(L)
                  for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def base_edge(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def endpoints(edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def src(edge):
    return endpoints(edge)[0]


def tgt(edge):
    return endpoints(edge)[1]


def direction_number(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


def turn(edge, following):
    """一歩の回転数 τ（def_step_turning）。非後退接続だけに定義される。"""
    difference = (direction_number(following) - direction_number(edge)) % 4
    assert difference in (0, 1, 3)
    return ZZ(0) if difference == 0 else (ZZ(1) if difference == 1 else ZZ(-1))


def horizontal_seam(edge):
    """横周期の切断線指示値（def_seam_parities）。"""
    kind, _, j, _ = edge
    return ZZ(1) if kind == "h" and j == L - 1 else ZZ(0)


def vertical_seam(edge):
    """縦周期の切断線指示値（def_seam_parities）。"""
    kind, i, _, _ = edge
    return ZZ(1) if kind == "v" and i == L - 1 else ZZ(0)


def total_turning(walk):
    """循環総回転数（def_cyclic_total_turning）。"""
    m = len(walk)
    return sum(turn(walk[r], walk[(r + 1) % m]) for r in range(m))


def is_nonbacktracking_connection(edge, following):
    return src(following) == tgt(edge) and following != reversal(edge)


def successors(edge):
    return [following for following in oriented_edges
            if is_nonbacktracking_connection(edge, following)]


def is_closed_nonbacktracking(walk):
    return (0 < len(walk)
            and all(is_nonbacktracking_connection(walk[r], walk[(r + 1) % len(walk)])
                    for r in range(len(walk))))


closed_walks = []


def extend(walk):
    if 2 <= len(walk) and walk[0] in successors(walk[-1]):
        closed_walks.append(tuple(walk))
    if len(walk) == MAX_LENGTH:
        return
    for following in successors(walk[-1]):
        walk.append(following)
        extend(walk)
        walk.pop()


for start in oriented_edges:
    extend([start])

edge_simple_walks = [walk for walk in closed_walks
                     if len(set(base_edge(edge) for edge in walk)) == len(walk)]

checked_contacts = ZZ(0)
seam_parity_checks = ZZ(0)
turning_nonzero_shift_contacts = ZZ(0)
for walk in edge_simple_walks:
    m = len(walk)
    for k in range(m):
        for l in range(k + 1, m):
            if tgt(walk[k]) != tgt(walk[l]):
                continue
            walk_a = walk[k + 1:l + 1]
            walk_b = walk[l + 1:] + walk[:k + 1]
            assert is_closed_nonbacktracking(walk_a)
            assert is_closed_nonbacktracking(walk_b)
            assert 0 < len(walk_a) < m
            assert 0 < len(walk_b) < m
            bases = set(base_edge(edge) for edge in walk)
            bases_a = set(base_edge(edge) for edge in walk_a)
            bases_b = set(base_edge(edge) for edge in walk_b)
            assert bases_a.isdisjoint(bases_b)
            assert bases_a.union(bases_b) == bases
            checked_contacts += 1
            # claim_contact_split_seam_parity: 切断線偶奇の組が保存される。
            for seam in (horizontal_seam, vertical_seam):
                sum_a = sum(seam(edge) for edge in walk_a)
                sum_b = sum(seam(edge) for edge in walk_b)
                total = sum(seam(edge) for edge in walk)
                assert sum_a + sum_b == total
                assert (sum_a + sum_b) % 2 == total % 2
                seam_parity_checks += 1
            # 循環総回転数は保存されない: ずれは claim_reconnection_turning_difference
            # の値域 {-4, 0, 4} を走り、零でない接触点が実在する。
            shift = total_turning(walk_a) + total_turning(walk_b) - total_turning(walk)
            original_pair = turn(walk[k], walk[(k + 1) % m]) + turn(walk[l], walk[(l + 1) % m])
            reconnected_pair = turn(walk[k], walk[(l + 1) % m]) + turn(walk[l], walk[(k + 1) % m])
            assert shift == reconnected_pair - original_pair
            assert shift in (-4, 0, 4)
            if shift != 0:
                turning_nonzero_shift_contacts += 1

assert 0 < len(edge_simple_walks)
assert 0 < checked_contacts
assert 0 < turning_nonzero_shift_contacts

print("PASS: closed walks (L=%d, length <= %d): %d; base-edge-simple: %d; "
      "contact splits checked: %d; seam parity checks: %d; "
      "contacts with nonzero turning shift: %d"
      % (L, MAX_LENGTH, len(closed_walks), len(edge_simple_walks),
         checked_contacts, seam_parity_checks, turning_nonzero_shift_contacts))
