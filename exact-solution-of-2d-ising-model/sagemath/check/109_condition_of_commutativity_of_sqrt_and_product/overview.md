# SageMath Check: 109_condition_of_commutativity_of_sqrt_and_product

## 対象

**対象ラベル**: `condition_of_commutativity_of_sqrt_and_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: √(z₁z₂) = ±√z₁√z₂ の場合分け
- 範囲（2026-11-14 に足した）: `r_1 = 0` の場合の `(0,0)·√z_2 = (0,0)` の鎖の各行（`check_zero_factor_chain.sage`）

arg z₁ + arg z₂ が 2π 未満かどうかで符号が変わる。**境界 arg z₁+arg z₂ = 2π ちょうど**を踏むサンプル（単位円上で t と 2π−t を取る）を明示的に入れている。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_sqrt_product.sage` | 場合分けの両方と境界 | 1204 | 7.081e-16 | **PASS** |
| — | `check_zero_factor_chain.sage` | `r_1 = 0` の場合の鎖 `(0,0)·√z_2 = 0_ℂ√z_2 = 0_ℂ = (0,0)` の 3 個の等号。ℂ を実数の組とし `definition_of_cc` の積と `ι(r) = (r,0)` を成分どおりに書き、`√z_2` の成分を `QQ[c, d]` の不定元に置いた厳密計算。否定コントロール: `1_ℂ` を掛けると `(0,0)` にならない | 4 | 0（厳密） | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（check_01。`check_zero_factor_chain.sage` は厳密計算で許容誤差を使わない）。

## 備考

境界ちょうどでは倍精度の丸めでどちらの分岐に落ちるかが定まらないため、そこでは ± のいずれかに一致することだけを判定している。

## 実行時に出力された観測値

```
  境界 t=0.300000000000000: arg1+arg2=6.283185307180, sqrt(z1z2)-sqrt z1 sqrt z2 = 1.442e-16, 和 = 2.000e+00
  境界 t=1.00000000000000: arg1+arg2=6.283185307180, sqrt(z1z2)-sqrt z1 sqrt z2 = 7.688e-19, 和 = 2.000e+00
  境界 t=2.00000000000000: arg1+arg2=6.283185307180, sqrt(z1z2)-sqrt z1 sqrt z2 = 2.512e-17, 和 = 2.000e+00
  境界 t=3.00000000000000: arg1+arg2=6.283185307180, sqrt(z1z2)-sqrt z1 sqrt z2 = 4.080e-18, 和 = 2.000e+00
  第1の場合 750 件、第2の場合 449 件、境界近傍 30 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 109
```

実行ログは `sagemath/check/109_condition_of_commutativity_of_sqrt_and_product/logs/` に保存してある（この表の数値はそのログから取った）。
