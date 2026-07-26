# SageMath Check: 230_A_theta_is_identity_when_gamma2_zero

## 対象

**対象ラベル**: `A_theta_is_identity_when_gamma2_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.ts`

- 範囲: γ₂(θ_μ) = 0 ⟹ A(θ_μ) = I

臨界点ちょうどに乗せたパラメータで μ = ±M を取ると実際に γ₂ = 0 になることを確認し、そこで A = I かつ γ₁ = 1 であることを見る。非臨界点では μ = M でも γ₂ ≠ 0 であることも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_identity.sage` | γ₂=0 の事例での A = I と、非臨界点での対比 | 103 | 3.847e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

γ₂ = 0 を実際に踏んだ事例数を出力している（踏めていなければ検証になっていないため）。

## 実行時に出力された観測値

```
  gamma_2 = 0 を実際に踏んだ事例: 32 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 230
```

実行ログは `sagemath/check/230_A_theta_is_identity_when_gamma2_zero/logs/` に保存してある（この表の数値はそのログから取った）。
