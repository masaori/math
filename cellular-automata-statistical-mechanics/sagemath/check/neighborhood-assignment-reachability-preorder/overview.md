# SageMath 検算: 到達前順序と相互到達成分

## 対象

**対象ラベル**: `claim_neighborhood_reachability_preorder_finite_decidable`

- 併せて検証するラベル: `claim_neighborhood_reachability_preorder_reflexive`、
  `claim_neighborhood_reachability_preorder_transitive`、
  `claim_neighborhood_reachability_preorder_not_antisymmetric`、
  `claim_neighborhood_mutual_reachability_reflexive`、
  `claim_neighborhood_mutual_reachability_symmetric`、
  `claim_neighborhood_mutual_reachability_transitive`、
  `claim_neighborhood_mutual_reachability_component_membership`、
  `claim_neighborhood_mutual_reachability_component_self_transpose`、
  `claim_neighborhood_mutual_reachability_components_partition`
- 本文の証明を、到達前順序、反対称性の反例、相互到達の同値性、成分の表現と分割、有限決定へ分け、
  最終結果だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_preorder_properties.sage` | 到達関係の反射性と推移性 | PASS |
| `check_antisymmetry_counterexample.sage` | 二元舞台の明示反例と反対称性の破れ | PASS |
| `check_mutual_reachability_equivalence.sage` | 相互到達関係の反射性・対称性・推移性 | PASS |
| `check_components_and_partition.sage` | 成分の所属特徴づけ・自己転置性・被覆性・交差時の一致 | PASS |
| `check_finite_decidability.sage` | 有限表構成と所属判定回数の上界 | PASS |

## 検証範囲

- 舞台元数 `0 <= |V| <= 3` の全 531 近傍割り当てを検査する。
- 反対称性の否定は、本文が定義した二元舞台の一つの証人を全ての順序対について検査する。
- これは有限範囲の全数検査であり、一般の有限舞台に対する証明ではない。一般の場合の根拠は構造化記述である。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、自然数の厳密等号と大小だけを使う。
  浮動小数点と `R/C` 脱出はない。
- 所属判定回数は、前章で構成済みの閉包表を使って到達関係と成分表を書き下す本文の手続きを数える。
  実行時間のコストモデルは扱わない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-reachability-preorder/check_*.sage; do sage "$file"; done
```
