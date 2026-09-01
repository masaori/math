# SageMath Check: 043_claim_transfer_matrix_bridge

## 対象

**対象ラベル**: `partition_function_in_pauli_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/010_transfer_matrix_bridge.ts`
- 併せて検証:
  - `sigma_z_diagonal_action` / `exp_of_diagonal_matrix` / `V1_component_equals_pauli`
  - `two_by_two_transfer_identity` / `V2_component_equals_pauli`
  - `epsilon_projector_properties` / `epsilon_commutes_with_transfer_matrices` / `sector_replacement_of_V1` / `sector_replacement_pow`
  - `partition_function_sector_decomposition`

### 何を確定させるための検証か

001 章は転送行列 `V_1, V_2` を**成分**で定義し、004 章以降は同じ名前の `V_1, V_2` を
**パウリ行列**で定義していたが、**両者が同じ行列であることは本文のどこでも示されていなかった**。
`partition_function_via_transfer_matrix`（`Z = tr((V_1V_2)^M)`）を参照するブロックは
content 全体で 0 件で、004 章以降は 001 章から切り離された島になっていた。

010 章はこの橋を架ける。ここでは

1. 2 通りの `V_1`、2 通りの `V_2` が**行列として一致すること**
2. スピン配置についての**直接和で定義された分配関数**が `tr((V_1V_2)^{N_row})` に一致すること
3. それが `ε` の偶奇セクターに分解できること

を、いずれも定義に戻って数値的に確かめる。とくに 2. は 001 章の主張の独立な再確認でもある。

## 記号の対応（010 章の規約）

| | 001 章 | 004 章以降 / 本ディレクトリ |
|---|---|---|
| 鎖の長さ（転送行列が作用する向き） | `N` | **`M`** |
| 転送の回数 | `M` | **`N_row`** |
| 鎖内（行内）の結合定数 | `J'` | **`K_1`** |
| 鎖間（行間）の結合定数 | `J` | **`K_2`** |

配置 `μ ∈ Map({1..M},{-1,1})` と行・列番号の対応は `def_config_basis_iso` のとおり
（`μ(m) = +1 ↦ i_m = 1`、`μ(m) = -1 ↦ i_m = 2`、先頭因子が最上位）。

## 検証の枠組み

`_prelude.sage` で次を構成する。

| 関数 | 内容 |
|---|---|
| `V1_component(M, K1)` | 001 章の成分定義 `(V_1)_{μ,μ'} = δ_{μ=μ'} exp(Σ_m K_1 μ(m)μ(m+1))` |
| `V2_component(M, K2)` | 001 章の成分定義 `(V_2)_{μ,μ'} = exp(Σ_m K_2 μ(m)μ'(m))` |
| `V1_pauli(O, K1)` | 004 章の `exp(K_1 Σ_m σ^z_m σ^z_{m+1})` |
| `V2_pauli(O, K2)` | 004 章の `(2 sinh 2K_2)^{M/2} exp(K_2^* Σ_m σ^x_m)` |
| `Z_direct(N_row, M, K1, K2)` | 分配関数の**定義そのもの**（`2^{N_row·M}` 通りのスピン配置の直接和） |
| `epsilon_op`, `projectors` | `ε = σ^x_1⋯σ^x_M`、`P^{(±)} = (I ± ε)/2` |
| `V_sym(O,K1,K2,sgn)` | `V^{(±)} = exp(iK_1H_1^{(±)}/2) V_2 exp(iK_1H_1^{(±)}/2)` |

パラメータは `M = 2,3,4`、`(K1,K2)` 数組（`BRIDGE_CASES`）。分配関数の直接和は
`2^{N_row·M}` 通りを回すので `(N_row, M) ∈ {(2,2),(3,2),(2,3),(3,3),(2,4)}` に限った（`Z_CASES`）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_V1_bridge.sage | `V_1` の成分定義とパウリ表示の一致、`σ^z` の対角作用、周期端 `σ_M^zσ_1^z` の作用 | PASS | 全 7 ケース残差 **0.00e+00**（厳密に一致） |
| 02 | check_02_V2_bridge.sage | `2×2` の恒等式、`A` のクロネッカー冪、`V_2` の一致 | PASS | 最大残差 3.0e-14 |
| 03 | check_03_epsilon_projectors.sage | `P^{(±)}` の性質、`ε` の可換性、セクター置き換え | PASS | 最大残差 2.4e-14 |
| 04 | check_04_partition_function.sage | `Z`（直接和）` = tr((V_1V_2)^{N_row})` | PASS | 相対誤差 最大 2.0e-15。取り違えは相対誤差 0.09〜0.44 で明確に不一致 |
| 05 | check_05_sector_decomposition.sage | `Z` の偶奇セクター分解と 4 項展開 | PASS | 相対誤差 最大 2.0e-15 |

