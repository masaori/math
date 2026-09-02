# SageMath Check: 200_linearity_of_T

## 対象

**対象ラベル**: `linearity_of_T` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: 任意の可逆な有限複素行列による共役写像 T_g の C-線型性

Gaussian 有理数体 `ℚ(i)` 上の一般行列 X, W と、非零対角成分を持つ上三角可逆行列 g に対し、本文の六つの等式変形を一行ずつ厳密等号で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_linearity.sage` | 定義・左右分配・左右の行列積とスカラー倍の両立を一行ずつ厳密検査 | 54 | 厳密等号 | **PASS** |

各判定は `ℚ(i)` 上の厳密等号であり、許容誤差は用いない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 200
```

実行ログは `sagemath/check/200_linearity_of_T/logs/` に保存してある（この表の数値はそのログから取った）。
