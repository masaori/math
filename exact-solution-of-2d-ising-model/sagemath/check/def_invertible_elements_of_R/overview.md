# SageMath Check: def_invertible_elements_of_R

## 対象

**対象ラベル**: `def_invertible_elements_of_R` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`
- ブロック: `TV1_hatZ_hatY_009_definition_invertible_elements`（`Mat(2^M,ℂ)` の可逆元）
- 範囲: 逆元の一意性の鎖、(i)〜(iv) の鎖と主張。証明が引く単位行列との積・結合律・スカラー倍の性質は、この大きさで確かめ直す
  （それぞれの主張の検算は `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・`mat_mult_associative`・`scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_is_associative`・`scalar_multiple_by_one`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明が引く `IA = A`・`AI = A`（`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`）と `(AB)C = A(BC)`（`mat_mult_associative`）を大きさ `2^M` で | `check_identity_and_associativity_of_product.sage` | 成分を不定元に置いた行列で、本文の成分の式で組んだ積が両辺で一致する。δ から組んだ単位行列が Sage の `identity_matrix` と、成分の式で組んだ積が Sage の行列積と一致する | **PASS** | `n = 2, 4, 8` で厳密等号 |
| 逆元の一意性 `h_1 = h_1 I` | `check_inverse_is_unique.sage` | 不定元の行列で `h_1 = h_1 I` | **PASS** | 厳密等号 |
| `= h_1(gh_2)`（`gh_2 = I` の代入） | 同上 | 具体の `g` と Sage の `solve_right` で求めた `h_2` で `gh_2 = I`、鎖の隣り合う値が等しい | **PASS** | 各 `n` で 3 個の `g` |
| `= (h_1g)h_2`（結合律） | 同上 | 不定元の `h_1, g, h_2` で `h_1(gh_2) = (h_1g)h_2` | **PASS** | 厳密等号 |
| `= Ih_2`（`h_1g = I` の代入） | 同上 | 具体の `g` と Sage の `solve_left` で求めた `h_1` で `h_1g = I`、鎖の隣り合う値が等しい | **PASS** | 各 `n` で 3 個の `g` |
| `= h_2` | 同上 | 不定元の行列で `Ih_2 = h_2`。具体の `g` で `h_1 = h_2` | **PASS** | 厳密等号 |
| (i) `II = I`、`I^{-1} = I` | `check_identity_is_invertible.sage` | 成分の式の積で `II = I`、Sage の `inverse` で `I^{-1} = I` | **PASS** | 厳密等号 |
| (ii) 二つの鎖の第一・第四・第六行（代入と `g_kg_k^{-1} = I`） | `check_inverse_of_product.sage` | 具体の `g_1, g_2` と Sage の `inverse` で求めた逆行列で、鎖の隣り合う値が等しい | **PASS** | 各 `n` で 3 組 |
| (ii) 二つの鎖の第二・第三行（結合律を一回ずつ）と第五行（単位行列との積） | 同上 | `g_2^{-1}, g_1^{-1}` を独立な不定元 `a, b` に置いた一般の等式を一行ずつ | **PASS** | 厳密等号 |
| (ii) 主張 `(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}` | 同上 | Sage が `g_1g_2` から直接求めた逆行列と、`g_2^{-1}g_1^{-1}` が一致する | **PASS** | 各 `n` で 3 組 |
| (iii) `gg^{-1} = g^{-1}g = I` と `(g^{-1})^{-1} = g` | `check_inverse_of_inverse.sage` | 具体の `g` で逆元の条件と、Sage が `g^{-1}` から求めた逆行列が `g` に戻ること | **PASS** | 各 `n` で 3 個の `g` |
| (iv) 根拠の四つの式 `(aA)B = a(AB)`（`scalar_multiple_factors_out_of_left_factor`）、`A(aB) = a(AB)`（`scalar_multiple_factors_out_of_right_factor`）、`a(bA) = (ab)A`（`scalar_multiple_is_associative`）、`1A = A`（`scalar_multiple_by_one`）を大きさ `2^M` で | `check_inverse_of_scalar_identity.sage` | `a, b` と `A, B` の成分を不定元に置き、成分の式で組んだ両辺が一致する | **PASS** | 厳密等号 |
| (iv) 二つの鎖の各行（第四行の `II = I` は単位行列を左から掛けても変わらないことの `A = I`） | 同上 | `c` を `QQ(c)` の不定元に置き、各行の値を書かれた式どおりに組んで隣り合う値が等しい | **PASS** | 厳密等号 |
| (iv) 主張 `(cI)^{-1} = c^{-1}I` | 同上 | Sage の `inverse` で求めた `(cI)^{-1}` が `c^{-1}I` に等しい（`QQ(c)` と具体の 4 つの `c ∈ QQ(i)∖{0}`） | **PASS** | 厳密等号 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- 一般の等式（結合律・単位行列との積・スカラー倍の式）は、成分を `QQ` 上の多項式環の不定元に置いて確かめた。
  不定元で成り立つ多項式の等号は、成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
- 代入の行（仮定 `gh = hg = I` を使う行）は一般の不定元では書けないので、具体の可逆行列で確かめた。
  具体の行列の成分はガウス有理数体 `QQ(i)`（`ℂ` の部分体）で、乱数の種を固定して決めている。
- (iv) のスカラー `c` は有理関数体 `QQ(c)` の不定元に置いた。`c^{-1}` の分母は `c` の冪だけなので、
  `c` へ 0 でない複素数を代入しても等号は保たれる。
- 大きさは `2^M`（`M = 1, 2, 3`）の 3 通りである。一般の `M` は検算の範囲外で、人手証明が担う。

本文の定め方（`mat_mult` の成分の式、`I_{ij} = δ_{ij}`、スカラー倍の成分の式）どおりに組んだ積・単位行列・スカラー倍は
共通の準備 `_shared/matrix_operations_by_definition.sage` にある。両辺を同じ式から作らないため、比べる側に Sage の行列積・`identity_matrix`・`inverse`・
`solve_left`・`solve_right` を独立な経路として使った。代入の行は、鎖の各行の値をその行に書かれた式どおりに組み、
仮定（`gh_2 = I` など）が具体の行列で成り立つこととあわせて確かめている。

## 確かめられない行と理由

- 「逆元の一意性より」で結論を出す段（(i)〜(iv) の各結論）は、等号の計算ではなく、一意性の主張を当てはめる推論である。
  検算は、結論の値（`I^{-1}`・`(g_1g_2)^{-1}`・`(g^{-1})^{-1}`・`(cI)^{-1}`）を Sage の `inverse` で独立に求めて一致を見るにとどまる。
- (iii) の「`gg^{-1} = g^{-1}g = I` は `g^{-1}` に対して `g` が逆元の条件を満たすことを述べている」は、条件の読み替えであり計算を含まない。
- (iv) の `c ≠ 0` から `ℂ` の中に `c^{-1}` があることは `complex_numbers_form_a_field` の主張であり、ここでは `QQ(c)` と `QQ(i)` の中で逆元が取れることだけを使った。
- 一般の `M` は検算の範囲外である（上の「計算の帰属と範囲」）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_invertible_elements_of_R
```

実行ログは `sagemath/check/def_invertible_elements_of_R/logs/` に保存する。
