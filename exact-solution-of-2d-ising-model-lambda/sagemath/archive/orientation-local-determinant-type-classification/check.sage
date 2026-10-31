"""均衡配向の局所遷移行列式の型分類を、辺長によらない全局所配置で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

頂点の局所遷移行列の成分は、入る動辺の方向と出る動辺の方向の差
（四半回転数）だけで決まり、継ぎ目の符号は列全体への +1/-1 の倍率として
掛かる。従って行列式の絶対値の分類は辺長・頂点の位置・ねじれに依存しない。
本検査は、一つの頂点のまわりの四つの枠（東・北・西・南の基底辺）に
「無し・二重辺・単純入・単純出」を割り当てた全ての釣り合い局所配置を列挙し、

  (1) 四枠すべてが単純辺で入方向が隣り合う曲がり型では行列式が零、
  (2) 四枠すべてが単純辺で入方向が向かい合う直進型では行列式が
      ±2·zeta8^2（絶対値 2）、
  (3) 単純辺が無く二重辺が奇数本（一本または三本）の配置でも行列式が零、
  (4) それ以外の全ての非空配置では行列式が zeta8 の冪の ±1 倍（絶対値 1）、
  (5) 列を任意の符号列 eps で倍率すると行列式がちょうど prod(eps) 倍になる
      （継ぎ目符号の作用はこれに含まれる）

ことを検査する。(3) の配置は、その頂点で単純次数が零なので、選択集合が
非空な鍵（selected を合わせて偶部分グラフにできる鍵）では二重次数の偶数性に
反して実現しない。従って選択非空な鍵の均衡配向類では、位相和が零になるのは
曲がり型頂点を持つ類にちょうど限られ、持たない類の絶対値は
2^(直進型の次数 4 頂点数) である。有限集合、整数、Q(zeta_8) の厳密演算だけを
使い、浮動小数点は使わない。
"""

K8 = CyclotomicField(8, "zeta8")
zeta8 = K8.gen()

# 枠 s in {0,1,2,3}: 頂点から方向 s へ伸びる基底辺。
# 枠 s の辺を頂点から出る向きにすると方向 s、頂点へ入る向きにすると方向 s+2。
STATUSES = ("none", "doubled", "in", "out")


def local_edges(statuses):
    incoming = []
    outgoing = []
    for slot, status in enumerate(statuses):
        if status == "doubled":
            incoming.append(slot)
            outgoing.append(slot)
        elif status == "in":
            incoming.append(slot)
        elif status == "out":
            outgoing.append(slot)
    return incoming, outgoing


def local_matrix(incoming, outgoing):
    rows = []
    for in_slot in incoming:
        row = []
        in_direction = (in_slot + 2) % 4
        for out_slot in outgoing:
            if out_slot == in_slot:
                row.append(K8(0))  # 同じ基底辺への後退は除外される
            else:
                turn = (out_slot - in_direction) % 4
                assert turn != 2  # 別の枠なら四半回転 2 は起こらない
                row.append({0: K8(1), 1: zeta8, 3: zeta8 ** (-1)}[turn])
        rows.append(row)
    return matrix(K8, rows)


roots_of_unity = [sign * zeta8 ** power
                  for sign in (K8(1), K8(-1)) for power in range(4)]

curved_configurations = ZZ(0)
straight_configurations = ZZ(0)
odd_doubled_configurations = ZZ(0)
unit_configurations = ZZ(0)
column_sign_checks = ZZ(0)

for statuses in cartesian_product([STATUSES] * 4):
    statuses = tuple(statuses)
    incoming, outgoing = local_edges(statuses)
    if len(incoming) != len(outgoing) or not incoming:
        continue
    single_in = [slot for slot in range(4) if statuses[slot] == "in"]
    single_out = [slot for slot in range(4) if statuses[slot] == "out"]
    assert len(single_in) == len(single_out)
    doubled_count = ZZ(sum(1 for status in statuses if status == "doubled"))
    single_count = ZZ(len(single_in) + len(single_out))

    determinant = local_matrix(incoming, outgoing).det()
    if single_count == 4:
        in_directions = sorted(((slot + 2) % 4) for slot in single_in)
        if (in_directions[1] - in_directions[0]) % 4 == 2:
            # 直進型: 入方向が向かい合う
            assert determinant in (2 * zeta8 ** 2, -2 * zeta8 ** 2)
            assert determinant * determinant.conjugate() == K8(4)
            straight_configurations += 1
        else:
            # 曲がり型: 入方向が隣り合う
            assert determinant == K8(0)
            curved_configurations += 1
    elif single_count == 0 and doubled_count % 2 == 1:
        # 単純次数零・二重次数奇数: 選択非空な鍵では偶数性に反して実現しない
        assert determinant == K8(0)
        odd_doubled_configurations += 1
    else:
        assert determinant in roots_of_unity
        assert determinant * determinant.conjugate() == K8(1)
        unit_configurations += 1

    for signs in cartesian_product([(K8(1), K8(-1))] * len(outgoing)):
        signed = local_matrix(incoming, outgoing)
        for column, sign in enumerate(signs):
            signed.set_column(column, sign * signed.column(column))
        assert signed.det() == prod(signs) * determinant
        column_sign_checks += 1

assert curved_configurations == 4      # 隣り合う入方向対 {d,d+1} の四通り
assert straight_configurations == 2    # 向かい合う入方向対 {0,2},{1,3} の二通り
assert odd_doubled_configurations == 8  # 二重辺一本の 4 通りと三本の 4 通り
assert unit_configurations > 0
print("PASS: 釣り合い局所配置 %d 件（曲がり型 %d、直進型 %d、奇数二重 %d、"
      "絶対値 1 の %d）を列挙し、行列式の型分類と列符号の倍率 %d 件を検査"
      % (curved_configurations + straight_configurations
         + odd_doubled_configurations + unit_configurations,
         curved_configurations, straight_configurations,
         odd_doubled_configurations, unit_configurations, column_sign_checks))
