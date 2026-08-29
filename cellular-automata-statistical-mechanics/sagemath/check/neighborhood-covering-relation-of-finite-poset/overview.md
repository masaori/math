# SageMath 検算: 有限半順序の被覆関係と被覆近傍割り当てによる生成

## 対象

**対象ラベル**: `claim_finite_poset_covering_relation_finite_decidable`

- 併せて検証するラベル: `claim_finite_poset_interval_endpoints`、
  `claim_finite_poset_interval_strictly_smaller`、
  `claim_covering_neighborhood_assignment_included`、
  `claim_covering_neighborhood_assignment_generates`、
  `claim_covering_neighborhood_assignment_closure_eq`、
  `claim_covering_neighborhood_assignment_reachability_eq`
- 本文の証明を、区間、被覆近傍割り当て、閉包による生成、閉包の等号、到達関係、有限決定へ分け、最終結果だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_interval_endpoints_and_strict_decrease.sage` | 区間の両端所属と、中間元で分けた区間の真包含・元数減少 | PASS |
| `check_covering_assignment_inclusion.sage` | 被覆近傍割り当ての点ごとの包含 | PASS |
| `check_generation_by_covering_assignment.sage` | 部分順序の各対が被覆辺の閉包で到達可能 | PASS |
| `check_closure_equality.sage` | 被覆近傍割り当ての閉包と部分順序近傍割り当ての両包含・等号 | PASS |
| `check_reachability_equality.sage` | 被覆近傍割り当ての到達関係と部分順序の一致 | PASS |
| `check_finite_decision.sage` | 被覆関係の全組走査と、各組の所属・等号判定回数の上界 | PASS |

## 検証範囲

- 舞台元数 `0 <= |V| <= 4` の全 243 個のラベル付き有限半順序を検査する。
- これは有限範囲の全数検査であり、任意の有限半順序に対する一般証明ではない。一般の場合の根拠は構造化記述である。

## 限界と帰属

- 有限集合、有限関係、有限写像表、自然数の厳密等号と大小だけを使う。浮動小数点と `R/C` 脱出はない。
- 判定回数は、各組につき関係への所属判定・舞台元の等号判定とも `2|V|+1` 回以下、組の走査は `|V|^2` 回である。実行時間のコストモデルは扱わない。
- 推移簡約の包含最小性・一意性と、被覆関係全体の分類は検証対象に含めない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-covering-relation-of-finite-poset/check_*.sage; do sage "$file"; done
```
