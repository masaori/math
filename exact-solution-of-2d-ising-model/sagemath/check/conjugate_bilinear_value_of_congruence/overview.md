# SageMath Check: conjugate_bilinear_value_of_congruence

## 対象

**対象ラベル**: `conjugate_bilinear_value_of_congruence` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_claim_conjugate_bilinear_value_of_congruence`（x^*(B^*(AB))y = (Bx)^*A(By)）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `x^*(B^*(AB))y` から `(Bx)^*A(By)` までの 14 行 | `check_chain.sage` | `A, B, x, y` の成分を不定元の対に置き、`n = 1, 2, 3` で各行を書かれた式どおりに組んで隣り合う行が等しい。5 つの積は左から掛けた。両端を Sage の `x̄ᵀ(B^*(AB))y` と `conj(Bx)ᵀA(By)` と比べた | **PASS** | `n = 1, 2, 3` で厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。ℂ は本文 `definition_of_cc` どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`）、行列・数ベクトル・`x^*Ay` は本文の定め方どおりに成分から組んだ（`_shared/hermitian_forms_by_definition.sage`）。一般の等式は成分を `QQ` 上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、実数を代入しても成り立つ。

両辺を同じ式から作らないため、鎖の両端は、対 `(a, b)` を `QQ(i)` 係数の `a + ib` へ送った Sage の行列・ベクトルの `conjugate_transpose`・積・和と比べた。

## 確かめられない行と理由

定義を開く行（`def_conjugate_bilinear_value`・`mat_mult`・`def_hermitian_positive_definite`）は、検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。これらの行の独立な確認は、両端を Sage の値と比べる検査が担う。分配律・結合律・可換律・有限和の順序の入れ替えの行は、多項式環の正規形どうしの比較なので、項の並べ方や括弧の付け方が違っても必ず一致する。これらの行は、書き写しの誤り（添字・共役の付け忘れ）が無いことだけを確かめており、法則そのものは `complex_numbers_form_a_field` と有限帰納法として人手証明が担う。 `n = 4` は四重和の不定元が多いので範囲外にした。一般の `n` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh conjugate_bilinear_value_of_congruence
```

実行ログは `sagemath/check/conjugate_bilinear_value_of_congruence/logs/` に保存する。
