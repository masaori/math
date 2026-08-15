# SageMath 検算: 既存因果構造との比較

## 対象

**対象ラベル**: `claim_order_interval_finite`

- 併せて検証: `claim_one_step_subset_covering`、`claim_covering_subset_one_step`、`claim_one_step_equals_covering`、`claim_order_iso_not_time_preserving`
- 検証範囲: 区間の有限性、一段依存関係と被覆関係の両包含および一致、順序を保つ全単射が時刻を保たない具体的反例
- 全数範囲: $|V|\leq2$、$0\leq\tau\leq2$ の隣接時刻間の全ての関係

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_interval_finiteness.sage` | 区間がイベント集合の部分集合で、個数が $(\tau+1)|V|$ 以下 | PASS | 283 関係の 9,521 区間で成立 |
| `check_one_step_subset_covering.sage` | 一段依存関係が被覆関係に含まれる | PASS | 283 関係の一段辺 1,061 本で成立 |
| `check_covering_subset_one_step.sage` | 被覆関係が一段依存関係に含まれる | PASS | 被覆対 1,061 組で成立し、一段辺でない到達可能対 449 組には中間点が存在 |
| `check_one_step_equals_covering.sage` | 一段依存関係と被覆関係が一致する | PASS | 283 関係で集合として一致 |
| `check_order_iso_not_time_preserving.sage` | 順序保存全単射が時刻を保存しない反例 | PASS | 2 イベント・4 順序対で順序保存、両イベントで時刻非保存 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、一般の有限舞台・任意の $\tau\in\mathbb{N}$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 一般側の検査対象を CA から得る関係より広い「隣接時刻間の任意の関係」とした。一段依存で時刻が一つ増える性質だけを使う。時刻非保存の反例だけは、構造化記述どおり一元舞台上の定値局所規則から構成する。
- 全て有限集合、有限関係、2 元状態、非負整数の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/causal-structure-comparison/check_*.sage; do sage "$file"; done
```
