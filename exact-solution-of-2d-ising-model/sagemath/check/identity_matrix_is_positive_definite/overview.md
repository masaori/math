# SageMath Check: identity_matrix_is_positive_definite

## 対象

**対象ラベル**: `identity_matrix_is_positive_definite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_identity_matrix_is_positive_definite`（単位行列は正定値）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| エルミート性の 5 行 | `check_chain.sage` | `n = 1,…,4` の全成分で隣り合う行が等しい | **PASS** | 全て厳密に PASS |
| 正値性の 7 行 | 同上 | `x` の成分を不定元の対に置いて隣り合う行が等しい。左端を Sage の `x̄ᵀx` と比べた | **PASS** | 同上 |
| `Σ|x_k|^2 ≥ |x_{k0}|^2 > 0` と主張 | 同上 | 具体の零でない `x`（`n = 1,…,4`、各 20 本）で、`|x_k|` を `AA` で取って確かめ、`x^*Ix` が `(r, 0)`（`r > 0`）であることと、Sage で `I` が正定値であることを確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、行列・数ベクトル・`x^*Ay` は本文の定め方どおりに成分から組んだ（`_shared/hermitian_forms_by_definition.sage`）。一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。 `|x_k|` は `AA` で厳密に平方根を取った。

両辺を同じ式から作らないため、鎖の両端は、対 `(a, b)` を `QQ(i)` 係数の `a + ib` へ送った Sage の行列・ベクトルの `conjugate_transpose`・積・和と比べた。

## 確かめられない行と理由

定義を開く行（`def_hermitian_positive_definite`・`def_identity_matrix`・`def_conjugate_bilinear_value`・`mat_mult`）は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。これらの行の独立な確認は、両端を Sage の値と比べる検査が担う。分配律・結合律・可換律・有限和の順序の入れ替えの行は、多項式環の正規形どうしの比較なので、項の並べ方や括弧の付け方が違っても必ず一致する。これらの行は、書き写しの誤り（添字・共役の付け忘れ）が無いことだけを確かめており、法則そのものは `complex_numbers_form_a_field` と有限帰納法として人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh identity_matrix_is_positive_definite
```

実行ログは `sagemath/check/identity_matrix_is_positive_definite/logs/` に保存する。
