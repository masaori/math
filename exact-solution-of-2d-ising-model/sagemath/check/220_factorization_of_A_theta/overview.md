# SageMath Check: 220_factorization_of_A_theta

## 対象

**対象ラベル**: `factorization_of_A_theta` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: A(θ_μ) = B₁(θ_μ)B₂B₁(θ_μ)

既存の `017_claim_T_V_hatZ_hatY` は同じ行列積を `T_V_hatZ_hatY` ラベルで見ているが、こちらは `factorization_of_A_theta` ラベルの主張として独立に張る。M は 2,3,4,8,16、パラメータには**臨界点ちょうどに乗せた 4 組**を含む。積の順序を変えると一致しないことも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_B1B2B1.sage` | 行列積と順序の必要性 | 670 | 4.853e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

臨界点は K₂ を決めて K₁ = arcsinh(1/sinh 2K₂)/2 として厳密に乗せている（既存の 0.4407 は近似値）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 220
```

実行ログは `sagemath/check/220_factorization_of_A_theta/logs/` に保存してある（この表の数値はそのログから取った）。
