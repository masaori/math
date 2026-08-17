from itertools import product


def coordinate_unit_vector(index):
    entries = [ZZ(0), ZZ(0), ZZ(0)]
    entries[index] = ZZ(1)
    return vector(QQ, entries)


def oriented_edge_data(endpoint_u, endpoint_v):
    difference = endpoint_v - endpoint_u
    nonzero = [index for index in range(3) if difference[index] != 0]
    assert len(nonzero) == 1
    index = nonzero[0]
    assert abs(difference[index]) == 1
    if difference[index] == 1:
        return endpoint_u, index
    return endpoint_v, index


def dual_face_vertices(endpoint_u, endpoint_v):
    start, direction = oriented_edge_data(endpoint_u, endpoint_v)
    transverse = [index for index in range(3) if index != direction]
    center = start + QQ(1) / QQ(2) * coordinate_unit_vector(direction)
    vertices = []
    for sign_j, sign_k in product([-1, 1], repeat=2):
        point = (
            center
            + QQ(sign_j) / QQ(2) * coordinate_unit_vector(transverse[0])
            + QQ(sign_k) / QQ(2) * coordinate_unit_vector(transverse[1])
        )
        vertices.append(tuple(point))
    return set(vertices)


# --- 箱の分配多項式（自由境界・周期境界）。本文の def_box / def_edge_set / def_periodic_edge_set に対応 ---

def box_vertices(box_side):
    return [tuple(point) for point in product(range(box_side), repeat=3)]


def _shifted(point, direction, amount):
    coordinates = list(point)
    coordinates[direction] += amount
    return tuple(coordinates)


def free_box_edges(box_side):
    # E_L = {(a,i) : a_i <= L-2}. 端点は (a, a+ε_i)
    return [
        (point, _shifted(point, direction, 1))
        for point in box_vertices(box_side)
        for direction in range(3)
        if point[direction] <= box_side - 2
    ]


def periodic_box_edges(box_side):
    # E^per_L = {(a,i)}。端点は a_i <= L-2 なら (a, a+ε_i)、a_i = L-1 なら (a, a-(L-1)ε_i)
    edges = []
    for point in box_vertices(box_side):
        for direction in range(3):
            if point[direction] <= box_side - 2:
                edges.append((point, _shifted(point, direction, 1)))
            else:
                edges.append((point, _shifted(point, direction, -(box_side - 1))))
    return edges


def partition_polynomial_by_enumeration(box_side, edges):
    # Z = Σ_σ x^{#{辺 : 両端の値が異なる}}。全配位の列挙（小さい箱専用）
    R = PolynomialRing(ZZ, "x")
    x = R.gen()
    vertices = box_vertices(box_side)
    total = R(0)
    for values in product([-1, 1], repeat=len(vertices)):
        assignment = dict(zip(vertices, values))
        broken = sum(1 for u, v in edges if assignment[u] != assignment[v])
        total += x**broken
    return total


def _layer_transfer_value(box_side, edges, point_value, periodic):
    # 層（第 3 座標）ごとの状態を 2^{L^2} 個の整数で表し、x=point_value での分配多項式の値を整数で返す。
    # 辺を層内辺と層間辺に分け、層内辺の重みを対角行列 W、層間辺の重みを行列 T にする。
    layer_sites = [(i, j) for i in range(box_side) for j in range(box_side)]
    site_index = {site: k for k, site in enumerate(layer_sites)}
    states = list(product([-1, 1], repeat=len(layer_sites)))
    n = len(states)
    intra = {}
    inter = {}
    for u, v in edges:
        if u[2] == v[2]:
            intra.setdefault(u[2], []).append((site_index[u[:2]], site_index[v[:2]]))
        else:
            inter.setdefault((u[2], v[2]), []).append((site_index[u[:2]], site_index[v[:2]]))
    def diag_matrix(layer):
        M = matrix(ZZ, n, n)
        for a, s in enumerate(states):
            broken = sum(1 for p, q in intra.get(layer, []) if s[p] != s[q])
            M[a, a] = ZZ(point_value) ** broken
        return M
    def transfer_matrix(layer_from, layer_to):
        M = matrix(ZZ, n, n)
        pairs = inter.get((layer_from, layer_to), [])
        for a, s in enumerate(states):
            for b, t in enumerate(states):
                broken = sum(1 for p, q in pairs if s[p] != t[q])
                M[a, b] = ZZ(point_value) ** broken
        return M
    total = diag_matrix(0)
    for layer in range(1, box_side):
        total = total * transfer_matrix(layer - 1, layer) * diag_matrix(layer)
    if periodic:
        if box_side >= 2:
            total = total * transfer_matrix(box_side - 1, 0)
        return total.trace()
    ones = vector(ZZ, [1] * n)
    return ones * total * ones


