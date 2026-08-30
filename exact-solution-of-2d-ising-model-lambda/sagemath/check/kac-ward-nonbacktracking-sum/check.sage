"""四つの Kac--Ward 行列式が非後退置換の位相表示の和に一致することを厳密検査する。

対象: claim_kac_ward_determinant_nonbacktracking_phase_sum。
一辺 L=2 のトーラスで、非後退置換（動く辺がすべて直ちに引き返さない後続へ移る置換）を
全列挙し、各置換の軌道ごとの位相表示 Π_C ( -x^|C| · (-1)^{a h(γ_C)+b v(γ_C)} ζ8^{t∘(γ_C)} )
の総和を、det(I - x M^{a,b}) の直接計算と Q(ζ8)[x] で比較する。行列式は全置換にわたる
和なので、この一致は「非後退でない置換の項が零である」ことも同時に確かめる。
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
successor_lists = {edge: successors(L, oriented, edge) for edge in oriented}
edge_count = len(oriented)

# 非後退置換の全列挙。各辺を固定するか後続の一つへ写し、単射なものだけ残す。
# 有限集合の単射な自己写像は全単射なので、これで置換が尽くされる。
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


def moved_orbits(phi):
    """動く辺の軌道を、oriented の順で最初に現れる基点からの軌道列として拾う。"""
    seen = set()
    orbits = []
    for edge in oriented:
        if phi[edge] == edge or edge in seen:
            continue
        walk = []
        current = edge
        while current not in seen:
            seen.add(current)
            walk.append(current)
            current = phi[current]
        assert current == edge
        orbits.append(walk)
    return orbits


def orbit_phase_twist_product(a, b, walks):
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


orbits_of = [moved_orbits(phi) for phi in nonbacktracking_permutations]
checked = 0
for a in (0, 1):
    for b in (0, 1):
        m = matrix(P, edge_count, edge_count, lambda r, s: P(
            transition_entry(L, a, b, oriented[r], oriented[s])))
        det_poly = (identity_matrix(P, edge_count) - x * m).det()
        total = P(0)
        for walks in orbits_of:
            total += orbit_phase_twist_product(a, b, walks)
        assert total == det_poly
        checked += 1

assert len(nonbacktracking_permutations) > 0
assert checked == 4
print("PASS: det(I - x M^{a,b}) = Σ_{非後退置換} Π_C ( -x^|C| × 切断線偶奇の符号 × "
      f"ζ8^循環総回転数 ) (非後退置換 {len(nonbacktracking_permutations)} 件, "
      f"スピン構造 {checked} 件)")
