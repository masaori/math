"""成分反転で内部側と切断線側の偶奇変化が相殺することを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

曲がり型なし均衡配向 o の一つの辺連結成分 K を全反転した配向を o^K と
する。動辺数は変わらない。偶奇恒等式の左辺を

  動辺数 + 内部辺対 + 切断線辺対 + 局所位相

へ分けた前段の分解に対して、内部側（動辺数 + 内部辺対 + 局所位相）の
変化と切断線辺対の変化が F_2 で等しいことを検査する。従って両変化は
全体では二度現れて相殺する。

一辺二の全対象と一辺三の D=empty の自明文字対象について、全ての
曲がり型なし均衡配向と全ての辺連結成分を調べる。有限集合、F_2、整数、
Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-component-reversal-cancellation/construction.sage")

assert checks_two > 0 and checks_three > 0
assert changing_two > 0 and changing_three > 0
print("PASS: 成分反転で内部側と切断線側の偶奇変化が相殺"
      "（一辺二 %d 反転・非零変化 %d 件、一辺三 %d 反転・非零変化 %d 件）"
      % (checks_two, changing_two, checks_three, changing_three))
