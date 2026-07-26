# SageMath Check: 221_det_A_theta

## 対象

**対象ラベル**: `det_A_theta` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`

- 範囲: det A(θ_μ) = 1、γ₁² + γ₂(θ)γ₂(−θ) = 1、λ₊λ₋ = 1

行列式を直接計算した側と、γ から組んだ側の 2 経路。λ₊+λ₋ = 2γ₁ も併せて確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_det.sage` | 3 つの等式と固有値の和 | 2640 | 2.170e-13 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 221
```

実行ログは `sagemath/check/221_det_A_theta/logs/` に保存してある（この表の数値はそのログから取った）。
