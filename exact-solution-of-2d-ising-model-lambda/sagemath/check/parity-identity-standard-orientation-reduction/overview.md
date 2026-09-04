# 偶奇恒等式の標準形配向への帰着

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

各辺連結成分の最小辺の向きを 0 に固定した曲がり型なし均衡配向を標準形と
呼ぶ。標準形は各鍵で一意に存在し、任意の曲がり型なし均衡配向は標準形との
不一致辺集合が成分の合併になり、その成分を一つずつ全反転する列で標準形へ
到達する。成分反転は偶奇恒等式の左辺を変えない（相殺の検算で固定済み）
ので、恒等式の成立は標準形での評価へ帰着する。標準形での左辺が標的
$\varepsilon_{L,\mathrm h}(E)+\varepsilon_{L,\mathrm v}(E)
+\varepsilon_{L,\mathrm h}(E)\varepsilon_{L,\mathrm v}(E)
+\langle D\cup C_0,E\rangle$ に一致することも併せて検査した。

- 実行: `sage sagemath/check/parity-identity-standard-orientation-reduction/check.sage`
- 状態: PASS（2026-09-04。一辺二 738 配向・一辺三 1,522 配向を標準形へ還元）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
