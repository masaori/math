# SageMath Check: 138_theorem_exp_zero

## 対象

**対象ラベル**: `theorem_exp_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: exp(O) = I

scipy の expm と、級数を A⁰ = I の規約で足した結果の 2 経路。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_exp_zero.sage` | 両経路 | 12 | 0.000e+00 | **PASS** |
| 02 | `check_02_zero_matrix_power_rows.sage` | 準備の鎖 `O^k = O^{k-1}O = O`（`k ≥ 1`。`def_matrix_power` の `A^{m+1} := A^mA` と `zero_matrix_is_right_zero_of_mat_mult`）と本体の鎖の `O^0 = I` の行（`def_matrix_power` の `A^0 := I`）。`d = 1〜5`、指数 `1〜8` で冪を `def_matrix_power` の再帰そのもので作り、1 行目は Sage の冪（再帰とは別の実装）とも突き合わせる。否定の対照（`E = I` で 2 行目が崩れる 40 件、冪の規約を `O^0 := O` に差し替えて作り直すと `O^0 = I` が崩れる 5 件） | 130・否定の対照 45 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（01 だけ。02 は `QQ[i]` の厳密計算）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 138
```

実行ログは `sagemath/check/138_theorem_exp_zero/logs/` に保存してある（この表の数値はそのログから取った）。
