# SageMath Check: 199_calc_of_TxT_hatZxhatY

## 対象

**対象ラベル**: `calc_of_TxT_hatZxhatY` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: (T×T)(hatZ^{(−)}, hatY) = (hatZ^{(−)}, hatY)·B の行列表示 B₁(θ_μ), B₂

共役の結果を hatZ^{(−)}, hatY の線型結合として展開し、その係数が B₁, B₂ の各列と一致することを確認する。T の線型性も併せて見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_matrix_form.sage` | B₁, B₂ の各列と T の線型性 | 432 | 2.212e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 199
```

実行ログは `sagemath/check/199_calc_of_TxT_hatZxhatY/logs/` に保存してある（この表の数値はそのログから取った）。
