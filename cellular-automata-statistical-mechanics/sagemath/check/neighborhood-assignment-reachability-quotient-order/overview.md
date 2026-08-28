# SageMath 検算: 相互到達成分の商が定める有限半順序

## 対象

**対象ラベル**: `claim_neighborhood_mutual_reachability_component_order_finite_decidable`

- 併せて検証するラベル: `claim_neighborhood_mutual_reachability_component_nonempty`、
  `claim_neighborhood_mutual_reachability_component_representative`、
  `claim_neighborhood_mutual_reachability_component_order_representative_independent`、
  `claim_neighborhood_mutual_reachability_component_order_reflexive`、
  `claim_neighborhood_mutual_reachability_component_order_transitive`、
  `claim_neighborhood_mutual_reachability_component_order_antisymmetric`、
  `claim_neighborhood_mutual_reachability_component_order_is_partial_order`
- 本文の証明を、成分集合と代表、代表非依存性、半順序性、有限決定へ分け、最終結果だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_component_set_and_representatives.sage` | 成分の非空性と任意の元による代表 | PASS |
| `check_representative_independence.sage` | 存在する代表と全ての代表による到達の同値 | PASS |
| `check_partial_order_properties.sage` | 商上の関係の反射性・推移性・反対称性 | PASS |
| `check_finite_decidability.sage` | 成分数と所属判定回数の上界 | PASS |

## 検証範囲

- 舞台元数 `0 <= |V| <= 3` の全 531 近傍割り当てを検査する。
- これは有限範囲の全数検査であり、一般の有限舞台に対する証明ではない。一般の場合の根拠は構造化記述である。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、自然数の厳密等号と大小だけを使う。
  浮動小数点と `R/C` 脱出はない。
- 所属判定回数は、前章で構成済みの閉包表と成分表から、各成分の代表一組で商の関係表を書き下す本文の手続きを数える。実行時間のコストモデルは扱わない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-reachability-quotient-order/check_*.sage; do sage "$file"; done
```
