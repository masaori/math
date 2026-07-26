# SageMath Check: 104_arg_of_product_of_complex_numbers

## 対象

**対象ラベル**: `arg_of_product_of_complex_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.mjs`

- 範囲: arg^[0,2π)(z₁z₂) の 2 通りの場合分け

代表元 θ₁,θ₂ と n₁,n₂ から θ₁+θ₂−2(n₁+n₂)π がどちらの区間に入るかを判定し、対応する式と突き合わせる。両方の場合を実際に踏んでいることをカウントで確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arg_product.sage` | 場合分けの両方 | 1226 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

比較は 2π を法とする円周上の距離で行う（0 と 2π の同一視のため）。

## 実行時に出力された観測値

```
  第1の場合 794 件、第2の場合 431 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 104
```

実行ログは `sagemath/check/104_arg_of_product_of_complex_numbers/logs/` に保存してある（この表の数値はそのログから取った）。
