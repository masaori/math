"""非後退置換の置換項が軌道ごとの符号と回転位相の冪の積になることを厳密検査する。

対象: claim_kac_ward_term_orbit_phase_twist_product。
一辺 L=2 のトーラスで、向き付き辺が相異なる閉じた非後退辺列（長さ 8 まで）から
台の上で列を巡回させ台の外を固定する置換（単一軌道）と、台が交わらない二本の
閉歩道の合成（二軌道）を組み、定義どおりの置換項 T^{a,b}_φ(x) と
Π_C ( -x^|C| · (-1)^{a h(γ_C)+b v(γ_C)} ζ8^{t∘(γ_C)} ) を Q(ζ8)[x] で比較する。
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


def permutation_sign_of(oriented, phi):
    index_of = {edge: i for i, edge in enumerate(oriented)}
    sigma = [index_of[phi(edge)] for edge in oriented]
    inversions = sum(1 for i in range(len(sigma)) for j in range(i + 1, len(sigma))
                     if sigma[i] > sigma[j])
    return (-1) ** inversions


def permutation_term(L, oriented, a, b, phi):
    term = P(permutation_sign_of(oriented, phi))
    for edge in oriented:
        image = phi(edge)
        entry = transition_entry(L, a, b, edge, image)
        term *= (P(1) if image == edge else P(0)) - x * P(entry)
    return term


def orbit_phase_twist_product(L, a, b, phi, walks):
    """右辺: 各軌道の基点からの軌道列 γ_C で符号と回転位相を計算した積。"""
    product = P(1)
    for walk in walks:
        r = len(walk)
        h_parity = sum(seam_parities(L, edge)[0] for edge in walk) % 2
        v_parity = sum(seam_parities(L, edge)[1] for edge in walk) % 2
        cyclic_turning = sum(step_turning(walk[k], walk[(k + 1) % r])
                             for k in range(r))
        value = K8(ZZ(-1) ** (a * h_parity + b * v_parity)) \
            * zeta8 ** cyclic_turning
        product *= -(x ** r) * P(value)
    return product


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


def phi_from_walks(walks):
    successor_of = {}
    for walk in walks:
        r = len(walk)
        for k in range(r):
            successor_of[walk[k]] = walk[(k + 1) % r]

    def phi(edge):
        return successor_of.get(edge, edge)

    return phi


def check_case(walks):
    global checked
    phi = phi_from_walks(walks)
    # 主張の仮定: 動く辺はすべて直ちに引き返さない後続へ移る。
    for edge in oriented:
        if phi(edge) != edge:
            assert phi(edge) in successors(L, oriented, edge)
    # 各 walk はその軌道の基点 walk[0] からの軌道列 γ_C に一致する。
    for walk in walks:
        current = walk[0]
        for k in range(len(walk)):
            assert current == walk[k]
            current = phi(current)
        assert current == walk[0]
    for a in (0, 1):
        for b in (0, 1):
            lhs = permutation_term(L, oriented, a, b, phi)
            rhs = orbit_phase_twist_product(L, a, b, phi, walks)
            assert lhs == rhs
            checked += 1


# 単一軌道: すべての閉歩道。
for walk in distinct_closed_walks:
    check_case([walk])
single_orbit_cases = len(distinct_closed_walks)

# 二軌道: 長さ 4 以下の閉歩道の対で台が交わらないもの。
short_walks = [walk for walk in distinct_closed_walks if len(walk) <= 4]
pair_cases = 0
for i in range(len(short_walks)):
    for j in range(i + 1, len(short_walks)):
        if set(short_walks[i]).isdisjoint(set(short_walks[j])):
            check_case([short_walks[i], short_walks[j]])
            pair_cases += 1

assert single_orbit_cases > 0
assert pair_cases > 0
assert checked == 4 * (single_orbit_cases + pair_cases)
print("PASS: 非後退置換の置換項 = Π_C ( -x^|C| × 切断線偶奇の符号 × ζ8^循環総回転数 ) "
      f"(単一軌道 {single_orbit_cases} 件 + 二軌道 {pair_cases} 件, ×4 スピン構造 = {checked} 件)")
