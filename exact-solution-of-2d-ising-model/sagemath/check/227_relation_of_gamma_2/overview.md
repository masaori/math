# SageMath Check: 227_relation_of_gamma_2

## 対象

**対象ラベル**: `relation_of_gamma_2` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`

- 範囲: γ₂(−θ_μ) = −conj(γ₂(θ_μ))、γ₂(θ)γ₂(−θ) = −|γ₂(θ)|²

零点が同時であること（γ₂(θ) = 0 ⟺ γ₂(−θ) = 0）も確認する。これは 223/224/225 で平方根の中身が非負実数であることの根拠にもなっている。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_conjugate.sage` | 共役関係と積の表示 | 1980 | 4.150e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 227
```

実行ログは `sagemath/check/227_relation_of_gamma_2/logs/` に保存してある（この表の数値はそのログから取った）。
