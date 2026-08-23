# SageMath: q=1 での有限箱分配多項式の値
# 対象ラベル: claim_limit_quantity_at_one_equals_two
# 式ペア: Z_L(1) = 2^{#V_L}
# 帰属: ZZ と ZZ[X]。浮動小数点は使わない。

from itertools import product

R.<X> = PolynomialRing(ZZ)


def box_vertices(box_side):
    return list(product(range(box_side), repeat=3))


def free_box_edges(box_side):
    vertices = set(box_vertices(box_side))
    edges = []
    for vertex in vertices:
        for direction in range(3):
            endpoint = list(vertex)
            endpoint[direction] += 1
            endpoint = tuple(endpoint)
            if endpoint in vertices:
                edges.append((vertex, endpoint))
    return edges


for box_side in [1, 2]:
    vertices = box_vertices(box_side)
    edges = free_box_edges(box_side)
    partition_polynomial = R.zero()
    for values in product([-1, 1], repeat=len(vertices)):
        configuration = dict(zip(vertices, values))
        broken_count = sum(
            1 for endpoint_u, endpoint_v in edges
            if configuration[endpoint_u] != configuration[endpoint_v]
        )
        partition_polynomial += X ** broken_count
    assert partition_polynomial(ZZ.one()) == ZZ(2) ** ZZ(len(vertices))
    print("PASS: L=%d で Z_L(1)=2^{#V_L}" % box_side)

print("RESULT: PASS")
