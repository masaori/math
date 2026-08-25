# SageMath 検算: 局所性による巡回型の制限

## 対象

**対象ラベル**: `claim_locality_restricts_cycle_type`

- 併せて検証するラベル: `claim_stage_global_maps_count`、`claim_stage_realized_cycle_types_decidable`、`claim_self_neighborhood_injective_iff_pointwise_bijective`、`claim_self_neighborhood_involution`、`claim_self_neighborhood_realized_cycle_types`
- 3 セル自己近傍舞台の全 64 局所規則族を走査し、大域写像の単射性、二回反復、巡回型の像、真部分集合性を本文の段ごとに検査する。
- 探索範囲を 1 セルから 5 セルまで広げ、全 1,364 局所規則族について自己近傍舞台の実現巡回型も列挙する。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_global_map_count.sage` | 局所規則族から大域写像への単射性と個数公式 | PASS |
| `check_pointwise_bijection_and_involution.sage` | 大域単射性と各セルの全単射性の同値、可逆写像の二回反復 | PASS |
| `check_realized_cycle_types.sage` | 3 セル舞台の実現巡回型二種、分割 `{{8}}` の非実現、真部分集合性 | PASS |
| `check_larger_self_neighborhood_stages.sage` | 1 セルから 5 セルの自己近傍舞台で実現される巡回型の列挙 | PASS |

## 限界と帰属

- 1 セルから 5 セルまでの有限範囲の全数検査であり、任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、自然数、有限多重集合の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/locality-restricts-cycle-type/check_*.sage; do sage "$file"; done
```
