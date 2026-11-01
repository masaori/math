# SageMath Check: 139_scalar_identity_commutes

## 対象

**対象ラベル**: `scalar_identity_commutes` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: [cI, A] = O（`check_01` は主張そのもの、`check_02` は証明の鎖の各行）

一般の W では [W,A] ≠ O になること（主張が非自明であること）も確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_scalar.sage` | 恒等式と非自明性 | 104 | 1.776e-15 | **PASS** |
| 02 | `check_02_steps.sage` | 証明の鎖の 6 行（交換子の定義 → 左の因子のスカラー倍 → 右の因子のスカラー倍 → 単位行列は左の単位元 → 右の単位元 → 差が O）が隣どうし一致し、各段の根拠の主張も成り立つこと。`n = 1,…,4`、成分を不定元とした `QQ(i)` 上の多項式環で厳密に計算。否定コントロール: 一般の `W` では `[W, A] ≠ O` | 4（`n` ごとに鎖の 5 つの等号と根拠の主張 4 つ）+ 否定コントロール 1 | 厳密 | **PASS** |

`check_01` の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 139
```

実行ログは `sagemath/check/139_scalar_identity_commutes/logs/` に保存してある（この表の数値はそのログから取った）。
