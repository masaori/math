# 対象ラベル: claim_pointwise_collision_free_coarse_graining_family_is_sufficient
# 各箱 L ごとに与えた写像 tau_L が値の衝突を持たないとき、pi_L(q) := tau_L(S_q(L)) の族が
# 極限量に対して十分であること、すなわち「すべての L で pi_L(q)=pi_L(q')」から
# 「すべての L で S_q(L)=S_{q'}(L)」が従い、既存の橋の可算側の段
# （素指数データからの復元と Z_L(q)=Z_L(q')・#V_L の一致）へ渡ることを、証明と同順に確認する。
# 結論の alpha(q)=alpha(q') は実数の等式であり、既存主張
# claim_limit_quantity_depends_only_on_finite_box_sequence へ帰着するので検査対象外。
# 帰属: ZZ[X]、QQ、有限台の整数列だけを使う厳密計算。実数・極限・対数・浮動小数点は使わない。
from itertools import product

integer_polynomial_ring = PolynomialRing(ZZ, "X")
X = integer_polynomial_ring.gen()


def box_sites(box_side):
    return list(product(range(box_side), repeat=3))


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for start in sites:
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in sites:
                edges.append((start, end))
    return edges


def partition_polynomial(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    polynomial = integer_polynomial_ring.zero()
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        configuration = dict(zip(sites, values))
        broken_count = sum(ZZ(configuration[s] != configuration[e]) for s, e in edges)
        polynomial += X ** broken_count
    return polynomial


def prime_exponent_data(value):
    value = QQ(value)
    assert value > 0
    data = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        data[prime] = ZZ(exponent)
    for prime, exponent in ZZ(value.denominator()).factor():
        data[prime] = data.get(prime, ZZ(0)) - ZZ(exponent)
    return tuple(sorted((p, e) for p, e in data.items() if e != 0))


def reconstruct_from_prime_exponent_data(data):
    value = QQ(1)
    for prime, exponent in data:
        value *= QQ(prime) ** ZZ(exponent)
    return value


# 有限箱の列の第 L 項 S_q(L) = (#V_L, lambda(Z_L(q))) in N x Lambda。
def finite_box_sequence_entry(box_side, q):
    return (
        ZZ(len(box_sites(box_side))),
        prime_exponent_data(partition_polynomial(box_side)(QQ(q))),
    )


# 本文の仮定「tau_L が値の衝突を持たない」を満たす写像の候補。
# いずれも N x Lambda 上で単射であることを、検査に現れるデータの範囲で確かめる。
# 恒等写像
def tau_identity(entry):
    return entry


# 素指数データを、復元した正の有理数へ写す（復元の一意性から単射）
def tau_reconstruct(entry):
    return (entry[0], reconstruct_from_prime_exponent_data(entry[1]))


# 素指数データを分子と分母の対へ写す（正の有理数の既約表示は一意なので単射）
def tau_numerator_denominator(entry):
    value = reconstruct_from_prime_exponent_data(entry[1])
    return (entry[0], ZZ(value.numerator()), ZZ(value.denominator()))


COLLISION_FREE_MAPS = [
    ("恒等写像", tau_identity),
    ("素指数データからの復元", tau_reconstruct),
    ("既約表示の分子と分母の対", tau_numerator_denominator),
]

BOX_SIDES = [1, 2]

# 仮定「すべての L で pi_L(q)=pi_L(q')」を満たす有理点の対（同じ有理数の異なる表示）。
AGREEING_PAIRS = [(QQ(2) / 3, QQ(4) / 6), (QQ(5) / 7, QQ(10) / 14), (QQ(3), QQ(6) / 2)]
# 仮定を満たさない有理点の対（十分性の判定が空虚でないことの確認に使う）。
DISAGREEING_PAIRS = [(QQ(2) / 3, QQ(3) / 4), (QQ(2), QQ(5))]

RATIONAL_POINTS = [QQ(1) / 3, QQ(2) / 3, QQ(1), QQ(3) / 2, QQ(2), QQ(5), QQ(7) / 4]

for name, tau in COLLISION_FREE_MAPS:
    for box_side in BOX_SIDES:
        Z = partition_polynomial(box_side)
        realized = [finite_box_sequence_entry(box_side, q) for q in RATIONAL_POINTS]

        # 段 0: tau_L が値の衝突を持たないこと（検査に現れるデータの範囲で確認する）。
        images = [tau(entry) for entry in realized]
        for i in range(len(realized)):
            for j in range(len(realized)):
                if images[i] == images[j]:
                    assert realized[i] == realized[j]

        for q, q_prime in AGREEING_PAIRS:
            entry = finite_box_sequence_entry(box_side, q)
            entry_prime = finite_box_sequence_entry(box_side, q_prime)
            # 仮定: pi_L(q) = tau_L(S_q(L)) = tau_L(S_{q'}(L)) = pi_L(q')
            assert tau(entry) == tau(entry_prime)
            # 段 1: tau_L が衝突を持たないので S_q(L) = S_{q'}(L)
            assert entry == entry_prime
            # 段 2: 素指数データから正の有理数が一意に復元される
            assert reconstruct_from_prime_exponent_data(entry[1]) == Z(q)
            assert reconstruct_from_prime_exponent_data(entry_prime[1]) == Z(q_prime)
            # 段 3: したがって可算側の等式 Z_L(q)=Z_L(q') と #V_L の一致を得る
            #（ここから先の alpha(q)=alpha(q') は既存の橋へ帰着するので検査対象外）
            assert Z(q) == Z(q_prime) and Z(q) > 0
            assert entry[0] == entry_prime[0] == ZZ(len(box_sites(box_side)))

    for q, q_prime in DISAGREEING_PAIRS:
        # 判定が空虚でないこと: 列が異なる対では、ある L で粗視化の値も異なる（衝突を持たないため）。
        # L=1 は辺が無く Z_1 が定数なので、どの有理点でも項が一致する。差は L>=2 で現れる。
        differing = []
        for box_side in BOX_SIDES:
            entry = finite_box_sequence_entry(box_side, q)
            entry_prime = finite_box_sequence_entry(box_side, q_prime)
            if entry != entry_prime:
                assert tau(entry) != tau(entry_prime)
                differing.append(box_side)
            else:
                assert tau(entry) == tau(entry_prime)
        assert len(differing) > 0

    print(f"tau = {name}: L={BOX_SIDES}、一致する対 {len(AGREEING_PAIRS)} 組・"
          f"一致しない対 {len(DISAGREEING_PAIRS)} 組 PASS")

# 逆向きを主張しない理由の確認: 値の衝突を持つ tau_L であっても、衝突を与えるデータが
# 実際の族 {S_q(L)} に現れなければ、有理点上では衝突が観測されない。
def tau_with_unrealized_collision(entry):
    # 第 1 成分 #V_L を保ち、素指数データの値が 1 または 2 のときだけ潰す写像。
    value = reconstruct_from_prime_exponent_data(entry[1])
    if value in (QQ(1), QQ(2)):
        return (entry[0], "潰した")
    return (entry[0], value)


for box_side in BOX_SIDES:
    realized_values = [
        reconstruct_from_prime_exponent_data(finite_box_sequence_entry(box_side, q)[1])
        for q in RATIONAL_POINTS
    ]
    # この写像は N x Lambda 上では値の衝突を持つ（1 と 2 が同じ像へ行く）。
    collided = [
        (ZZ(len(box_sites(box_side))), prime_exponent_data(QQ(1))),
        (ZZ(len(box_sites(box_side))), prime_exponent_data(QQ(2))),
    ]
    assert collided[0] != collided[1]
    assert tau_with_unrealized_collision(collided[0]) == tau_with_unrealized_collision(collided[1])
    if box_side >= 2:
        # それでも実際の族 {S_q(L)} には衝突する二つの値がともには現れない。
        assert not (QQ(1) in realized_values and QQ(2) in realized_values)
    print(f"L={box_side}: 衝突を持つ写像でも有理点の族には衝突が現れない場合があること PASS")

print("ALL PASS")
