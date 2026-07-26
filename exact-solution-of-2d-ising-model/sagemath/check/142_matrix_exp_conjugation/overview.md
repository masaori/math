# SageMath Check: 142_matrix_exp_conjugation

## 対象

**対象ラベル**: `matrix_exp_conjugation` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.mjs`

- 範囲: exp(X)Y exp(−X) = Σ(1/m!)ad_X^m(Y) = exp(ad_X)(Y)、および exp(X)^{-1} = exp(−X)

**3 経路を独立に計算して突き合わせる**。(A) 行列指数による共役、(B) m 重交換子の級数、(C) ad_X を n²×n² の線型写像として行列表示（vec(ad_X(Y)) = (X⊗I − I⊗Xᵀ)vec(Y)）してその指数を作用させたもの。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_three_routes.sage` | 3 経路の相互一致と exp(X)^{-1} = exp(−X) | 80 | 5.769e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

これは本論の中心的な道具であり、リー理論を使わず級数だけで示す方針（プロジェクト README）の裏付けになる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 142
```

実行ログは `sagemath/check/142_matrix_exp_conjugation/logs/` に保存してある（この表の数値はそのログから取った）。
