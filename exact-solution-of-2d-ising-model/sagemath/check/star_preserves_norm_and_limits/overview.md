# SageMath Check: star_preserves_norm_and_limits

## 対象

**対象ラベル**: `star_preserves_norm_and_limits` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_012_claim_star_is_norm_preserving`（`‖A^*‖ = ‖A‖` と極限の共役転置）
- 範囲: (1) の第 1 式・第 2 式の成分の鎖、(2) の鎖、(3) の準備の成分の鎖と各 `N` での二つの等号、各主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) 第 1 式 `((AB)^*)_kl = conj((AB)_lk)`（`def_hermitian_positive_definite`） | `check_product_rule.sage` | `A, B` の成分を `QQ` 上の不定元の対に置き、各行の値をその行に書かれた式どおりに組む | **PASS** | `n = 1,…,4` の全成分で厳密等号 |
| (1) `= conj(Σ_j A_lj B_jk)`（`mat_mult`） | 同上 | 隣り合う行の値が等しい | **PASS** | 同上 |
| (1) `= Σ_j conj(A_lj B_jk)`（`complex_conjugate_of_sum`） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= Σ_j conj(A_lj) conj(B_jk)`（`complex_conjugate_of_product`） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= Σ_j conj(B_jk) conj(A_lj)`（積の可換性） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= Σ_j (B^*)_kj (A^*)_jl`（`def_hermitian_positive_definite`） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= (B^*A^*)_kl`（`mat_mult`）と主張 | 同上 | 隣り合う行の値が等しく、両端が `QQ(i)` 係数へ送った Sage の共役転置・積と等しい。`n ≥ 2` で `(AB)^* ≠ A^*B^*` も確かめた。具体の `QQ(i)` 行列で Sage の `conjugate_transpose` とも比べた | **PASS** | 同上 |
| (1) 第 2 式 `((αA+βB)^*)_kl = conj((αA+βB)_lk)` から `(conj(α)A^* + conj(β)B^*)_kl` までの 8 行 | `check_linearity.sage` | `α, β` と `A, B` の成分を不定元の対に置き、各行を書かれた式どおりに組んで隣り合う行を比べる。両端を Sage の共役転置・和・スカラー倍と比べ、具体の `QQ(i)` 行列で `conjugate_transpose` とも比べた | **PASS** | `n = 1,…,4` の全成分で厳密等号 |
| (2) `‖A^*‖ = √(ΣΣ|(A^*)_kl|^2)` から `= ‖A‖` までの 5 行 | `check_norm.sage` | 根号の中を不定元の対で厳密に比べ、根号を取った値を具体の `QQ(i)` 行列について `AA` で比べる。両端を QQbar の `abs` で組んだ値と比べた | **PASS** | `n = 1,…,4` で厳密等号 |
| (3) 準備 `(A_N^* − A^*)_kl` から `((A_N − A)^*)_kl` までの 5 行 | `check_limits.sage` | `A_N, A` の成分を不定元の対に置き、各行を書かれた式どおりに組んで比べる。両端を Sage の共役転置・差と比べた | **PASS** | `n = 1,…,4` の全成分で厳密等号 |
| (3) `‖A_N^* − A^*‖ = ‖(A_N − A)^*‖ = ‖A_N − A‖` | 同上 | 具体の列 `A_N := A + C/(N+1)`（成分は `QQ(i)`）で各 `N` の値を `AA` で比べる | **PASS** | `n = 1,…,4`、`N = 0,…,29` で厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、共役・和・差・スカラー倍・積・共役転置は
  本文の定め方どおりに成分から組んだ（`_prelude.sage`）。一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。
  不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。
- 根号を取る行（(2) の全行、(3) のノルム）は、実代数的数 `AA` の中で厳密に平方根を取った。
- 大きさは `n = 1,…,4` である。一般の `n` は検算の範囲外で、人手証明が担う。

両辺を同じ式から作らないため、鎖の両端は、対 `(x, y)` を `QQ(i)` 係数の `x + iy` へ送った Sage の行列の共役転置（係数の共役と転置）・積・和・差、
具体の `QQ(i)` 行列では Sage 組み込みの `conjugate_transpose`、ノルムは QQbar の `abs` と比べた。

## 確かめられない行と理由

- 定義を開く行（`def_hermitian_positive_definite`・`mat_mult`・`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_difference`・`def_matrix_norm` の行）は、
  検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。これらの行の独立な確認は、両端を Sage の値と比べる検査が担う。
- (2) の有限和の順序の入れ替えの行は、検算では何も確かめていない（同語反復）。根号の中を `QQ` 上の多項式環の和で組むと、和の値は項の並べ方によらない正規形になるので、`Σ_kΣ_l` と `Σ_lΣ_k` は組み方からして必ず一致する。この行は、`ℝ` の加法の結合法則・交換法則からの有限帰納法として人手証明が担う。
- (3) の最後の段（`‖A_N − A‖ → 0` から `‖A_N^* − A^*‖ → 0`、`A_N^* → A^*`）は `N → ∞` の極限で、`ℝ` への脱出である。有限の計算では確かめられない。
  検算は、各 `N` で二つの数列の項が等しいこと（極限の段が使う事実）を具体の列で確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh star_preserves_norm_and_limits
```

実行ログは `sagemath/check/star_preserves_norm_and_limits/logs/` に保存する。
