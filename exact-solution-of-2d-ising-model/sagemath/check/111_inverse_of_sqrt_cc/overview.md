# SageMath Check: 111_inverse_of_sqrt_cc

## 対象

**対象ラベル**: `inverse_of_sqrt_cc` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: √(1/z) と 1/√z の関係（<sqrt_cc_of_inverse> と同内容）

arg z = 0 のときだけ符号が一致し、それ以外では反転する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_inverse.sage` | 場合分けの両方 | 155 | 4.965e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<sqrt_cc_of_inverse> は同じ内容を (√z)^{-1} の側から述べたもので、同じ check で併せて確認している。

## 実行時に出力された観測値

```
  arg=0 の場合 3 件、0<arg<2pi の場合 73 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 111
```

実行ログは `sagemath/check/111_inverse_of_sqrt_cc/logs/` に保存してある（この表の数値はそのログから取った）。
