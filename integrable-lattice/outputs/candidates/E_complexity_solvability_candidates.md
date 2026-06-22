# 方向 E 候補 — 複雑性 × 可解性の分類（cycle 0, 粗い）

Source map: `outputs/maps/E_complexity_solvability_map.md`。選別基準 (i)–(iv)。`resolved_risk: unchecked`。

```yaml
id: E-U1-integrable-models-table-placement
title: 可積分模型・境界の複雑性×可解性テーブル網羅配置（分類命題）
direction: E
model: 六頂点/RSOS/dimer/Potts × 各境界
target_quantity: (complexity, solvability) セルへの配置
home: 分類（複雑性は決定問題、可解性は文献事実）
candidate_statement: >
  主要な可積分格子模型・境界を (poly/#P) × (closed/none) テーブルへ網羅配置し、各セルの
  populated/empty を明示する分類命題。A-D で挙げた候補がどのセルに落ちるかも併記。
home_and_escape: 複雑性は有限の決定問題、可解性は極限（ℝ 側）の事実。分類自体は可算メタ。
decidable: 複雑性パートは決定問題
formal_verifiable: partial
finite_symbol_process: 既知の複雑性結果（Pfaffian/#P 困難）＋可解性文献の整理。
known_result_anchor: [07§2 テーブル, Istrail 2000, Onsager, Parisi]
missing_generalization: 可積分模型・境界の網羅的配置。
resolved_risk: unchecked
paper_potential: low
notes: 分類枠。cycle 1 で A-D を束ねる整理に効く。単体新規性は低。
```

```yaml
id: E-U3-boundary-flips-complexity-class
title: どの境界・幾何が poly→#P を反転させるかの同定
direction: E
model: 模型 × 境界（平面性の破れ・磁場・次元）
target_quantity: 複雑性クラスの反転境界
home: 複雑性（決定問題）
candidate_statement: >
  平面・無磁場で poly（Pfaffian）の Ising 型模型が、どの境界・幾何変更（非平面化・磁場・3D 化）で
  #P 困難へ反転するかを模型横断で同定する。
home_and_escape: 有限の計算複雑性（ℝ 不使用）。
decidable: 複雑性は決定問題
formal_verifiable: partial
finite_symbol_process: 既知 #P 困難性結果（Barahona, Istrail）の境界依存整理。
known_result_anchor: [E.K1, E.K3, Barahona 1982]
missing_generalization: 構造保存（C）が壊れる＝複雑性が上がる閾値の同定。
resolved_risk: unchecked
paper_potential: low
notes: C の複雑性版。境界が可算的可解性を壊す閾。
```
