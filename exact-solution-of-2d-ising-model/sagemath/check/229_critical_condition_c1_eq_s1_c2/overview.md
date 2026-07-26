# SageMath Check: 229_critical_condition_c1_eq_s1_c2

## 対象

**対象ラベル**: `critical_condition_c1_eq_s1_c2` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.ts`

- 範囲: c₁ = s₁c₂ ⟺ s₁s₂ = 1

**両向きを別々に確認する**。(⟸) s₁s₂ = 1 に厳密に乗せた点を構成して c₁ = s₁c₂ を見る。(⟹) c₁ − s₁c₂ = 0 を brentq で数値的に解き、その解で s₁s₂ = 1 を見る。さらに条件を満たさない点では両方とも成り立たないことも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_equivalence.sage` | 両向きの同値性と否定側 | 34 | 1.410e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 229
```

実行ログは `sagemath/check/229_critical_condition_c1_eq_s1_c2/logs/` に保存してある（この表の数値はそのログから取った）。
