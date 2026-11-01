# SageMath Check: mat_mult_vector_difference

## 対象

**対象ラベル**: `mat_mult_vector_difference` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
- ブロック: `finite_matrix_claim_vector_product_distributes_over_vector_difference`（行列と数ベクトルの差の積の分配則）
- 範囲: 証明の成分の鎖の 6 個の等号と主張 `A(u - w) = Au - Aw`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `(A(u-w))_i = Σ A_ij (u-w)_j`（`mat_mult`） | `check_steps.sage` | `A, u, w` の成分を `QQ` 上の不定元に置き、本文の積・差の成分の式で組んだ値を比べる | **PASS** | `m, n = 1,…,4` で厳密等号 |
| `= Σ A_ij (u_j - w_j)`（`def_matrix_difference`） | 同上 | 隣り合う行の値が等しい | **PASS** | 同上 |
| `= Σ (A_ij u_j - A_ij w_j)`（分配則） | 同上 | 同上 | **PASS** | 同上 |
| `= Σ A_ij u_j - Σ A_ij w_j`（有限和の差） | 同上 | 同上 | **PASS** | 同上 |
| `= (Au)_i - (Aw)_i`（`mat_mult`） | 同上 | 同上 | **PASS** | 同上 |
| `= (Au - Aw)_i`（`def_matrix_difference`）と主張 | 同上 | 隣り合う行の値が等しく、両辺が Sage の行列積・ベクトルの差で求めた値と等しい。否定コントロールとして差を和 `u + w` に替えると一致しないこと | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。成分は `QQ` 上の多項式環の不定元で、不定元で成り立つ多項式の等号は
成分へ任意の複素数を代入しても成り立つ（代入は環準同型である）。大きさは `m, n = 1,…,4` で、一般の `m, n` は人手証明が担う。

## 確かめられない行と理由

- 定義を開く行（`mat_mult`・`def_matrix_difference` の行）は、検算での組み方そのものが定義なので隣り合う行の比較は同語反復である。
  独立な確認は、主張の両辺を Sage の行列積・差と比べる検査が担う。
- 有限和の差の行は `ℂ` の加法の結合法則・交換法則からの有限帰納法で正当化される。検算は具体の項数で値の一致を確かめるにとどまる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh mat_mult_vector_difference
```

実行ログは `sagemath/check/mat_mult_vector_difference/logs/` に保存する。
