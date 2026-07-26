# SageMath Check: 192_recover_Z_Y_from_hatZ_hatY

## 対象

**対象ラベル**: `recover_Z_Y_from_hatZ_hatY` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: Σ_μ hatY_μ e^{im2πμ/M} = M·Y_m、Σ_μ hatZ^{(−)}_μ e^{im2πμ/M} = M·Z_m と、そこからの復元

逆離散 Fourier 変換。**hatZ^{(+)} では m=1 の項だけ符号が反転して −M·Z₁ になり、m≥2 では hatZ^{(−)} と同じ結果になる**ことも確認している（j=1 の重みが −1 なので、効くのは m=1 の項だけ）。本文が復元を hatZ^{(−)} でしか述べていない理由がこれで具体的に見える。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_inverse_dft.sage` | 逆変換と hatZ^{(+)} での挙動 | 74 | 6.852e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 192
```

実行ログは `sagemath/check/192_recover_Z_Y_from_hatZ_hatY/logs/` に保存してある（この表の数値はそのログから取った）。