## 検証した式

check_01（`V1_component_equals_pauli`）:

```
σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}
σ^z_M σ^z_1 f_{ι(μ)} = μ(M)μ(1) f_{ι(μ)}
(exp(K_1 Σ_m σ^z_m σ^z_{m+1}))_{ι(μ),ι(μ')} = δ_{μ=μ'} exp(Σ_m K_1 μ(m)μ(m+1))
（パウリ表示の V_1 が対角行列であることも確認）
```

check_02（`V2_component_equals_pauli`, `two_by_two_transfer_identity`）:

```
A = [[e^{K_2}, e^{-K_2}], [e^{-K_2}, e^{K_2}]] = (2 sinh 2K_2)^{1/2} exp(K_2^* σ^x)
A ⊗ ⋯ ⊗ A (M 個) = V_2（成分定義）
V_2（成分定義） = (2 sinh 2K_2)^{M/2} exp(K_2^* Σ_m σ^x_m)
```

check_03（`sector_replacement_of_V1` / `sector_replacement_pow` ほか）:

```
ε² = I,  (P^{(±)})² = P^{(±)},  P^{(+)}P^{(-)} = 0,  P^{(+)} + P^{(-)} = I,  ε P^{(±)} = ± P^{(±)}
[ε, V_1] = [ε, V_2] = [ε, V_1^{(±)}] = [ε, (V_1^{(±)})^{1/2}] = 0
V_1 P^{(±)} = V_1^{(±)} P^{(±)}
(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}    (n = 1,2,3)
```

check_04（`partition_function_in_pauli_form`）:

```
Z(J,J') = Σ_s exp( Σ_{i,j} ( J s(i,j)s(i+1,j) + J' s(i,j)s(i,j+1) ) )
        = tr( (V_1 V_2)^{N_row} )        （K_1 = J'、K_2 = J、成分定義でもパウリ表示でも）
```

**結合定数の向きの確定**: `K_1` と `K_2` を取り違えた `tr((V_1(K_2) V_2(K_1))^{N_row})` は、
`N_row ≠ M` のとき `Z` と一致しないことも同じチェックで確認している
（`N_row = M` のときは対称性から一致してしまうので、判定から除外した）。
これが「001 章の `N` が 004 章の `M`、`J' = K_1`、`J = K_2`」という対応の数値的な裏付けである。

check_05（`partition_function_sector_decomposition`）:

```
tr((V_1V_2)^{N_row}) = tr(P^{(+)} (V^{(+)})^{N_row}) + tr(P^{(-)} (V^{(-)})^{N_row})
                     = ½( tr((V^{(+)})^n) + tr(ε(V^{(+)})^n) + tr((V^{(-)})^n) − tr(ε(V^{(-)})^n) )
tr(P^{(±)} (V^{(±)})^n) = tr(P^{(±)} (V_1^{(±)}V_2)^n)     （本文 Step 3 の対称化）
```

## 備考

- **`Z_direct` は分配関数の定義そのもの**（`def_partition_function_2d_ising` の右辺）を
  素朴に総和したものなので、check_04 は 001 章の `partition_function_via_transfer_matrix` の
  独立な再確認にもなっている。
- 直接和のコストは `2^{N_row·M}` なので `N_row·M ≤ 9` に抑えた。`M = 4` は `N_row = 2` のみ。
- `M = 2` を含めているのは、`H_1^{(±)}` の境界項の扱いが `M = 2` で退化する（中間の `σ^x` が消える）
  ためで、010 章の主張はその場合も含む。

## 実行方法

```bash
for f in sagemath/check/043_claim_transfer_matrix_bridge/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
