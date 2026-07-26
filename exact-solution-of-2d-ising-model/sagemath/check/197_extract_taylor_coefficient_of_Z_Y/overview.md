# SageMath Check: 197_extract_taylor_coefficient_of_Z_Y

## 対象

**対象ラベル**: `extract_taylor_coefficient_of_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: n 重交換子の級数和が cosh/sinh の閉じた表示になること

級数を 40 項まで足した結果と、cosh/sinh から組んだ閉じた表示を比べる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_series_to_cosh_sinh.sage` | (h1.z)/(h1.y)/(h2.z−)/(h2.y) の 4 式 | 432 | 5.014e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

打ち切り項数は 40。K₁ の最大が 1.2 程度なので、打ち切り誤差は倍精度の丸めより十分小さい（実測の最大相対誤差が機械精度であることがその裏付け）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 197
```

実行ログは `sagemath/check/197_extract_taylor_coefficient_of_Z_Y/logs/` に保存してある（この表の数値はそのログから取った）。
