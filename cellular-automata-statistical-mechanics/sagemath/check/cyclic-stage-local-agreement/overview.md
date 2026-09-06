# SageMath 検算: 有限巡回群の族と有限段階の量の列

## 対象

**対象ラベル**: `claim_cyclic_stage_is_finite_cyclic_group`

- 併せて検証するラベル: `claim_cyclic_stage_projection_preserves_addition`、
  `claim_cyclic_stages_eventually_match_integer_window`、
  `claim_cyclic_stage_projection_not_globally_injective`、
  `def_cyclic_stage_global_map_family`、`def_cyclic_stage_fixed_point_count_sequence`、
  `def_cyclic_stage_positive_count_domain`、`def_cyclic_stage_logarithmic_count_sequence`。
- 有限剰余上の群演算、整数との有限窓上一致、固定した真理値表が定める有限自己写像の族、
  反復不動点数列と正値域上の素因数指数ベクトル値の列を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_projection_and_group_laws.sage` | 剰余加法の保存、群法則、生成元、全射性 | PASS | 整数対 180,024 件と周期 1..24 の全元三つ組で一致 |
| `check_finite_window_agreement.sage` | 閾値以後の有限窓上一致と大域単射でない境界 | PASS | 窓元対 14,625 件で一致し、周期 1..49 で非単射の証人を確認 |
| `check_fixed_point_count_sequence.sage` | 有限段階の大域写像と反復不動点数列 | PASS | 真理値表・周期・反復回数の組 6,240 件で一致 |
| `check_positive_domain_and_logarithmic_sequence.sage` | 正値域の分離、素因数指数ベクトル、零対数の不使用 | PASS | 正値 5,674 件を復元し、零値 566 件を対数から除外 |

## 範囲と限界

- 群法則は周期 1..24 の全元三つ組、加法保存は周期の前後三倍の整数対で検査する。
- 局所一致は半径 0..12、各閾値 `2s+1` から四段先までの全窓元対で検査し、
  周期 1..49 では整数零と周期が同じ剰余へ移ることを検査する。
- 量の列は半径 0 と 1 の全真理値表、周期 1..6、反復回数 1..4 を検査する。
  各正値は `ZZ` の素因数分解から有限台整数ベクトルへ移し、積へ戻して一致を判定する。
  零値が実際に現れることと、それらを対数の定義域から除外したことも検査する。
- これは明記した有限範囲のプログラミングによる検証であり、一般証明ではない。
  一般の場合の根拠は構造化記述の証明にある。有限集合、整数、自然数、有限台整数ベクトルだけを使い、
  浮動小数点、非単位の除算、実数体・複素数体、全配位空間、極限は使わない。

## 実行方法

```bash
for file in sagemath/check/cyclic-stage-local-agreement/check_*.sage; do sage "$file"; done
```
