# SageMath Check: 102_angle_section_existence_uniqueness

## 対象

**対象ラベル**: `angle_section_existence_uniqueness` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_10_19.mjs`

- 範囲: 0 ≤ θ−2nπ < 2π なる n ∈ Z の一意存在と、切断 s_[0,2π) の well-defined 性

n = floor(θ/2π) が条件を満たすこと、n±1 では範囲外になること（一意性）、θ を 2π の整数倍ずらしても切断の値が変わらないこと（代表元非依存）を確認する。θ = 0, 2π, 2π−ε, ±10⁵ のような境界・大きい値も入れている。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_section.sage` | 存在・一意性・代表元非依存 | 621 | 4.685e-12 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 102
```

実行ログは `sagemath/check/102_angle_section_existence_uniqueness/logs/` に保存してある（この表の数値はそのログから取った）。
