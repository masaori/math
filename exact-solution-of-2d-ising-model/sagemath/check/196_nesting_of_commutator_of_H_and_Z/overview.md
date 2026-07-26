# SageMath Check: 196_nesting_of_commutator_of_H_and_Z

## 対象

**対象ラベル**: `nesting_of_commutator_of_H_and_Z` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: (h1.z)/(h1.y)/(h2.z−)/(h2.y) の n 重交換子の閉じた表示（n = 0..6）

左辺は ad を n 回適用する再帰、右辺は閉じた表示から独立に計算する。符号 (−1)^{(n±1)/2}、係数 (2K₁)^n、位相因子 e^{∓iθ_μ} が n の偶奇ごとに正しく再生されることを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_nesting.sage` | 4 式 × n=0..6 × M=2,3,4 × 全 μ × 3 パラメータ | 2268 | 1.771e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

**注意**: この主張が扱うのは同符号の組み合わせだけなので、195 で見つかった異符号の不一致の影響を受けない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 196
```

実行ログは `sagemath/check/196_nesting_of_commutator_of_H_and_Z/logs/` に保存してある（この表の数値はそのログから取った）。
