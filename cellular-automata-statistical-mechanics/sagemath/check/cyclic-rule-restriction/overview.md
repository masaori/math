# SageMath 検算: 周期境界で重なる近傍入力と一様規則表の制限

## 対象

**対象ラベル**: `claim_cyclic_rule_global_equality`

- 併せて検証するラベル: `claim_cyclic_offset_collision`、`claim_cyclic_offset_image_count`、
  `claim_cyclic_offset_injective_boundary`、`claim_cyclic_input_pullback_bijection`、
  `claim_cyclic_input_realization`、`claim_cyclic_admissible_input_count`、
  `claim_cyclic_rule_table_count`、`claim_cyclic_uniform_global_count`、
  `claim_cyclic_rule_realization_fiber_count`、`claim_cyclic_elementary_encoding_bijection`、
  `claim_cyclic_radius_one_comparison`、`claim_cyclic_radius_one_collapse`。
- 整数オフセットの有限巡回舞台への射影、重複と両立する入力、真理値表の制限、
  異なる大域写像と実現繊維の個数、半径一の初等規則との比較を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_offset_projection.sage` | オフセットの衝突と周期による整除の同値、像の元数、単射境界、短周期の明示衝突 | PASS | 周期1..12、半径0..8、全セル・全オフセット対で一致 |
| `check_input_pullback_and_realization.sage` | 重複を除いた近傍値との全単射、両立入力が全配位から全て実現すること | PASS | 周期1..8・半径0..4の全近傍値、周期1..6の全配位で一致 |
| `check_global_equality.sage` | 両立入力上の制限と大域写像が同じ表の同値類を定めること | PASS | 半径0・1、周期1..6の全表で一致 |
| `check_table_global_and_fiber_counts.sage` | オフセット表、両立入力、異なる大域写像、同じ写像を与える表の個数 | PASS | 半径0・1、周期1..6の全表で公式と一致 |
| `check_elementary_encoding_and_comparison.sage` | 規則番号と半径一表の全単射、左・自身・右の評価、一・二セルでの潰れ | PASS | 256規則、周期1..6の全配位で一致 |

## 結果と限界

- 周期と半径の明示範囲では、オフセット像の元数は `min(L, 2r+1)`、両立入力は
  `2^min(L, 2r+1)` 個だった。半径一の256表は、一セルで4写像（各繊維64表）、
  二セルで16写像（各繊維16表）、三セル以上で256写像（各繊維1表）へ分かれた。
- 半径二以上では表の総数が急増するため、射影・両立入力・引き戻しは半径四または八まで検査したが、
  表全体の走査は半径零と一に限った。これは明記した有限範囲の全数検査であり、一般証明ではない。
  一般の場合の根拠は構造化記述の証明にある。
- 有限集合、有限写像表、整数の剰余、自然数の個数だけを使う。浮動小数点は使わず、
  実数体・複素数体への脱出はない。

## 実行方法

```bash
for file in sagemath/check/cyclic-rule-restriction/check_*.sage; do sage "$file"; done
```
