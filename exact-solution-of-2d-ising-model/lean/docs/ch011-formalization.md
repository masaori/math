# 章 011「転送行列の最大固有値と分配関数の挟み撃ち」の Lean 形式化

正本: `structured-latex/content/011_max_eigenvalue.ts`（12 ブロック）

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択

章 011 は**実行列 `W ∈ Mat(2^M, ℝ)` と実ベクトル空間 `ℝ^{2^M}`** の上の議論なので、
他章の `TensorPow M = Matrix (Conf M) (Conf M) ℂ`（複素）ではなく
`Matrix n n ℝ`（`n` は有限型。Ising では `n = Conf M` で `Fintype.card n = 2^M`）を土台にした。
ベクトルは `n → ℝ`、ユークリッドノルムは `Ising2D.vecNormSq` / `Ising2D.vecNorm` として
自前で定義してある（`n → ℝ` に mathlib が入れる既定のノルムは sup ノルムなので使えない）。

**スペクトル定理（実対称行列の対角化可能性）は一切使っていない。**
上からの評価は `rayleigh_bounds_operator_norm` から、下からの評価はモーメント列
`m_k = xᵀW^k x` の対数凸性から出しており、人手証明の経路と 1 対 1 に対応する。

## 1. 形式化した定理の一覧

### 1.1 具体版（`lean/Ising2D/Part011/`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.psd_cauchy_schwarz` | `(yᵀPx)² ≤ (xᵀPx)(yᵀPy)`（`P` 実対称半正定値） | `psd_cauchy_schwarz` |
| `Ising2D.rayleighSet` / `Ising2D.rayleighSup` | `𝓡 = {xᵀWx : ‖x‖=1}` と `c(M) := sup 𝓡` | `def_rayleigh_sup` |
| `Ising2D.rayleighSet_nonempty` / `rayleighSet_bddAbove` | `𝓡` は空でなく上に有界 | 同上 |
| `Ising2D.le_rayleighSup` | 単位ベクトルで `xᵀWx ≤ c(M)` | 同上 |
| `Ising2D.quad_le_rayleighSup_mul` | 任意の `x` で `xᵀWx ≤ c(M)‖x‖²` | 同上 |
| `Ising2D.rayleighSup_nonneg` / `rayleighSup_pos` | `c(M) ≥ 0` / `c(M) > 0` | 同上（本文は `𝓡 ⊆ ℝ_{>0}` と書いている） |
| `Ising2D.rayleigh_bounds_operator_normSq` | `‖Wx‖² ≤ c(M)²‖x‖²` | `rayleigh_bounds_operator_norm` |
| `Ising2D.rayleigh_bounds_operator_norm` | `‖Wx‖ ≤ c(M)‖x‖` | 同上 |
| `Ising2D.rayleigh_bounds_operator_norm_pow` | `‖W^k x‖ ≤ c(M)^k‖x‖` | 同上（帰納法の部分） |
| `Ising2D.psd_quad_le_normSq_mul_trace` | `xᵀAx ≤ ‖x‖² tr A`（`A` 半正定値） | `trace_power_sandwich` Step 3 の補題 |
| `Ising2D.psd_abs_entry_le` | `\|A_ij\| ≤ √(A_ii)√(A_jj)` | 同上 |
| `Ising2D.trace_pow_le` | `tr(W^n) ≤ (dim) c(M)^n` | `trace_power_sandwich` Step 1 |
| `Ising2D.quad_pow_le_trace_pow` | 単位 `x` で `(xᵀWx)^n ≤ tr(W^n)` | 同 Step 2・Step 3 |
| `Ising2D.rayleighSup_pow_le_trace_pow` | `c(M)^n ≤ tr(W^n)` | 同 Step 3 の `sup` を取る操作 |
| **`Ising2D.trace_power_sandwich`** | `c(M)^n ≤ tr(W^n) ≤ (dim) c(M)^n` | **`trace_power_sandwich`** |
| `Ising2D.symTransfer` | `W := B V₂ B`（`B = V₁^{1/2}`） | `def_symmetrized_transfer_matrix` |
| `Ising2D.symTransfer_pow_succ` | `(BV₂B)^{k+1} = B(V₂BB)^k V₂ B` | `Z_equals_trace_of_W` の括り直し |
| `Ising2D.mul_pow_mul_eq` | `V₁(V₂V₁)^k V₂ = (V₁V₂)^{k+1}` | 同上の最後の等号 |
| **`Ising2D.trace_symTransfer_pow`** | `tr(W^n) = tr((V₁V₂)^n)` | **`Z_equals_trace_of_W`** |
| `Ising2D.symTransfer_isSymm` | `W` は実対称 | `W_is_real_symmetric_positive_definite` Step 3 |
| `Ising2D.symTransfer_posDef` | `W` は正定値（合同変換） | 同上 |
| `Ising2D.mulVec_eq_zero_iff_of_isUnit` | 可逆行列の `mulVec` は単射 | 同上「可逆性」 |
| `Ising2D.diagExp` ほか（`diagExp_isSymm`, `diagExp_mul_self`, `diagExp_isUnit`, `diagExp_posDef`） | 正の対角行列としての `V₁^{1/2}` と `V₁^{1/2}V₁^{1/2} = V₁` | `def_transfer_matrix_square_root`, `W_has_positive_entries` Step 1 |
| `Ising2D.matExp_isSymm` / `Ising2D.matExp_posDef` | 実対称行列の `exp` は実対称正定値 | `exp_hermitian_is_positive_definite` の実行列版（章 009 への接続点） |
| **`Ising2D.symTransfer_entry_pos`** | `W` の成分はすべて正 | **`W_has_positive_entries`** |
| **`Ising2D.partition_function_sandwich`** | `c(M)^{N_row} ≤ Z ≤ (dim) c(M)^{N_row}` | **`partition_function_sandwich`** |
| `Ising2D.sectorSet` / `Ising2D.sectorRayleighSup` | `𝓡_±` と `c_±(M)` | `def_sector_rayleigh_sup` |
| `Ising2D.sector_invariant` | `W` は `F^{(±)}` を保つ | `epsilon_commutes_with_W` |
| `Ising2D.sector_orthogonal` | 異なる固有値の固有ベクトルは直交 | `sector_decomposition_of_rayleigh_sup` (3) の `x₊ᵀx₋ = 0` |
| `Ising2D.projPlus` / `projMinus` / `proj_add_eq_one` / `projPlus_mulVec_eigen` / `projMinus_mulVec_eigen` | `P^{(±)} = (1±ε)/2` とその性質 | `def_epsilon_projectors` の実行列版 |
| `Ising2D.sector_quad_le` | セクター内で `xᵀWx ≤ c_±‖x‖²` | `sector_decomposition_of_rayleigh_sup` (3) |
| **`Ising2D.sector_decomposition_of_rayleigh_sup`** | `c(M) = max(c₊(M), c₋(M))` | **`sector_decomposition_of_rayleigh_sup` (3)** |

