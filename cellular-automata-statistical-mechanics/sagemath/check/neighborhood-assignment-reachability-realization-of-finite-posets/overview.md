# SageMath 検算: 有限半順序の相互到達成分商としての実現

## 対象

**対象ラベル**: `claim_partial_order_quotient_realization_finite_decidable`

- 併せて検証するラベル: `claim_partial_order_neighborhood_assignment_reflexive`、
  `claim_partial_order_neighborhood_assignment_transitive`、
  `claim_partial_order_neighborhood_assignment_closure_eq`、
  `claim_partial_order_neighborhood_assignment_preorder_eq`、
  `claim_partial_order_neighborhood_assignment_component_singleton`、
  `claim_partial_order_neighborhood_assignment_quotient_singletons`、
  `claim_partial_order_quotient_realization_map_bijective`、
  `claim_partial_order_quotient_realization_order`
- 本文の証明を、近傍割り当てと閉包、相互到達成分と商、実現写像、有限構成へ分け、最終結果だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_assignment_closure_and_reachability.sage` | 自己近傍性・推移性・閉包との一致・到達関係との一致 | PASS |
| `check_singleton_components_and_quotient.sage` | 相互到達成分の一元性と商の一元集合表示 | PASS |
| `check_realization_bijection_and_order.sage` | 実現写像の全単射性と順序の両方向の保存 | PASS |
| `check_finite_construction.sage` | 関係表からの近傍割り当て・商・実現写像の有限構成 | PASS |

## 検証範囲

- 舞台元数 `0 <= |V| <= 4` の全 243 個のラベル付き有限半順序を検査する。
- これは有限範囲の全数検査であり、任意の有限半順序に対する一般証明ではない。一般の場合の根拠は構造化記述である。

## 限界と帰属

- 有限集合、有限関係、有限写像表、自然数の厳密等号と大小だけを使う。
  浮動小数点と `R/C` 脱出はない。
- 有限構成の検算は、本文の手続きどおり関係への所属を `|V|^2` 回判定し、一元集合を `|V|` 回書き出す。実行時間のコストモデルは扱わない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-reachability-realization-of-finite-posets/check_*.sage; do sage "$file"; done
```