def partition_polynomial_by_layer_transfer(box_side, edges, periodic):
    # 次数は #edges 以下なので #edges+1 個の整数点で値を取り、QQ 上で Lagrange 補間して ZZ[x] へ戻す
    R = PolynomialRing(QQ, "x")
    points = [(QQ(k), QQ(_layer_transfer_value(box_side, edges, k, periodic))) for k in range(len(edges) + 1)]
    interpolated = R.lagrange_polynomial(points)
    return PolynomialRing(ZZ, "x")(interpolated)


def free_partition_value_by_fast_layer_transfer(box_side, point_value):
    # 自由境界の層間行列 T[s,t]=x^Hamming(s,t) を密行列として作らず、
    # Kronecker 積 [[1,x],[x,1]] の butterfly としてベクトルへ作用させる。
    layer_site_count = box_side**2
    state_count = 2**layer_site_count

    def site_index(i, j):
        return i * box_side + j

    intra_edges = []
    for i in range(box_side):
        for j in range(box_side):
            if i + 1 < box_side:
                intra_edges.append((site_index(i, j), site_index(i + 1, j)))
            if j + 1 < box_side:
                intra_edges.append((site_index(i, j), site_index(i, j + 1)))

    intra_weights = []
    x_value = ZZ(point_value)
    for state in range(state_count):
        broken = sum(
            1
            for p, q in intra_edges
            if ((state >> p) & 1) != ((state >> q) & 1)
        )
        intra_weights.append(x_value**broken)

    values = list(intra_weights)
    for _layer in range(1, box_side):
        for bit in range(layer_site_count):
            stride = 1 << bit
            block = stride << 1
            for start in range(0, state_count, block):
                for offset in range(stride):
                    left = start + offset
                    right = left + stride
                    a = values[left]
                    b = values[right]
                    values[left] = a + x_value * b
                    values[right] = x_value * a + b
        values = [value * weight for value, weight in zip(values, intra_weights)]

    return sum(values)


def free_partition_value_by_fast_layer_transfer_mod_prime(box_side, point_value, prime):
    # 上の butterfly を素体上で一括計算する。各演算後に剰余を取り、numpy.int64 の範囲を保つ。
    import numpy as np

    layer_site_count = box_side**2
    state_count = 2**layer_site_count
    states = np.arange(state_count, dtype=np.int64)
    broken = np.zeros(state_count, dtype=np.int64)

    def site_index(i, j):
        return i * box_side + j

    for i in range(box_side):
        for j in range(box_side):
            if i + 1 < box_side:
                p = site_index(i, j)
                q = site_index(i + 1, j)
                broken += ((states >> p) ^ (states >> q)) & 1
            if j + 1 < box_side:
                p = site_index(i, j)
                q = site_index(i, j + 1)
                broken += ((states >> p) ^ (states >> q)) & 1

    modulus = int(prime)
    x_value = int(point_value) % modulus
    intra_weights = np.array(
        [pow(x_value, int(exponent), modulus) for exponent in broken],
        dtype=np.int64,
    )

    values = intra_weights.copy()
    for _layer in range(1, box_side):
        for bit in range(layer_site_count):
            stride = 1 << bit
            pairs = values.reshape((-1, 2, stride))
            left = pairs[:, 0, :].copy()
            right = pairs[:, 1, :].copy()
            pairs[:, 0, :] = (left + x_value * right) % modulus
            pairs[:, 1, :] = (x_value * left + right) % modulus
        values = (values * intra_weights) % modulus

    return int(values.sum(dtype=np.int64) % modulus)
