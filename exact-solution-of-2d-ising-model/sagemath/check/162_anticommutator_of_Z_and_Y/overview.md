# SageMath Check: 162_anticommutator_of_Z_and_Y

## 対象

**対象ラベル**: `anticommutator_of_Z_and_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.mjs`

- 範囲: [Z_μ,Z_ν]₊ = 2Iδ^M、[Z_μ,Y_ν]₊ = 0、[Y_μ,Y_ν]₊ = 2Iδ^M（M = 2..6 の全 (μ,ν)）

Jordan–Wigner 文字列を具体的なクロネッカー積として構成し、3 式すべてを全組み合わせで確認する。添字の M 周期性（Z_{M+1} = Z_1）も見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_three_relations.sage` | 3 式 × 全 (μ,ν) × M=2..6 | 280 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

[Z_μ,Y_ν]₊ = 0 が μ=ν でも成り立つ（対角も消える）ことがこの check で確認できる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 162
```

実行ログは `sagemath/check/162_anticommutator_of_Z_and_Y/logs/` に保存してある（この表の数値はそのログから取った）。
