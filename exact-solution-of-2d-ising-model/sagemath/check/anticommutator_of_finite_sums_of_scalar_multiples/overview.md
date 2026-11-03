# SageMath Check: anticommutator_of_finite_sums_of_scalar_multiples

## 対象

**対象ラベル**: `anticommutator_of_finite_sums_of_scalar_multiples`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_anticommutator_of_finite_sums_of_scalar_multiples`（スカラー倍の有限和どうしの反交換子は反交換子の二重和に等しい）
- 範囲: 証明の成分の 21 等号の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `([S,T]_+)_{pq}` から反交換子の定義、和の定義、積の定義、有限和の成分、スカラー倍の定義、第 2 項の積の交換、分配則 (Σx)y = Σxy、分配則 xΣy = Σxy、積の結合・交換、和の順序交換（l と j、l と k）、`finite_sum_of_complex_sums`（外側、内側）、Σcx = cΣx、分配法則、積の定義、和の定義、反交換子の定義、スカラー倍の定義、有限和の成分（各 j、外側）を経て `(Σ_jΣ_k (a_jb_k)[X_j,W_k]_+)_{pq}` に着く 21 等号と主張 | `check_entry_chain.sage` | a_j、b_k と行列の成分を `QQ` 上の多項式環の不定元に置き、n = 1,2,3、r, s = 1,2,3 の全ての成分で、各行を本文の成分の式と、行の書き方どおりの和の順序の入れ子の和で組んで隣と比べる。主張を Sage の行列演算とも比べる。対照: b_k を落とした係数の二重和とは一致しない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: すべて `QQ` 上の多項式環。浮動小数点は使わない。
- **作り方で自明な比較**: 定義を当てはめる行（反交換子・和・積・スカラー倍・有限和の成分）は、両辺を本文の成分の式から作るので比較は定義を当てはめた値が通ることを見るだけである。分配則・積の結合と交換・和の順序交換・`finite_sum_of_complex_sums` の行は、多項式環が両辺を同じ正規形にしてから比べるので、検算は各行を多項式の恒等式として確かめる（和の形の違いそのものを見るのではない）。
- 範囲外: n ≥ 4、r または s ≥ 4。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh anticommutator_of_finite_sums_of_scalar_multiples
```

実行ログは `logs/` に保存する。
