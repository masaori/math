# SageMath Check: 底の冪から一を引いた数の整除

## 対象

**対象ラベル**: `claim_power_minus_one_divides_multiple_exponent`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 自然数倍した指数についての帰納法の基底、指数法則、分解、整除の証人の更新

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_base_case.sage` | 帰納法の基底 `c^(n*0)-1=(c^n-1)*0` | PASS | `ZZ` 上の有限標本で一致 |
| `check_exponent_addition.sage` | `n(k+1)=nk+n` と同じ底の冪の積 | PASS | `ZZ` 上の有限標本で一致 |
| `check_induction_decomposition.sage` | `c^(n(k+1))-1=c^(nk)(c^n-1)+(c^(nk)-1)` | PASS | `ZZ` 上の有限標本で一致 |
| `check_induction_witness.sage` | `t_(k+1)=c^(nk)+t_k` による整除証人の更新 | PASS | `ZZ` 上の有限標本で一致 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。四検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/power-minus-one-divides-multiple-exponent/check_*.sage; do sage "$f"; done
```
