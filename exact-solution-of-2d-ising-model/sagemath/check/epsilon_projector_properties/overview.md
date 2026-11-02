# SageMath Check: epsilon_projector_properties

## 対象

**対象ラベル**: `epsilon_projector_properties`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `bridge_009_claim_epsilon_projector_properties`（`P^{(+)} = (1/2)(I + ε)` の冪等性 `(P^{(+)})^2 = P^{(+)}` と、像が `F^{(+)} = {f | εf = f}` に等しいこと）
- 範囲: 証明の四つの鎖の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) の鎖の 17 行（`(P)^2 = PP = (1/2(I+ε))(1/2(I+ε)) = … = 1/2(I+ε) = P`） | `check_idempotent_chain.sage` | 各行をその行の式どおりに本文の定め方の積・和・スカラー倍で組み、`M_col = 1,…,5` で隣の行と厳密に一致。ε を不定元の行列 `E`（`n = 2, 4`）に置くと、`ε^2 = I` を引く第 11 行→第 12 行だけが差 `(1/4)(EE - I)` を持ち、他の 15 個の等号は `E` のままで成り立つ | **PASS** | 成り立つ |
| (⊆) の第一の鎖 `Py = P(Px) = (PP)x = (P)^2x = Px = y` | `check_image_in_fixed_vectors_chain.sage` | `x` を `QQ` 上の不定元のベクトルにして `M_col = 1,…,5` で厳密に。`(1)` を引く行のため `PP = P` も確かめる | **PASS** | 成り立つ |
| (⊆) の第二の鎖の 13 行（`εy = ε(Py) = … = Py = y`） | `check_image_in_fixed_vectors_chain.sage` | `y = Px`（`x` は不定元）で `M_col = 1,…,5` で厳密に。第 3〜12 行は任意の不定元のベクトル `y` でも一致し（最初と最後の行の `Py = y` は `y ∈ im P` でだけ成り立ち、任意の `y` では `Py ≠ y`）、ε を不定元の行列に置くと `ε^2 = I` を引く第 8 行→第 9 行だけが差 `(1/2)(EE - I)y` を持つ | **PASS** | 成り立つ |
| (⊇) の鎖の 10 行（`Pf = (1/2(I+ε))f = … = 1_C f = f`） | `check_fixed_vectors_in_image_chain.sage` | `f` を `εf = f` の解空間の `QQ` 上の基底に不定元の係数を掛けた一般の元にして `M_col = 1,…,5` で厳密に。任意の不定元のベクトル `g` では、仮定 `εf = f` を使う第 5 行→第 6 行だけが差 `(1/2)(εg - g)` を持つ | **PASS** | 成り立つ |
| 主張 (1)(2) | `check_claim.sage` | 鎖を通らず定義から直接: `P^2 = P`、`P` の列空間と `ε - I` の核が `QQ` 上の部分空間として一致（次元 `2^{M_col-1}`）。対照として `(1/2)(I - ε)` の像は `F^{(+)}` と零でしか交わらない | **PASS** | 成り立つ |

ε と `P^{(+)}` は、本文の定め方の経路（`def_kronecker` の成分の式でサイトの `σ^x` を組み、`mat_mult` の成分の式で `σ^x_1⋯σ^x_M` を掛ける）と、Sage の `tensor_product`・`*` の経路の二通りで作り、一致を確かめてから使う。各行は `sagemath/_shared/matrix_operations_by_definition.sage` の `body_product`・`body_sum`・`body_scalar`・`body_identity` で、その行の括弧の形どおりに組む。`(P)^2` と `PP`、`(PP)x` と `(P)^2x` は表記 `X^2 := XX` の行で、値は同じ式になる。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ` か `QQ` 上の多項式環。浮動小数点と `ℝ/ℂ` への脱出はない。`F^{(+)}` と `im P^{(+)}` は `ℂ^{2^{M_col}}` の部分集合だが、どちらも `QQ` 係数の行列で定まり、`QQ` 上の基底は `ℂ` 上でも一次独立で、行列の階数は係数体を広げても変わらないので、`QQ` 上の部分空間の一致から `ℂ` 上の一致が従う。
- 範囲外のもの: `M_col ≥ 6`。集合の包含の推論そのもの（`y ∈ im P` から `y = Px` を取る、`f = Pf` から `f ∈ im P` を言う）は計算を含まないので、確かめるのはその中の鎖の行と、主張の集合の一致である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_projector_properties
```

実行ログは `logs/` に保存する。共通の準備は `_prelude.sage`、`sagemath/_shared/matrix_operations_by_definition.sage`、`sagemath/_shared/site_sigma_z_kronecker.sage`。
