# SageMath Check: 251_def_transfer_matrix

## 対象

**対象ラベル**: `def_transfer_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.ts`

- 範囲: V₁ が対角、V₂ が対称、成分が正、サイズが 2^N×2^N、および全成分の値

転送行列の全成分を定義式から独立に計算して突き合わせる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_transfer_matrix_sanity.sage` | 構造の性質と全成分 | 1137 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

別セッションが「V₁ の行内結合は J′、V₂ の行間結合は J」と訂正した後の定義に従って実装している。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 251
```

実行ログは `sagemath/check/251_def_transfer_matrix/logs/` に保存してある（この表の数値はそのログから取った）。
