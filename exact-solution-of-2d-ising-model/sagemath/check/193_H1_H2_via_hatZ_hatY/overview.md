# SageMath Check: 193_H1_H2_via_hatZ_hatY

## 対象

**対象ラベル**: `H1_H2_via_hatZ_hatY` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: H₁^{(±)} と H₂ の hatZ, hatY による表示

hat 表示から組んだ側と、定義式（Y_mZ_{m+1} の和など）から組んだ側の 2 経路で比べる。両符号について確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_H_via_hat.sage` | hat 表示と定義式の一致 | 24 | 9.583e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 193
```

実行ログは `sagemath/check/193_H1_H2_via_hatZ_hatY/logs/` に保存してある（この表の数値はそのログから取った）。