補助（`Part011/Basic.lean`）: `matBilin`, `dotProduct_mulVec_comm`,
`mulVec_dotProduct_selfadjoint`, `single_dotProduct_mulVec_single`,
`vecNormSq` 系, `mulVecLin_pow`, `isPsdPair_of_matrix`, `isPdPair_of_matrix`。

### 1.2 必要十分版（`lean/Ising2D/NecSuf/`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.NecSuf.psd_cauchy_schwarz` | 順序体上の加群の対称半正定値双線型形式に対する Cauchy–Schwarz | `psd_cauchy_schwarz` |
| `Ising2D.NecSuf.bilin_quadratic_expand` | `q(t) = B(y+tx, y+tx)` の展開 | 同上の証明の 1 行目 |
| `Ising2D.NecSuf.IsPsdPair` / `IsPdPair` | 「対称半正定値形式 `ip` と、それについて自己共役かつ（半）正定値な作用素 `W`」の組 | `W_is_real_symmetric_positive_definite` の使われ方の抽象化 |
| `NecSuf.IsPsdPair.cs_ip` / `cs_W` | `P = I` 版・`P = W` 版の Cauchy–Schwarz | `psd_cauchy_schwarz` の 2 通りの使い方 |
| `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm` | `⟪Wx,Wx⟫ ≤ c²⟪x,x⟫` | `rayleigh_bounds_operator_norm` |
| `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm_pow` | `⟪W^k x, W^k x⟫ ≤ (c²)^k⟪x,x⟫` | 同上（帰納法） |
| `NecSuf.IsPsdPair.moment_split` | `⟪W^p x, W^q x⟫ = ⟪x, W^{p+q}x⟫` | Step 2 の書き換え |
| `NecSuf.IsPsdPair.moment_nonneg` / `moment_le_pow` | `0 ≤ m_k`、`m_k ≤ c^k⟪x,x⟫` | Step 1 の偶奇の場合分け |
| `NecSuf.IsPsdPair.moment_log_convex` | `m_{k+1}² ≤ m_k m_{k+2}` | Step 2 |
| `NecSuf.IsPdPair.moment_pos` / `W_ker` / `pow_ne_zero_of_ne_zero` | `m_k > 0`、`W` の核は `{0}` | Step 2 冒頭・`W` の可逆性 |
| `NecSuf.IsPdPair.moment_ratio_le` / `moment_pow_le` | 比の単調性と `(xᵀWx)^n ≤ m_n` | Step 3 前半 |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `psd_cauchy_schwarz` | `Ising2D.psd_cauchy_schwarz` | `Ising2D.NecSuf.psd_cauchy_schwarz` | **はい**（`matBilin P` を代入） |
| `rayleigh_bounds_operator_norm` | `Ising2D.rayleigh_bounds_operator_norm(Sq)(_pow)` | `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm(_pow)` | **はい**（`isPsdPair_of_matrix` 経由） |
| `trace_power_sandwich` | `Ising2D.trace_power_sandwich` | `NecSuf.IsPsdPair.moment_le_pow` / `moment_log_convex` / `NecSuf.IsPdPair.moment_pow_le` | 不等式の中核部分は**はい**。跡と `sup` の部分は ℝ 固有なので具体版のみ |
| `Z_equals_trace_of_W` | `Ising2D.trace_symTransfer_pow` | なし（下記） | — |
| `W_is_real_symmetric_positive_definite` | `Ising2D.symTransfer_isSymm` / `symTransfer_posDef` | なし（下記） | — |
| `W_has_positive_entries` | `Ising2D.symTransfer_entry_pos` | なし（下記） | — |
| `partition_function_sandwich` | `Ising2D.partition_function_sandwich` | なし（`trace_power_sandwich` の言い換え） | — |
| `sector_decomposition_of_rayleigh_sup` | `Ising2D.sector_decomposition_of_rayleigh_sup` | なし（下記） | — |

