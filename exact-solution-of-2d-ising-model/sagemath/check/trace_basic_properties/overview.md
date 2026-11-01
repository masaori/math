# SageMath Check: trace_basic_properties

## 対象

**対象ラベル**: `trace_basic_properties` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_002_claim_trace_properties`（トレースの基本性質）
- 範囲: (1) 線型性・(2) 巡回性・(3) 単位行列のトレース・(4) 相似変換での不変性の四本の鎖の全行と、各主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) `tr(αA+βB) = Σ(αA+βB)_kk`（`def_trace`） | `check_linearity.sage` | `α, β` と `A, B` の成分を `QQ` 上の不定元に置き、本文の和・スカラー倍の成分の式で組んだ `αA+βB` の対角成分の和 | **PASS** | `n = 1,…,5` で厳密等号 |
| (1) `= Σ((αA)_kk + (βB)_kk)`（`def_matrix_sum`） | 同上 | 隣り合う行の値が等しい | **PASS** | 同上 |
| (1) `= Σ(αA_kk + βB_kk)`（`def_matrix_scalar_multiple`） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= ΣαA_kk + ΣβB_kk`（和の並べ替え） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= αΣA_kk + βΣB_kk`（分配法則） | 同上 | 同上 | **PASS** | 同上 |
| (1) `= α tr(A) + β tr(B)`（`def_trace`）と主張 | 同上 | 隣り合う行の値が等しく、両端が Sage の `trace`・和・スカラー倍で求めた値と等しい | **PASS** | 同上 |
| (2) `tr(AB) = Σ_k(AB)_kk`（`def_trace`） | `check_cyclicity.sage` | `A, B` の成分を `QQ` 上の不定元に置き、`mat_mult` の成分の式で積を組む | **PASS** | `n = 1,…,5` で厳密等号 |
| (2) `= Σ_kΣ_j A_kj B_jk`（`mat_mult`） | 同上 | 隣り合う行の値が等しい | **PASS** | 同上 |
| (2) `= Σ_kΣ_j B_jk A_kj`（積の交換法則） | 同上 | 同上 | **PASS** | 同上 |
| (2) `= Σ_jΣ_k B_jk A_kj`（和の順序交換） | 同上 | 同上 | **PASS** | 同上 |
| (2) `= Σ_j(BA)_jj`（`mat_mult`）、`= tr(BA)`（`def_trace`）と主張 | 同上 | 隣り合う行の値が等しく、両端が Sage の行列積の `trace` と等しい。`n ≥ 2` で `AB ≠ BA` であることも確かめた（主張が積の一致に頼っていない） | **PASS** | 同上 |
| (3) `tr(I) = Σ(I)_kk`（`def_trace`）、`= Σδ_kk`（`def_identity_matrix`）、`= Σ1_C`（`def_kronecker_delta` の `i = j`）と主張 | `check_trace_of_identity.sage` | ℂ を本文どおり実数の対で持ち（`_shared/complex_as_real_pairs.sage`、成分は `QQ`）、単位行列を δ から組んで各行の値を比べる。比べる側として Sage の `identity_matrix` の `trace`（`QQ(i)`）を実部・虚部の対に直し、鎖の両端と一致させる | **PASS** | `n = 1,…,5` で厳密等号 |
| (4) `tr(P(AP')) = tr((PA)P')`（`mat_mult_associative`） | `check_similarity_invariance.sage` | `A` の成分を `QQ(i)` 上の不定元に、`P` を `QQ(i)` の具体の可逆行列に、`P'` を Sage の `inverse` で求めた行列に置き、仮定 `P'P = I` を成分の式の積で確かめたうえで `P(AP')` と `(PA)P'` のトレースを比べる。結合律そのものは `P, P', A` を不定元に置いた一般の等式でも確かめた | **PASS** | `n = 1,…,5`、各 3 個の `P` |
| (4) `= tr(P'(PA))`（(2) を `A → PA`、`B → P'` に） | 同上 | 隣り合う行の値が等しい。不定元の `P, P', A` でも等しい | **PASS** | 同上 |
| (4) `= tr((P'P)A)`（`mat_mult_associative`） | 同上 | 同上 | **PASS** | 同上 |
| (4) `= tr(IA)`（`P'P = I` の代入） | 同上 | 具体の `P` で隣り合う行の値が等しい | **PASS** | 同上 |
| (4) `= tr(A)`（`identity_matrix_is_left_unit_of_mat_mult`）と主張 | 同上 | 隣り合う行の値が等しく、両端が Sage の行列積の `trace` と等しい。`IA = A` は不定元でも確かめた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- 一般の等式は、成分を `QQ`（(4) では `QQ(i)`）上の多項式環の不定元に置いて確かめた。不定元で成り立つ多項式の等号は、
  成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。
- (4) の代入の行（仮定 `P'P = I` を使う行）は、不定元のまま仮定を課せないので、ガウス有理数体 `QQ(i)` の具体の可逆行列
  （乱数の種を固定して決める）で確かめた。
- (3) は、本文の `ℂ` が実数の対であることに合わせ、`1_C = (1, 0)` の和を対の和の定義式どおりに組んで確かめた。
- 大きさは `n = 1,…,5` である。一般の `n` は検算の範囲外で、人手証明が担う。

両辺を同じ式から作らないため、本文の定め方どおりに組んだ積・和・スカラー倍・単位行列（`_shared/matrix_operations_by_definition.sage`）と
トレース（`_prelude.sage` の `body_trace`）の値を、各行に書かれた式どおりに組み、主張の両端は Sage の `trace`・行列積・`identity_matrix`・`inverse` と比べた。

## 確かめられない行と理由

- 定義を開く行（(1)(2)(3) の `def_trace` の行、(1) の `def_matrix_sum`・`def_matrix_scalar_multiple` の行、(3) の `def_identity_matrix`・`def_kronecker_delta` の行）は、
  検算での組み方そのものが定義なので、隣り合う行の比較は同語反復である。これらの行の独立な確認は、鎖の両端を
  Sage の `trace`・行列積・和・スカラー倍・`identity_matrix` と比べる検査が担う。
- (1)(2) の有限和の並べ替え・順序交換は、`ℂ` の加法の結合法則・交換法則からの有限帰納法で正当化される。検算は `n = 1,…,5` の
  具体の項数で値の一致を確かめるにとどまる。
- (4) の第二行は (2) の主張を当てはめる推論である。検算は当てはめた後の値の一致を確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_basic_properties
```

実行ログは `sagemath/check/trace_basic_properties/logs/` に保存する。
