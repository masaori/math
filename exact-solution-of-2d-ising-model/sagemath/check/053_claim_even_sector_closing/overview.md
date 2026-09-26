# SageMath Check: 053_claim_even_sector_closing

## 対象

**対象ラベル**: `onsager_exact_solution` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/018_even_sector_closing.ts`
- 併せて検証（この章の全ブロック）:
  - `epsilon_anticommutes_with_check_Z_Y`（`ε` は `Z_j, Y_j, Ž_μ, Y̌_μ, ψ̌_μ^†, ψ̌_μ` と反可換、
    したがって `ň_μ, Q̌_ε` とは可換）
  - `epsilon_eigenvalue_on_check_Q`（`εQ̌_ε = η_ε Q̌_ε`、`η_ε ∈ {±1}`、成分を 1 つ動かすと符号が反転、
    `ε = η_{(1,…,1)}(−1)^M Π_μ (I − 2ň_μ)`）
  - `trace_of_epsilon_V_plus_via_check_eigenvalues`
    （`tr(εV^{(+)}) = η_{(1,…,1)}(2 sinh 2K_2)^{M/2} Π_μ 2 sinh(γ(θ~_μ)/2)`）
  - `H1_plus_in_sigma_z_form`（`iH_1^{(+)} = Σ_{m<M} σ^z_m σ^z_{m+1} + ε σ^z_M σ^z_1`）
  - `def_open_chain_spin_energy`（1次元開鎖のスピン配置集合と開鎖エネルギー）
  - `open_chain_partition_sum`（端点因子のない1次元開鎖のスピン和）
  - `open_chain_endpoint_product_sum`（両端のスピンの積を掛けた1次元開鎖のスピン和）
  - `open_chain_spin_sums_positive`（`K > 0` で2つの和がともに正）
  - `trace_of_epsilon_V_plus`
    （**`tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M > 0`**）
  - `max_eigenvector_in_even_sector`（**`η_{(1,…,1)} = +1`**、`ε = (−1)^M Π_μ(I − 2ň_μ)`、
    `im Q̌_{(1,…,1)} ⊆ F^{(+)}`）
  - `check_number_operator_is_hermitian`（`(ψ̌_μ^†)^* = ψ̌_{M+1−μ}`、`ň_μ, Q̌_ε` はエルミート）
  - `c_plus_equals_Lambda_half_integer`（**`c_+(M) = Λ̌_max = Λ^{(1/2)}_M`**）
  - `onsager_exact_solution`（`(1/(M N_row)) log Z` の 2 重極限が Onsager の表式に一致）

### 何を確定させるための検証か

017 章までで `V^{(+)}` の固有値 `Λ̌_ε` はすべて求まり、最大固有値 `Λ̌_max = Λ^{(1/2)}_M` が
**単純**であることも分かっている。しかし 011 章の `c_+(M)`（`ε` の固有値 `+1` のセクター
`F^{(+)}` に制限した Rayleigh 商の上限）と結びつけるには、

> **`Λ̌_max` の固有ベクトルが `F^{(+)}` に属すること**

を示さなければならない。`V^{(+)}` は `C^{2^M}` 全体の行列で、その固有ベクトルが `F^{(+)}` に属するかどうかは
固有値 `Λ̌_ε` の値からは読み取れない。
本章（と本検証）はこの 1 点を決める。

決め方は次のとおり。

1. `ε` は `Z_j, Y_j` と反可換 ⟹ `ψ̌` とも反可換 ⟹ `ň_μ` とは可換。
   `im Q̌_ε` は 1 次元なので `εQ̌_ε = η_ε Q̌_ε`（`η_ε = ±1`）。
2. `ψ̌_μ^†` は `ε_μ` を `0 → 1` に動かし、かつ `ε` と反可換なので `η` の符号を反転させる。
   よって `η_ε = η_{(1,…,1)}(−1)^{M−|ε|}` で、**未知の符号は `η_{(1,…,1)}` ひとつだけ**になる。
3. `tr(εV^{(+)}) = η_{(1,…,1)} (2 sinh 2K_2)^{M/2} Π_μ 2 sinh(γ(θ~_μ)/2)` で、
   `γ(θ~_μ) > 0`（半整数運動量に固有）より `η` 以外は正。
4. 一方 `tr(εV^{(+)})` は**転送行列の側で初等的に計算できる**：
   `iH_1^{(+)} = D_0 + εG` と `exp(K_1 εG) = cosh K_1 · I + sinh K_1 · εG`、
   および 1 次元開鎖のスピン和で
   `tr(εV^{(+)}) = (2e^{−K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M > 0`。
5. よって `η_{(1,…,1)} = +1`。最大固有ベクトルは偶セクターに属する。

## 検証の枠組み

`_prelude.sage` は 050 のものを土台にし（`Ž_μ, Y̌_μ, γ_1, γ_2, γ, P̌_μ, ψ̌, ň_μ, Q̌_ε, X̌, V̌', V^{(+)}`）、
018 章の道具を足してある。

```
ε        := σ^x_1 ⋯ σ^x_M
D_0      := Σ_{m=1}^{M−1} σ^z_m σ^z_{m+1},   G := σ^z_M σ^z_1
W        := V_1^{1/2} V_2 V_1^{1/2}          (V_1 = exp(K_1 Σ_{m=1}^{M} σ^z_m σ^z_{m+1}), 周期境界)
P^{(+)}  := (I + ε)/2
Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp((1/2) Σ_{μ=1}^{M} γ(2π(μ−δ)/M))
```

`V^{(+)}`、`W`、`V̌'` はいずれも**行列指数関数から直接構成する**（証明が使う交換子の級数展開や
フェルミオン化とは独立な経路）。`c_+(M)` は
`F^{(+)} ∩ R^{2^M}` の正規直交実基底 `(e_k + e_{k̄})/√2` へ `W` を制限した実対称行列の
最大固有値として**直接**求める（`Λ̌_ε` を経由しない）。`c(M)` は `W` の最大固有値である。

パラメータ:

- `M = 2, 3, 4, 5`、`ε ∈ {0,1}^M` は**全列挙**
- `(K_1, K_2)` は 6 組。**厳密な臨界点**（`K_2 = arcsinh(1/sinh 2K_1)/2`）2 組（非等方・等方）、
  臨界点近傍 1 組、一般点 2 組、高温側 1 組
- 開鎖スピン和は `M = 2,…,8`、`K = 0.05, 0.4, 1.2, 2.5` を全配置で列挙
  （`M = 8, K = 2.5` では項が `e^{17.5}` に達し倍精度では丸めが `1e-8` まで積み上がるため、
  200 bit の実数で計算している）
- 熱力学極限は `M = 4, 16, 64, 256, 1024, 4096` で `(1/M) log Λ^{(δ)}_M` を対数のまま計算し、
  `numerical_integral` による Onsager 積分と比較

判定閾値は `TOL = 1e-8`（`report()` で最大残差と比較）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_epsilon_anticommutation.sage | `epsilon_anticommutes_with_check_Z_Y` の (1)〜(4)。あわせて 010 章 Step 1 の `εσ^x_k = σ^x_kε`, `εσ^{y,z}_k = −σ^{y,z}_kε` | PASS | 残差 ≤ 1.3e-15（(1)(2)(3) は 0.0） |
| 02 | check_02_epsilon_parity.sage | `epsilon_eigenvalue_on_check_Q` (1)〜(4) と `max_eigenvector_in_even_sector` (1)〜(4)。`{0,1}^M` を全列挙し、`η_ε ∈ {±1}`、反転則、`ψ̌_μ^† Q̌_ε ≠ 0`、`η_ε = (−1)^{M+|ε|}`、`ε = (−1)^M Π(I−2ň_μ)`、`εQ̌_max = +Q̌_max` | PASS | 残差 ≤ 1.2e-14、反転則・予測式の違反 0 件、`‖ψ̌_μ^†Q̌_ε‖` の最小 6.58e-1 |
| 03 | check_03_trace_epsilon_V_plus.sage | `def_D0_open_chain_operator`、`def_G_boundary_operator`、`H1_plus_in_sigma_z_form`、`D0_G_diagonal_action`、`epsilon_D0_G_pairwise_commute`、`epsilon_G_is_involution`、`def_open_chain_spin_energy`、`open_chain_partition_sum`、`open_chain_endpoint_product_sum`、`open_chain_spin_sums_positive`、`trace_of_epsilon_V_plus`、`trace_of_epsilon_V_plus_via_check_eigenvalues` | PASS | Pauli 恒等式の残差 0.0、開鎖和 1.4e-52（200 bit）、トレースの閉じた式の相対差 ≤ 5.2e-15、`tr(εV^{(+)})` の最小 3.30 > 0 |
| 04 | check_04_hermitian_and_c_plus.sage | `check_number_operator_is_hermitian` (1)〜(4)（`conj(α_μ) = −α_{M+1−μ}` を含む）、`V^{(+)}, W` の実対称性、`W` の成分の正値性、`WP^{(+)} = V^{(+)}P^{(+)}`、**`c_+(M) = Λ^{(1/2)}_M`**、最大固有ベクトルが実で `εq = q` | PASS | 残差 ≤ 5.2e-12、`c_+(M) = Λ^{(1/2)}_M` の相対差 ≤ 1.7e-15 |
| 05 | check_05_free_energy_limit.sage | `onsager_exact_solution`。(1) Step 2 の `c(M) ≥ c_+(M) = Λ^{(1/2)}_M`、(2) Step 3 の式変形を一行ずつ（`u = |x|`、`v = u + εu`、`εv = v`、`‖v‖² ≤ 4`、`v^⊤Wv ≥ 2u^⊤Wu`、`Λ^{(1/2)}_M ≥ x^⊤Wx/2`）、(3) 挟み撃ち `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M`、(3') 観測 `c(M) = c_+(M)`、(5) `|(1/(MN))log tr(W^N) − (1/M)log c(M)| ≤ log2/N`、(4) `(1/M)log Λ^{(δ)}_M` の Onsager 積分への収束（`δ = 0, 1/2` の両方） | PASS | Step 3 の等式の残差 ≤ 1.0e-14、不等式の違反 0 件（`x` 192 本）、挟み撃ちの違反 0 件、`c(M) = c_+(M)` の相対差 ≤ 1.9e-15、`M=4096` で Onsager との差 ≤ 1.6e-8（臨界点） |

## 結論

- `ε` は `Z_j, Y_j` と反可換であり、したがって `ψ̌_μ^†, ψ̌_μ` とも反可換、`ň_μ, Q̌_ε` とは可換
  （check_01、残差 ≤ 1.3e-15）。
- `εQ̌_ε = η_ε Q̌_ε` で `η_ε = (−1)^{M+|ε|}`、すなわち **`ε = (−1)^M Π_{μ=1}^{M}(I − 2ň_μ)`**
  （check_02、残差 ≤ 1.2e-14）。とくに `εQ̌_{(1,…,1)} = +Q̌_{(1,…,1)}` で、
  **`V^{(+)}` の最大固有ベクトルは偶セクターに属する**。
- 符号を決める鍵の等式 **`tr(εV^{(+)}) = (2e^{−K_2}cosh K_1)^M + (2e^{K_2}sinh K_1)^M`** が
  `M = 2,3,4,5`・6 組の `(K_1,K_2)` すべてで相対差 `5.2e-15` 以下で成立し、値は常に正
  （check_03）。この式は `iH_1^{(+)} = D_0 + εG`（残差 `0.0`）と 1 次元開鎖のスピン和から出る。
- **`c_+(M) = Λ^{(1/2)}_M`**（check_04、相対差 ≤ 1.7e-15）。`c_+(M)` は `Λ̌_ε` を経由せず、
  `W` を `F^{(+)} ∩ R^{2^M}` へ制限した実対称行列の最大固有値として直接求めている。
- 本文 Step 2 の `c(M) ≥ c_+(M) = Λ^{(1/2)}_M` と、Step 3 の各行（任意の単位ベクトル `x` から `u = |x|`、
  `v = u + εu ∈ F^{(+)} ∩ R^{2^M}` を作って `Λ^{(1/2)}_M ≥ x^⊤Wx/2` を得る鎖）が成り立ち、
  `Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` が全パラメータで成立（check_05）。
  したがって `(1/M) log c(M)` は `(1/M) log Λ^{(1/2)}_M` と同じ極限をもち、
  それは Onsager の表式 `(1/2)log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ(θ)dθ` である
  （`M = 4096` で差 `1.6e-8` 以下。`δ = 0` でも同じ値へ収束する）。

## 本文が主張しないこと（一次情報で確認した）

本文の Step 3 の係数 `2` は最良ではない。check_05 の (3') のとおり、数値上は `c(M) = c_+(M)` が全パラメータで
成り立つ（相対差 ≤ 1.9e-15）が、本文はこの強い形を使っていない。`1/M` を掛けて `M → ∞` とすると
`log 2 / M → 0` で消えるので、Onsager の表式には影響しない。

## (−) セクターの退避に伴う更新（2026-09-26）

(−) セクターを本文から外したとき、`onsager_exact_solution` の Step 2 は `c_plus_le_c`（`c_+(M) ≤ c(M)`）を、
Step 3 は `epsilon_is_real_symmetric`（`ε^⊤ = ε`）・`epsilon_commutes_with_W`・`epsilon_square_and_eigenvalues` を引く形に変わり、
`c(M) = max(c_+(M), c_−(M))` は参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避された。
これに合わせて check_05 を書き直し、2026-09-26 に再実行した（`run-log.txt` の check_05 の節。check_01〜04 は変更していない）。

書き直す前の check_05（`c(M) = max(c_+, c_−)` と、対照 `c_−(M)` 対 `Λ^{(0)}_M`）は
`sagemath/_old/minus-sector/053_claim_even_sector_closing/` に残してある。そこの出力が、
**`c_−(M) = Λ^{(0)}_M` は一般には成り立たない**（高温側 `(K_1,K_2) = (0.05, 0.1)` で `c_−(M)/Λ^{(0)}_M = 0.1102`）
ことの一次情報である。本文の `onsager_exact_solution` の `conversion.notes` が引く「check_05 (3')」は、
書き直した check_05 でも同じ番号（`c(M) = c_+(M)` の観測）で残してある。

## 実行

```bash
cd sagemath/check/053_claim_even_sector_closing
for f in check_0*.sage; do /usr/local/bin/sage "$f"; done
```

実行出力は `run-log.txt`。