### 必要十分版で判明した本質

- **`psd_cauchy_schwarz` に効いているのは 3 つだけ**である:
  係数が**順序体**であること（`t = -(yᵀPx)/(xᵀPx)` を代入する割り算）、形式が**双線型**であること、
  形式が**対称かつ半正定値**であること。
  行列であること・実数であること・有限次元であること・完備性・連続性・平方根は効いていない。

- **`rayleigh_bounds_operator_norm` の `‖Wx‖ ≤ c‖x‖` に平方根は効いていない。**
  必要十分版は `⟪Wx,Wx⟫ ≤ c²⟪x,x⟫` という平方根を取る前の形で、順序体の上で成り立つ。
  平方根は「ノルム」という言い方をするためだけのもので、証明の内容ではない。
  効いているのは Cauchy–Schwarz（上記 3 条件）と、`W` が形式について自己共役かつ半正定値であることだけ。
  有限次元性・行列であること・実数であること・**スペクトル定理**はいずれも効いていない。

- **`trace_power_sandwich` の不等式の中核（Step 1〜Step 3 前半）も順序体で閉じている。**
  モーメントの対数凸性 `m_k² ≤ m_{k-1}m_{k+1}` も、比の単調性から出る `(xᵀWx)^n ≤ m_n` も、
  実数性を全く使わない。ℝ が本質的に効くのは次の 2 箇所だけである。
  1. `c(M) = sup 𝓡` が存在すること（ℝ の完備性そのもの）。
  2. `m_n ≤ tr(W^n)` の証明（`|A_kl| ≤ √(A_kk A_ll)` で平方根を使う）。
  つまり**この章で「実数への脱出」が必要なのはこの 2 点だけ**であり、
  行列の対角化可能性も固有値の存在も要らない。

