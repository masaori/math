# SageMath Check: 144_exp_X_Y_exp_-X

## 対象

**対象ラベル**: `exp_X_Y_exp_-X` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: exp(X)Y exp(−X) = Ad_{exp X}(Y) = exp(ad_X)(Y) = Σ(1/n!)[X,…[X,Y]…]

一般のランダム行列に加えて、**本文で実際に使う場面**（X = i(K₁/2)H₁^{(−)}、Y = hatZ^{(−)}_1）でも一致することを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_conjugation.sage` | 一般の場合と本文の適用場面 | 49 | 6.539e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 144
```

実行ログは `sagemath/check/144_exp_X_Y_exp_-X/logs/` に保存してある（この表の数値はそのログから取った）。
