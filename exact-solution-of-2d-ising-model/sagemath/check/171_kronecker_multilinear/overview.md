# SageMath Check: 171_kronecker_multilinear

## 対象

**対象ラベル**: `kronecker_multilinear` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: 第 j 因子についての線型性（有限線型結合の展開）と、スカラーが外へ出ること

j を全て走らせ、線型結合の項数 r = 1,2,3 で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_multilinear.sage` | 多重線型性と r=1 の特別な場合 | 40 | 3.486e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 171
```

実行ログは `sagemath/check/171_kronecker_multilinear/logs/` に保存してある（この表の数値はそのログから取った）。
