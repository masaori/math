# SageMath Check: sum_over_binary_words_entrywise

## 対象

**対象ラベル**: `sum_over_binary_words_entrywise`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_sum_over_binary_words_entrywise`（{0,1}^r の上の行列の和の成分は、成分の和に等しい）
- 範囲: 証明の r = 1 の鎖 3 行、r → r+1 の鎖 4 行、主張そのもの。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| r = 1 の鎖 3 行 | `check_induction_chains.sage` | 成分を `QQ(i)` 上の多項式環の不定元に置いた行列で、`def_sum_over_binary_words` の和と `def_matrix_sum`（`body_sum`）の成分を比べる | **PASS** |
| r → r+1 の鎖 4 行 | `check_induction_chains.sage` | 同じ。帰納法の仮定の行は、一つ小さい r の主張を `X_{ε'} → X_{(ε',1)} + X_{(ε',0)}` の族へ当てた値（r = 2, 3, 4） | **PASS** |
| 主張 | `check_induction_chains.sage` | r = 1..4、(m, n) ∈ {(1,1), (2,3), (3,2)} の全ての成分 | **PASS** |

## 計算の帰属と範囲

- **厳密**: すべて（`QQ(i)` 上の多項式環）。浮動小数点は使わない。
- **範囲外**: r ≥ 5。帰納法の一般の段は確かめていない（具体の r で鎖の各行を比べる）。

## 構成上かならず成り立つ比較

- r = 1 の 1→2 行目と r → r+1 の 1→2 行目は、`bw_sum_mat` が定義の式そのものなので必ず成り立つ。最後の行（右辺から左辺へ定義を戻す行）も `bw_sum_num` の定義そのもの。
- 中身は `def_matrix_sum` を成分へ当てる行と、帰納法の仮定の行（行列の和の成分と、成分の和の一致）にある。帰納的な和が全ての語の和に等しいことも Sage の `sum` と比べる。

## 否定コントロール

- 一つの語の項を落とした成分の和は、行列の和の成分と違う（12 件）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_over_binary_words_entrywise
```
