# SageMath Check: 200_linearity_of_T

## 対象

**対象ラベル**: `linearity_of_T` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: T_g の C-線型性（および乗法性・単位性）

ランダムな行列に対する線型性を、V₁^{(±)} の平方根と V₂ の両方で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_linearity.sage` | 線型性・乗法性・T(I)=I | 135 | 2.702e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 200
```

実行ログは `sagemath/check/200_linearity_of_T/logs/` に保存してある（この表の数値はそのログから取った）。
