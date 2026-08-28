# SageMath Check: 第二の極限量候補は無限個の有限箱量を持つ

## 対象

**対象ラベル**: `claim_second_limit_quantity_candidate_has_infinite_range`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_second_limit_quantity_candidate_has_infinite_range`）
- 範囲: 対偶の両端。すなわち有理点 1 以外の有限標本で値の集合が一点でないこと（結論の必要条件が実際に成り立つ側）と、
  有理点 1 では値の集合が一点であること（仮定 $q\ne1$ が落とせない側）
- 併せて検証: `claim_finitely_many_values_limit_quantity_only_at_one`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_off_one_value_set_is_not_a_singleton.sage` | 有理点 1 以外の有限標本で一辺 1 と 2 の量が相異なり、値の集合が一点でないこと | PASS | `RESULT: PASS` |
| `check_at_one_the_hypothesis_off_one_is_needed.sage` | 有理点 1 では値の集合が一点であり、仮定 $q\ne1$ が外せないこと | PASS | `RESULT: PASS` |

## 備考

- 二つの箱の量が等しいことは、根を作らずに交差冪の有理数等式 $Z_L(q)^{\#V_{L'}}=Z_{L'}(q)^{\#V_L}$ で判定する（本文で既出の同値）。`QQ` の中で閉じる。
- 値の集合が無限集合であること・極限量の存在そのものは無限個の箱にわたる主張なので SageMath の有限検査対象外であり、本文と Lean の検証対象である。有限検査で確かめられるのは、結論の必要条件（値の集合が一点でないこと）と仮定の必要性である。
- 全配位を列挙できる一辺 1 と 2 の箱で行う（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。有理点 1 以外の標本は有限にとどめる。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

実行日: 2026-08-28。2 ファイルとも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/second-limit-quantity-candidate-has-infinite-range/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done
```
