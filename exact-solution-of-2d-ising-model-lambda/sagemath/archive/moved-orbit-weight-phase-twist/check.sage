"""動く軌道の遷移成分積が切断線偶奇の符号と回転位相の冪に分かれることを厳密検査する。

対象: claim_moved_orbit_weight_phase_twist。
一辺 L=2 のトーラスの向き付き辺が相異なる閉じた非後退辺列のすべて（長さ 8 まで）から、
台の上で列を巡回させ台の外を固定する置換 φ を組み、その軌道 C・軌道列 γ について
Π_{e∈C} M^{a,b}_{e,φ(e)} = (-1)^{a h(γ)+b v(γ)} ζ8^{t∘(γ)} を Q(ζ8) で比較する。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def step_turning(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


L = 2
oriented = edges(L)
checked = 0

# 向き付き辺が相異なる閉じた非後退辺列を長さ 8 まで全列挙する。
distinct_closed_walks = []
frontier = [[edge] for edge in oriented]
for length in range(1, 9):
    for walk in frontier:
        if walk[0] in successors(L, oriented, walk[-1]):
            distinct_closed_walks.append(list(walk))
    if length < 8:
        frontier = [walk + [nxt] for walk in frontier
                    for nxt in successors(L, oriented, walk[-1])
                    if nxt not in walk]

for walk in distinct_closed_walks:
    r = len(walk)
    support = set(walk)
    # 台の上で列を巡回させ、台の外を固定する置換。
    successor_of = {walk[k]: walk[(k + 1) % r] for k in range(r)}

    def phi(edge):
        return successor_of.get(edge, edge)

    # 主張の仮定: 動く辺はすべて直ちに引き返さない後続へ移る。
    for edge in oriented:
        if phi(edge) != edge:
            assert phi(edge) in successors(L, oriented, edge)

    # 軌道列 γ_φ(e0) は walk 自身（e0 = walk[0]、最小回帰時刻 r）である。
    current = walk[0]
    for k in range(r):
        assert current == walk[k]
        current = phi(current)
    assert current == walk[0]

    h_parity = sum(seam_parities(L, edge)[0] for edge in walk) % 2
    v_parity = sum(seam_parities(L, edge)[1] for edge in walk) % 2
    cyclic_turning = sum(step_turning(walk[k], walk[(k + 1) % r])
                         for k in range(r))

    for a in (0, 1):
        for b in (0, 1):
            product = K8(1)
            for edge in support:
                entry = transition_entry(L, a, b, edge, phi(edge))
                assert entry != 0
                product *= entry
            expected = K8(ZZ(-1) ** (a * h_parity + b * v_parity)) \
                * zeta8 ** cyclic_turning
            assert product == expected
            checked += 1

assert len(distinct_closed_walks) > 0
assert checked == 4 * len(distinct_closed_walks)
print("PASS: 動く軌道の遷移成分積 = 切断線偶奇の符号 × ζ8^循環総回転数 "
      f"({len(distinct_closed_walks)} 閉歩道 × 4 スピン構造 = {checked} 件)")
