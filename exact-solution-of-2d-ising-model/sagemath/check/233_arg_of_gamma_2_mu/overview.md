# SageMath Check: 233_arg_of_gamma_2_mu

## 対象

**対象ラベル**: `arg_of_gamma_2_mu` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`

- 範囲: arg^[0,2π)(γ₂(θ_μ)γ₂(−θ_μ)) = π

積が負の実数であることを直接確認したうえで偏角を見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arg_pi.sage` | 偏角 = π と積が負の実数であること | 1240 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 233
```

実行ログは `sagemath/check/233_arg_of_gamma_2_mu/logs/` に保存してある（この表の数値はそのログから取った）。
