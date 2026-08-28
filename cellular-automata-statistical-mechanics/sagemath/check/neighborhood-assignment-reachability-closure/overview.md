# SageMath 検算: 近傍割り当ての反射推移閉包

## 対象

**対象ラベル**: `claim_reflexive_transitive_closure_minimal`

- 併せて検証するラベル: `claim_reachability_approximation_monotone`、
  `claim_reachability_approximation_recursion`、`claim_reachability_approximation_stable_forever`、
  `claim_reachability_approximation_stabilizes`、`claim_composition_power_included_in_closure`、
  `claim_composition_power_additive`、`claim_reflexive_transitive_closure_reflexive`、
  `claim_reflexive_transitive_closure_contains_original`、`claim_reflexive_transitive_closure_transitive`、
  `claim_reflexive_transitive_closure_idempotent`、`claim_reflexive_transitive_closure_finite_decidable`
- 本文の証明を、有限近似と安定、合成冪と閉包の性質、最小性、有限決定へ分け、
  最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_approximation_and_stabilization.sage` | 増大性、再帰式、所属総数、二乗上界、安定の永続 | PASS |
| `check_power_and_closure_properties.sage` | 合成冪の加法則・包含、反射性、元の包含、推移性、冪等性 | PASS |
| `check_minimality.sage` | 条件を満たす全ての上界に対する最小性 | PASS |
| `check_finite_decidability.sage` | 有限構成と所属判定回数の上界 | PASS |

## 検証範囲

- 舞台元数 `0 <= |V| <= 3` の全 531 近傍割り当てを検査する。
- 最小性は、同じ範囲で自己近傍を含み推移的な全候補との組を検査する。
- 最小性では割り当てと候補の 14,915 組を走り、仮定を満たす上界 2,095 組を検査した。
- これは有限範囲の全数検査であり、一般の場合の根拠は構造化記述の証明である。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、自然数の厳密等号と大小だけを使う。
  浮動小数点と `R/C` 脱出はない。
- 所属判定回数は、既に得た有限集合を列挙し、次近傍への所属だけを判定する本文の手続きを数える。
  実行時間のコストモデルは扱わない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-reachability-closure/check_*.sage; do sage "$file"; done
```
