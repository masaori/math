# SageMath Check: real_symmetric_matrix_moves_between_factors_of_sum_of_products

## 対象

**対象ラベル**: `real_symmetric_matrix_moves_between_factors_of_sum_of_products` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_symmetric_matrix_moves_between_factors_of_sum_of_products`（対称な実数の行列は、成分の積の和で左の因子から右の因子へ移せる）
- 主張は、対称な `Q`（`Q_kl = Q_lk`）について `Σ_k (Qu)_k v_k = Σ_k u_k (Qv)_k`。`Px` は定義 `def_real_matrix_vector_product` どおりに、左から順に足して組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 10 行の鎖 | `check_symmetric_matrix_moves_chain.sage` | `Q` の `k ≤ l` の成分と `u`・`v` を不定元に置き（`Q_kl = Q_lk`）、`n = 1,…,5` で隣り合う行が `QQ` 上の多項式として等しい | **PASS** | 厳密等号（50 段） |
| 主張そのもの | 同上 | 鎖の両端を Sage の `(Q u)·v` と `u·(Q v)`（独立な経路）と比べる。否定コントロールとして、成分をすべて独立な不定元に置いた対称でない行列では、`n ≥ 2` で対称性を当てない 9 段はそのまま成り立ち、対称性を当てる 3 行目 → 4 行目の段だけが崩れ、主張も成り立たないことを確かめる | **PASS** | 同上 |

## 計算の帰属と範囲

成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `n` は人手証明の鎖が担う。

鎖の項は多項式環の元なので、積の括弧の付け方と因子の順序の違いは Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字の位置、対称性を当てた成分 `Q_lk`、和の順序）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_symmetric_matrix_moves_between_factors_of_sum_of_products
```

実行ログは `sagemath/check/real_symmetric_matrix_moves_between_factors_of_sum_of_products/logs/` に保存する（2026-11-07）。
