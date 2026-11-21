# SageMath Check: dimension_of_matrix_space

## 対象

**対象ラベル**: `dimension_of_matrix_space` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_dimension_of_matrix_space`
- 範囲: 主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張 | `check_dimension.sage` | m, n = 1, …, 4 で行列単位の族が元の個数 mn で線型独立かつ張ること、Sage の MatrixSpace・VectorSpace の次元と一致、ℂ^m と Mat(n,ℂ) の場合 | **PASS** | 72 件 |

## 計算の帰属と範囲

- **厳密**: 係数体は Gauss 有理数体 `K = QQ(i)`。浮動小数点は使わない。線型結合・有限和は本文の定義どおり左から順に足す（`p = 0` の線型結合は零行列）。共通の道具は `sagemath/_shared/linear_algebra_families.sage`。
- 範囲外: 選んだ以外の大きさ・族・係数。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh dimension_of_matrix_space
```

実行ログは `logs/` に保存してある（2026-11-21）。
