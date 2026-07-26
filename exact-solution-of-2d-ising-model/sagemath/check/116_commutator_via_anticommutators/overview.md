# SageMath Check: 116_commutator_via_anticommutators

## 対象

**対象ラベル**: `commutator_via_anticommutators` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`

- 範囲: [ab,c] = a[b,c]₊ − [a,c]₊b

ランダムな複素行列（n=1,2,3,4,8）と、本文で実際に使う場面（Jordan–Wigner 文字列 Z_μ, Y_ν への適用）の両方で確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_identity.sage` | 恒等式と Z,Y への適用 | 139 | 2.073e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 116
```

実行ログは `sagemath/check/116_commutator_via_anticommutators/logs/` に保存してある（この表の数値はそのログから取った）。