- **`W` の対称性・正定値性・成分の正値性、および `Z = tr(W^n)` は、
  抽象化しても失われる構造がない。**
  `Z = tr(W^n)` に効いているのは結合法則と跡の巡回性 `tr(AB) = tr(BA)` だけで、
  Lean 側の `Ising2D.trace_symTransfer_pow` は `B * B = V₁` 以外の仮定を一切置いていない
  （`V₂` も任意の行列でよい）。正定値性は「合同変換 `B*AB` が正定値性を保つ」ことに尽き、
  Lean 側は `B` が対称かつ**可逆**であることしか使っていない（`B` が `exp` であることは不要）。
  成分の正値性は「正の対角行列で挟むと成分の正値性が保たれる」だけである。
  いずれも既に最小の仮定で述べてあるため、別ファイルの必要十分版は置いていない。

- **セクター分解に効いているのは「対称な対合 `ε`（`ε² = 1`）で `W` と可換なもの」だけ**である。
  `ε` が `σ^x` の積であることも、`W` が転送行列であることも効いていない。
  Lean 側の `Ising2D.sector_decomposition_of_rayleigh_sup` はすでにその一般性で述べてあるので、
  別途の必要十分版は置いていない。

## 3. 他章に仮定として置いた事実

章 009 / 010 の Lean 形式化は本タスクの担当外なので、次を **import せず仮定として受け取っている**。
（`Part011/Definition001_SymmetrizedTransferMatrix.lean` と
`Part011/Claim009_PartitionFunctionSandwich.lean` の冒頭コメントにも明記した。）

| 仮定 | 対応する人手証明 | Lean での受け取り方 |
| --- | --- | --- |
| `Z(J,J') = tr((V₁V₂)^{N_row})` | `partition_function_in_pauli_form`（章 010） | `partition_function_sandwich` の引数 `hZ` |
| `V₁^{1/2}` が正の対角行列 | `sigma_z_diagonal_action` + `exp_of_diagonal_matrix`（章 009） | `Ising2D.diagExp d`（`d : n → ℝ`）として与える。`d μ = (1/2)K₁∑_m μ(m)μ(m+1)` に対応 |
| `V₂` の成分がすべて正 | `V2_component_equals_pauli`（章 010） | `symTransfer_entry_pos` の引数 `hV2` |
| `V₂` が実対称正定値 | `iH_is_real_symmetric` + `exp_hermitian_is_positive_definite`（章 009） | `symTransfer_posDef` / `partition_function_sandwich` の引数。**`Ising2D.matExp_posDef` を本ファイルで証明してあるので、章 009 が形式化されればそのまま接続できる** |
| `ε` が実対称・`ε² = 1`・`εW = Wε` | `epsilon_commutes_with_transfer_matrices`（章 009/010） | `sector_decomposition_of_rayleigh_sup` の引数 `hε`, `hεε`, `hcomm` |

## 4. 形式化できなかった主張とその理由

| 人手証明 | 状況 | 理由 |
| --- | --- | --- |
| `symmetrized_transfer_matrix_on_sectors` `W P^{(±)} = V^{(±)}P^{(±)}` | **未形式化** | `V^{(±)}`, `V₁^{(±)}`, `sector_replacement_of_V1`, `V1_restriction_to_eigenspaces` に依存する。これらは章 004 / 010 の対象で、本タスクの担当範囲外（既存 `.lean` の編集も禁止）。記録は `docs/tasks/2026-07_lean-ch009-013/002_ch011-sector-sup-nonempty-gap.md` |
| `maxeig_000_remark_overview` | 形式化対象外 | 章の目的を述べた注記であり数学的主張ではない |

（上記以外の 10 ブロックはすべて形式化済み。`sorry` / `admit` はゼロ。）

## 5. 人手証明に見つけた問題

`structured-latex/` は編集していない。見つけた点は次に記録した。

1. `docs/tasks/2026-07_lean-ch009-013/001_ch011-moment-log-convexity-index-error.md`
   — `trace_power_sandwich` Step 2 で、モーメント対数凸性を導くための `(a, b)` の指定が誤っている
   （結論は正しい）。正しい添字を表で示した。
2. `docs/tasks/2026-07_lean-ch009-013/002_ch011-sector-sup-nonempty-gap.md`
   — `sector_decomposition_of_rayleigh_sup` (3) で `c_±(M)` の `sup` が定義できること
   （`F^{(±)}` に単位ベクトルが存在すること）の根拠が本文に無い。

## 6. 検証結果

```
cd exact-solution-of-2d-ising-model/lean
lake build                 # exit 0
./scripts/check-no-sorry.sh # exit 0（新規定理 91 本を targets に追加済み）
```
