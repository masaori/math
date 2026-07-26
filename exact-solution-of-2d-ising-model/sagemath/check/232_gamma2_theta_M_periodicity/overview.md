# SageMath Check: 232_gamma2_theta_M_periodicity

## 対象

**対象ラベル**: `gamma2_theta_M_periodicity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`

- 範囲: γ₂(θ_M) = γ₂(θ_{−M})、γ₂(−θ_M) = γ₂(−θ_{−M})

θ_M = 2π、θ_{−M} = −2π で cos, sin が一致することが根拠。γ₁ についても同様に確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_periodicity.sage` | 周期性と根拠となる三角関数の一致 | 250 | 1.021e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 232
```

実行ログは `sagemath/check/232_gamma2_theta_M_periodicity/logs/` に保存してある（この表の数値はそのログから取った）。
