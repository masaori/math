# SageMath Check: 223_lambda_eq_exp_gamma

## 対象

**対象ラベル**: `lambda_eq_exp_gamma` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.ts`

- 範囲: γ(θ_μ) := arccosh(γ₁(θ_μ)) と λ_± = e^{±γ}

<def_gamma_theta_mu> の well-defined 性（γ₁ ≥ 1）と、固有値が e^{±γ} になることを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arccosh.sage` | λ_± = e^{±γ}、cosh γ = γ₁、γ ≥ 0 | 1360 | 1.372e-13 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

平方根 √(−γ₂(θ)γ₂(−θ)) の中身は <relation_of_gamma_2> により厳密には非負実数（|γ₂|²）だが、倍精度では虚部に丸めが乗り、それが負側に出ると本プロジェクト定義の sqrt（偏角を [0,2π) で取って半分にする分枝）が符号を反転させてしまう。これは主張の誤りではなく浮動小数点の分枝跨ぎなので、`_shared/operators.sage` の `lambda_pm_of` で虚部が無視できるときは実軸へ落としている（理由はコードのコメントに明記）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 223
```

実行ログは `sagemath/check/223_lambda_eq_exp_gamma/logs/` に保存してある（この表の数値はそのログから取った）。
