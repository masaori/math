# SageMath Check: 有限個の値しかとらず極限量を持つ正の有理点は 1 に限られる

## 対象

**対象ラベル**: `claim_finitely_many_values_limit_quantity_only_at_one`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_finitely_many_values_limit_quantity_only_at_one`）
- 範囲: 合成の両端。すなわち有理点 1 で有限箱の量の値の集合が一点になること（前提が満たされる側）と、
  有理点 1 以外の有限標本で量が既に相異なること（末尾定数性が成り立たず、合成の対偶が働く側）
- 併せて検証: `claim_finitely_many_values_gives_eventually_constant`、`claim_eventually_constant_only_at_one`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_at_one_the_value_set_is_a_singleton.sage` | 有理点 1 で一辺 1 と 2 の量が一致し、分配多項式の値が 2 の点数乗であること | PASS | `RESULT: PASS` |
| `check_off_one_values_already_differ.sage` | 有理点 1 以外の有限標本で一辺 1 と 2 の量が既に相異なること、および有理点 1 では一致すること | PASS | `RESULT: PASS` |

## 備考

- 二つの箱の量が等しいことは、根を作らずに交差冪の有理数等式 $Z_L(q)^{\#V_{L'}}=Z_{L'}(q)^{\#V_L}$ で判定する（本文で既出の同値）。`QQ` の中で閉じる。
- 値域が有限集合であること・極限量の存在・末尾定数性そのものは無限個の箱にわたる主張なので SageMath の有限検査対象外であり、本文と Lean の検証対象である。
- 全配位を列挙できる一辺 1 と 2 の箱で行う（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。有理点 1 以外の標本は有限にとどめる。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

実行日: 2026-08-28。2 ファイルとも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/finitely-many-values-limit-quantity-only-at-one/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done
```
