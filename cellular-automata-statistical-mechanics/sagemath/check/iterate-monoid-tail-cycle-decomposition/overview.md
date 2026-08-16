# SageMath 検算: 反復モノイドの過渡部と巡回部への分解

## 対象

**対象ラベル**: `claim_iterate_monoid_transient_cycle_partition_cardinality`

- 併せて検証するラベル: `def_iterate_monoid_transient_and_cycle_parts`、`claim_iterate_monoid_no_collision_before_min_start`、`claim_iterate_monoid_stable_tail_equals_cycle_part`、`claim_iterate_monoid_cycle_part_pairwise_distinct`、`claim_iterate_monoid_transient_cycle_finite_decidability`
- 検証範囲: 最小衝突開始位置より前の非衝突、過渡部と安定後尾の非交差、安定後尾の最小正周期一周期分への還元と相異性、反復モノイドの非交和、元数公式、有限真理値表からの走査
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_no_collision_before_start.sage` | `a <= b < μ_F` で `F^a = F^b iff a = b`、および `a < μ_F <= n` で `F^a != F^n` | PASS | 769 写像・過渡部内 772 組・過渡部と安定後尾 2,386 組で成立 |
| `check_stable_tail_one_period.sage` | 安定後尾を除法で一周期分へ還元し、一周期の各反復写像が相異なること | PASS | 769 写像・還元 6,955 件・相異なる対 1,247 組で成立 |
| `check_partition_cardinality.sage` | `P_F = T_F sqcup C_F`、`|T_F| = μ_F`、`|C_F| = λ_F`、`|P_F| = μ_F + λ_F` | PASS | 769 写像・反復モノイド元 2,062 個で成立 |
| `check_finite_decidability.sage` | 後尾集合の最初の安定から `μ_F`、正周期の逐次走査から `λ_F` を求め、二部分と元数を列挙すること | PASS | 769 写像・真理値表比較 2,831 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 安定後尾の全量化は、最初の衝突後に新しい反復写像が現れないことを使って有限範囲へ限った検算である。普遍的な還元の根拠は人手証明である。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減・除法・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-tail-cycle-decomposition/check_*.sage; do sage "$file"; done
```
