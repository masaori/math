# SageMath Check: 172_tensor_basis

## 対象

**対象ラベル**: `tensor_basis` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.mjs`

- 範囲: 行列単位のクロネッカー積 E_{I,J} が Mat(2^M,C) の基底、f_I = e_{i₁}⊠…⊠e_{i_M} が C^{2^M} の基底

E_{I,J} を全て構成してランクが 4^M であることを確認し、各 E_{I,J} がちょうど 1 成分だけ非零であること（行列単位そのものになること）も見る。f_I については標準基底に一致することを直接確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_matrix_units.sage` | 基底性、行列単位であること、次元 | 104 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 172
```

実行ログは `sagemath/check/172_tensor_basis/logs/` に保存してある（この表の数値はそのログから取った）。
