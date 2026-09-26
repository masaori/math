# SageMath Check: 043_claim_transfer_matrix_bridge

## 対象

**対象ラベル**: `partition_function_via_transfer_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/001_partition_function_2d_ising.ts`
  （ブロック `partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`）
- 併せて検証:
  - `structured-latex/content/004_transfer_matrix.ts`:
    `sigma_z_diagonal_action` / `exp_of_diagonal_matrix` / `first_transfer_matrix_pauli_form`、
    `two_by_two_transfer_identity` / `second_transfer_matrix_pauli_form`
  - `structured-latex/content/010_transfer_matrix_bridge.ts`:
    `epsilon_projector_properties` / `epsilon_commutes_with_transfer_matrices` /
    `epsilon_projectors_commute_with_transfer_matrices`（いずれも (+) セクターだけの主張）

### 何を確定させるための検証か

転送行列 `V_1, V_2` は `def_transfer_matrix`（分配関数の章）で**成分**により一度だけ定義され、
転送行列の章はそのパウリ行列表示を主張 `first_transfer_matrix_pauli_form` /
`second_transfer_matrix_pauli_form` として示す。ここでは

1. 成分定義の `V_1, V_2` とパウリ行列表示が**行列として一致すること**
2. スピン配置についての**直接和で定義された分配関数** `Z(K_1,K_2)` が `tr((V_1V_2)^{N_row})` に一致すること
3. `ε` の偶セクターへの射影子 `P^{(+)}` の性質と、`ε`・`P^{(+)}` が転送行列と可換であること
   （`010_transfer_matrix_bridge.ts`）

を、いずれも定義に戻って数値的に確かめる。1 と 2 は、厳密計算による専用の check
（`first_transfer_matrix_pauli_form/`、`second_transfer_matrix_pauli_form/`、
`252_partition_function_via_transfer_matrix/`）とは独立な、倍精度での再確認である。

以前の対象ラベル `partition_function_in_pauli_form`（分配関数をパウリ行列表示の転送行列で書く主張）は、
`V_1, V_2` の定義が 1 つになったことで `partition_function_via_transfer_matrix` と同一になり本文から削除された。
そのため対象ラベルを付け替えた。旧 `V1_component_equals_pauli` / `V2_component_equals_pauli` は
`first_transfer_matrix_pauli_form` / `second_transfer_matrix_pauli_form` に統合された。

## 記号（本文と同じ）

| 記号 | 意味 | 本ディレクトリのコード |
|---|---|---|
| `M_col` | 列数（1 行のサイト数。転送行列は `2^{M_col}` 次） | `M` |
| `N_row` | 行数（転送の回数） | `N_row` |
| `K_1` | 同じ行の隣り合うサイト `s(i,j)s(i,j+1)` の結合定数 | `K1` |
| `K_2` | 隣り合う行の同じ列のサイト `s(i,j)s(i+1,j)` の結合定数 | `K2` |

行・列番号は `def_row_configuration_numbering` の `ord(μ) = 1 + Σ_m (1-μ(m))/2 · 2^{M_col-m}`
（コードでは 0 始まりの `config_index(μ) = ord(μ) - 1`。`_shared/row_configurations.sage` の `ord_number` を使う）。
`config_numbering_equals_kronecker_numbering` により `ord(μ) = ν(ι(μ))` なので、クロネッカー積
（`tensor_product`、先頭因子が最上位）で作るパウリ行列と同じ番号で並ぶ。

## 検証の枠組み

`_prelude.sage` で次を構成する。

| 関数 | 内容 |
|---|---|
| `V1_component(M, K1)` | `def_transfer_matrix` の成分定義 `(V_1)_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 Σ_m μ(m)μ(m+1))` |
| `V2_component(M, K2)` | `def_transfer_matrix` の成分定義 `(V_2)_{ord(μ),ord(μ')} = exp(K_2 Σ_m μ(m)μ'(m))` |
| `V1_pauli(O, K1)` | `first_transfer_matrix_pauli_form` の右辺 `exp(K_1 Σ_m σ^z_m σ^z_{m+1})` |
| `V2_pauli(O, K2)` | `second_transfer_matrix_pauli_form` の右辺 `(2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ_m σ^x_m)` |
| `Z_direct(N_row, M, K1, K2)` | 分配関数の**定義そのもの**（`2^{N_row·M_col}` 通りのスピン配置の直接和） |
| `epsilon_op`, `projector_plus` | `ε = σ^x_1⋯σ^x_M`、`P^{(+)} = (I + ε)/2`（`def_epsilon_projectors`） |
| `V1_plus`, `V1_plus_half`, `V_plus` | `V_1^{(+)} = exp(iK_1H_1^{(+)})`、`(V_1^{(+)})^{1/2} = exp(iK_1H_1^{(+)}/2)`、`V^{(+)} = (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}` |
| `projectors`, `V_sym(O,K1,K2,sgn)`, `V1_pm` | 符号引数つきの旧関数。045 の check_03 と `_old/minus-sector/` の記録だけが使う |

