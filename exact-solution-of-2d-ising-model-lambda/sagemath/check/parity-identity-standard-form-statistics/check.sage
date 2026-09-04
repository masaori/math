"""標準形の四寄与を鍵の幾何統計の F_2 線型式で表せるかを探索する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

標準形（各辺連結成分の最小辺の向きを 0 に固定した曲がり型なし均衡配向）の
四寄与（動辺数・内部辺対・切断線辺対・局所位相）は、巻き付き偶奇二つと
交差対だけからは個別に決まらない（反例で固定済み）。そこで鍵 (D,E) から
機械的に計算できる幾何統計の候補基底を並べ、一辺二の全対象と一辺三の
D=empty の自明文字対象の全データについて、各寄与がその F_2 線型結合で
書けるかを厳密に解く。書ける寄与についてはその係数（統計の名前つき）を、
書けない寄与についてはその事実を記録する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は
使わない。
"""

load("sagemath/check/parity-identity-standard-form-statistics/construction.sage")

count_two = len(rows)

count_three = len(rows) - count_two

matrix_gf2 = matrix(GF(2), rows)
piece_names = ["動辺数", "内部辺対", "切断線辺対", "局所位相"]
targets = {}
for index, piece_name in enumerate(piece_names):
    targets[piece_name] = vector(
        GF(2), [pieces[index] for pieces in piece_columns])
targets["内部辺対+局所位相"] = (
    targets["内部辺対"] + targets["局所位相"])
targets["切断線辺対+局所位相"] = (
    targets["切断線辺対"] + targets["局所位相"])
targets["内部辺対+切断線辺対"] = (
    targets["内部辺対"] + targets["切断線辺対"])
targets["総和"] = sum(targets[piece_name] for piece_name in piece_names)

solvable = {}
formulas = {}
for target_name, target in sorted(targets.items()):
    try:
        solution = matrix_gf2.solve_right(target)
        kernel_rank = matrix_gf2.right_kernel().dimension()
        terms = [names[i] for i in range(len(names)) if solution[i] == 1]
        solvable[target_name] = True
        formulas[target_name] = (terms, kernel_rank)
        print("FIT: %s = %s (解空間の自由度 %d)"
              % (target_name, " + ".join(terms) if terms else "0", kernel_rank))
    except ValueError:
        solvable[target_name] = False
        print("NOFIT: %s は候補統計の F_2 線型結合で書けない" % target_name)

assert solvable["総和"]
assert solvable["動辺数"]
assert targets["動辺数"] == matrix_gf2.column(names.index("|E|"))
for target_name in ("内部辺対", "切断線辺対", "局所位相",
                    "内部辺対+局所位相", "切断線辺対+局所位相",
                    "内部辺対+切断線辺対"):
    assert not solvable[target_name]

print("PASS: 標準形の四寄与のうち候補統計の F_2 線型結合で書けるのは"
      "動辺数（=|E|）と総和だけで、残る三寄与とその二寄与和は書けない"
      "（一辺二 %d 鍵、一辺三 %d 鍵、候補統計 %d 本）"
      % (count_two, count_three, len(names)))