パラメータは `M_col = 2,3,4`、`(K1,K2)` 数組（`BRIDGE_CASES`）。分配関数の直接和は
`2^{N_row·M_col}` 通りを回すので `(N_row, M_col) ∈ {(2,2),(3,2),(2,3),(3,3),(2,4)}` に限った（`Z_CASES`）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_V1_bridge.sage | `V_1` の成分定義とパウリ行列表示の一致、`σ^z` の対角作用、周期端 `σ_M^zσ_1^z` の作用 | PASS | 全 7 ケース残差 **0.00e+00**（厳密に一致） |
| 02 | check_02_V2_bridge.sage | `2×2` の恒等式、`A` のクロネッカー冪、`V_2` の一致 | PASS | 最大残差 2.4e-14 |
| 03 | check_03_epsilon_projectors.sage | `P^{(+)}` の性質、`ε`・`P^{(+)}` と転送行列の可換性 | PASS | 最大残差 1.5e-14 |
| 04 | check_04_partition_function.sage | `Z(K_1,K_2)`（直接和）` = tr((V_1V_2)^{N_row})` | PASS | 相対誤差 最大 2.0e-15。取り違えは相対誤差 0.09〜0.44 で明確に不一致 |

## 検証した式

check_01（`first_transfer_matrix_pauli_form`、`sigma_z_diagonal_action`、`exp_of_diagonal_matrix`）:

```
σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}
σ^z_M σ^z_1 f_{ι(μ)} = μ(M)μ(1) f_{ι(μ)}
(exp(K_1 Σ_m σ^z_m σ^z_{m+1}))_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 Σ_m μ(m)μ(m+1)) = (V_1)_{ord(μ),ord(μ')}
（パウリ行列表示の V_1 が対角行列であることも確認）
```

check_02（`second_transfer_matrix_pauli_form`、`two_by_two_transfer_identity`）:

```
A = [[e^{K_2}, e^{-K_2}], [e^{-K_2}, e^{K_2}]] = (2 sinh 2K_2)^{1/2} exp(K_2^* σ^x)
A ⊠ ⋯ ⊠ A (M_col 個) = V_2（成分定義）
V_2（成分定義） = (2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ_m σ^x_m)
```

check_03（`epsilon_projector_properties` / `epsilon_commutes_with_transfer_matrices` /
`epsilon_projectors_commute_with_transfer_matrices`）:

```
ε² = I（前提）,  (P^{(+)})² = P^{(+)}
im P^{(+)} = F^{(+)}:  ε P^{(+)} = P^{(+)}（⊆）,  F^{(+)} の基底 f = e_k + e_{k̄} について ε f = f かつ P^{(+)} f = f（⊇）
[ε, V_1] = [ε, V_2] = [ε, V_1^{(+)}] = [ε, (V_1^{(+)})^{1/2}] = 0
[P^{(+)}, V_1] = [P^{(+)}, V_2] = [P^{(+)}, V_1^{(+)}] = [P^{(+)}, (V_1^{(+)})^{1/2}] = 0
((V_1^{(+)})^{1/2})² = V_1^{(+)}
```

check_04（`partition_function_via_transfer_matrix`）:

```
Z(K_1,K_2) = Σ_s exp( Σ_{i,j} ( K_1 s(i,j)s(i,j+1) + K_2 s(i,j)s(i+1,j) ) )
           = tr( (V_1 V_2)^{N_row} )        （成分定義でもパウリ行列表示でも）
```

**結合定数の向きの確定**: `K_1` と `K_2` を取り違えた `tr((V_1(K_2) V_2(K_1))^{N_row})` は、
`N_row ≠ M_col` のとき `Z` と一致しないことも同じチェックで確認している
（`N_row = M_col` のときは対称性から一致してしまうので、判定から除外した）。

## (−) セクターの退避に伴う更新（2026-09-26）

(−) セクターを本文から外したとき、`sector_replacement_of_V1` / `sector_replacement_pow` /
`partition_function_sector_decomposition` は参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避され、
射影子と可換性の主張は (+) セクターだけの形になった。これに合わせて

- check_05（分配関数の偶奇セクター分解）を `sagemath/_old/minus-sector/043_claim_transfer_matrix_bridge/` へ移した。
- check_03 は (+) だけの主張に合わせて書き直した（`V_1P^{(±)} = V_1^{(±)}P^{(±)}`、`(V_1V_2)^nP^{(±)} = …`、
  `P^{(+)}P^{(-)} = 0` などの旧項目は外した）。書き直す前の check_03 も同じ退避先に複製してある。

## 備考

- 浮動小数点（CDF / RDF）を使っている。`K_1, K_2` を一般の正の実数に取るため、`exp` の値と
  行列の指数関数が ℝ に住む（指数評価による ℝ 脱出）。許容誤差は `_prelude.sage` の `TOL = 1e-8`
  （check_02 は `1e-7`、check_04 の相対誤差は `1e-9`）。実測の残差はいずれも `3e-14` 以下。
- **`Z_direct` は分配関数の定義そのもの**（`def_partition_function_2d_ising` の右辺）を
  素朴に総和したものなので、check_04 は `partition_function_via_transfer_matrix` の独立な再確認である。
  同じ主張の厳密計算（Laurent 多項式としての一致）は `252_partition_function_via_transfer_matrix/` にある。
- 直接和のコストは `2^{N_row·M_col}` なので `N_row·M_col ≤ 9` に抑えた。`M_col = 4` は `N_row = 2` のみ。
- `M_col = 2` を含めているのは、`H_1^{(+)}` の境界項の扱いが `M_col = 2` で退化する（中間の `σ^x` が消える）
  ためで、`010_transfer_matrix_bridge.ts` の主張はその場合も含む。
- 行・列番号を以前は `ι` を経由した独自の関数で作っていたが、本文が番号付け `ord` を明示したので
  `ord_number` に置き換えた（並びは同じで、実行結果の残差も以前と同じ桁）。

## 実行方法

```bash
for f in sagemath/check/043_claim_transfer_matrix_bridge/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` と `logs/` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある（2026-09-26、SageMath 10.9）。
