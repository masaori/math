# 章 019「最大固有値の所在（偶セクターへの確定）」の Lean 形式化

正本: `structured-latex/content/019_max_eigenvalue_sector.ts`（6 ブロック）

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択

章 019 は章 011 の続き（Rayleigh 商の上限 `c(M)`, `c_±(M)`）なので、土台は章 011 と同じ
**実行列 `Matrix (Conf M) (Conf M) ℝ` と実ベクトル `Conf M → ℝ`** である
（`Conf M = Fin M → Fin 2` で `Fintype.card (Conf M) = 2^M`）。

一方、`ε = σ^x_1 ⋯ σ^x_M` は章 004 で**複素行列** `Ising2D.epsilon M : TensorPow M` として
定義されている。そこで実行列版 `Ising2D.epsilonR M` を新たに置き、
**両者の成分が一致すること**を `Ising2D.epsilon_eq_ofReal_epsilonR` で証明して橋渡しした。
`ε` の成分は `0` と `1` しかない（人手証明 (1)）ので、この同一視で値は落ちない。

**Perron–Frobenius 系の補題・スペクトル定理・行列の対角化可能性は一切使っていない。**
使ったのは有限個の実数の和・積・絶対値と三角不等式、および実数の上限（`sSup`）だけで、
人手証明の経路（成分ごとの不等式）と 1 対 1 に対応する。実数解析（極限・積分・連続性）へは
移行していない。

## 1. 形式化した定理の一覧

### 1.1 具体版（`lean/Ising2D/Part019/`）

#### `Claim001_EpsilonSignFlipPermutation.lean`（ラベル `epsilon_is_sign_flip_permutation`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.flipIdx` / `Ising2D.flipConf` | 1 サイトの符号反転と、配置全体の符号反転 `π` | `π(k) =`（配置 `-s_k` の番号） |
| `Ising2D.sgn_flipConf` | `ι` の同一視のもとで `flipConf` が `μ ↦ -μ` であること | `(-s_k)(m) = -s_k(m)` |
| `Ising2D.epsilonR` | 実行列版の `ε`（`π` の置換行列） | (1) |
| `Ising2D.epsilon_apply` | **`ε_{l,k} = δ_{k, π(l)}`**（複素側の成分表示） | (1) |
| `Ising2D.epsilon_eq_ofReal_epsilonR` | 複素の `ε` と実行列 `ε` の成分の一致 | (1)（新規。実／複素の橋渡し） |
| `Ising2D.epsilon_mulVec_basisVec` | **`ε f_I = f_{π(I)}`** | (1) |
| `Ising2D.epsilonR_entry_zero_or_one` | 成分はすべて `0` か `1` | (1) |
| `Ising2D.epsilonR_row_sum` / `epsilonR_col_sum` | 各行・各列にちょうど 1 個の `1` | (1) |
| `Ising2D.epsilonR_isSymm` / `epsilonR_mul_self` | `ε` は対称・対合 | (1)(2) の帰結 |
| `Ising2D.flipConf_involutive` | **`π∘π = id`** | (2) |
| `Ising2D.flipConf_ne_self` | **`π(k) ≠ k`**（`M ≥ 1`） | (2) |
| `Ising2D.epsilonR_mulVec_apply` | **`(εx)_k = x_{π(k)}`** | (3) |
| `Ising2D.epsilonR_mulVec_single` | `ε e_k = e_{π(k)}`（実行列版） | (1) |
| `Ising2D.oddUnit` | **`x_0 = (1/√2)(e_1 - e_{π(1)})`** | (4) |
| `Ising2D.epsilonR_mulVec_oddUnit` | **`ε x_0 = -x_0`**（`x_0 ∈ 𝓕^{(-)}`） | (4) |
| `Ising2D.vecNormSq_oddUnit` | **`‖x_0‖ = 1`**（`M ≥ 1`） | (4) |
| `Ising2D.sectorSet_neg_nonempty_epsilonR` | `𝓡_- ≠ ∅` | (4) の使い道 |
| `Ising2D.sectorSet_pos_nonempty_epsilonR` | `𝓡_+ ≠ ∅` | `c_minus_le_c_plus` Step 1 |

#### `Claim002_AbsVectorEvenSector.lean`（ラベル `abs_vector_moves_to_even_sector`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.epsilonR_mulVec_absVec` | **`εu = u`**（`x ∈ 𝓕^{(-)} ⇒ u = (|x_k|)_k ∈ 𝓕^{(+)}`） | (1) |
| `Ising2D.vecNormSq_absVec_eq` | **`‖u‖ = ‖x‖`** | (2) |
| `Ising2D.abs_quad_le_quad_absVec_epsilonR` | `uᵀWu ≥ |xᵀWx|` | (3) 第 1 の不等号 |
| `Ising2D.quad_le_quad_absVec_epsilonR` | **`uᵀWu ≥ xᵀWx`**（本文どおり `W_{kl} > 0` を仮定） | (3) |
| `Ising2D.quad_le_quad_absVec_epsilonR_of_nonneg` | 同上の非負版（`0 ≤ W_{kl}` だけ） | (3)（必要十分版で判明した最小の仮定） |
| `Ising2D.exists_even_sector_unit_ge` | (1)(2)(3) をまとめた形 | Step 2 で使う形 |

#### `Theorem003_CMinusLeCPlus.lean`（ラベル `c_minus_le_c_plus`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| `Ising2D.sectorSet_bddAbove_epsilonR` | `𝓡_±` は上に有界 | Step 1 |
| `Ising2D.sectorSet_neg_nonempty_bddAbove` / `..._pos_...` | `𝓡_±` は空でなく上に有界（`c_±(M) ∈ ℝ`） | Step 1 |
| `Ising2D.quad_le_sectorRayleighSup_pos` | **`x ∈ 𝓕^{(-)}, ‖x‖=1 ⇒ xᵀWx ≤ c_+(M)`** | Step 2 |
| **`Ising2D.c_minus_le_c_plus`** | **`c_-(M) ≤ c_+(M)`** | **定理本体（Step 3）** |
| `Ising2D.c_minus_le_c_plus_of_nonneg` | 同上（`0 ≤ W_{kl}` だけを仮定） | 同上 |
| `Ising2D.isUnit_diagonal_of_pos` | 成分の正な対角行列は可逆 | 補助 |
| `Ising2D.c_minus_le_c_plus_symTransfer` | 章 011 の `W = V_1^{1/2}V_2V_1^{1/2}` への特殊化 | 同上 |

#### `Theorem004_CEqualsCPlus.lean`（ラベル `c_equals_c_plus`）

| Lean の名前 | 内容 | 人手証明 |
| --- | --- | --- |
| **`Ising2D.c_equals_c_plus`** | **`c(M) = c_+(M)`（無条件）** | **Step 1** |
| `Ising2D.c_equals_c_plus_symTransfer` | 章 011 の `W` への特殊化 | 同上 |
| `Ising2D.rayleighSup_eq_of_sectorRayleighSup_pos_eq` | `c_+(M) = Λ ⇒ c(M) = Λ` | Step 2（`c_plus_equals_Lambda_half_integer` は未形式化なので仮定） |
| `Ising2D.rayleighSup_attained_in_even_sector` | 偶セクターの `x_0` が `c_+(M)` を達成すれば `c(M)` を達成する | Step 3（同上） |
| `Ising2D.rayleighSup_mem_rayleighSet` | 上限が達成される（`c(M) ∈ 𝓡`） | Step 3 の結論 |

### 1.2 必要十分版（`lean/Ising2D/NecSuf/PermSector.lean`、名前空間 `Ising2D.NecSuf`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `NecSuf.permMat` | 写像 `π : n → n` の置換行列 `(permMat π)_{ij} = δ_{j,π(i)}` | `epsilon_is_sign_flip_permutation` (1) |
| `NecSuf.permMat_entry_zero_or_one` / `permMat_row_sum` | 成分は `0/1`、各行の和は `1` | 同 (1) |
| `NecSuf.permMat_mulVec` | `(εx)_i = x_{π(i)}` | 同 (3) |
| `NecSuf.permMat_mulVec_single` | `ε e_k = e_{π(k)}` | 同 (1) |
| `NecSuf.permMat_isSymm` / `permMat_mul_self` | 対合の置換行列は対称・対合 | 同 (1)(2) の帰結 |
| `NecSuf.absVec` | `u_k := |x_k|` | `abs_vector_moves_to_even_sector` |
| `NecSuf.permMat_mulVec_absVec` | `εx = -x ⇒ εu = u` | 同 (1) |
| `NecSuf.vecNormSq_absVec` | `‖u‖ = ‖x‖` | 同 (2) |
| `NecSuf.quad_eq_sum` | `xᵀWx = Σ_k Σ_l x_k W_{kl} x_l` | 同 (3) の成分表示 |
| `NecSuf.abs_quad_le_quad_absVec` / `quad_le_quad_absVec` | `uᵀWu ≥ |xᵀWx| ≥ xᵀWx`（仮定は `0 ≤ W_{kl}` だけ） | 同 (3) |
| `NecSuf.sectorSet_nonempty_of_mem` | セクターに非零ベクトルがあれば正規化できる | `c_minus_le_c_plus` Step 1 |
| `NecSuf.sectorSet_pos_nonempty` | `𝓡_+ ≠ ∅`（`π` の不動点の有無によらない） | 同 Step 1 |
| `NecSuf.sectorSet_neg_nonempty` | `𝓡_- ≠ ∅`（`π` が不動点をもたないことだけを使う） | `epsilon_is_sign_flip_permutation` (4) |
| `NecSuf.sectorRayleighSup_nonneg` | `c_s ≥ 0` | 同 Step 1 |
| **`NecSuf.sectorRayleighSup_neg_le_pos`** | **`c_-(M) ≤ c_+(M)`** | **`c_minus_le_c_plus`** |
| **`NecSuf.rayleighSup_eq_sectorRayleighSup_pos`** | **`c(M) = c_+(M)`** | **`c_equals_c_plus` Step 1** |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `epsilon_is_sign_flip_permutation` | `Ising2D.epsilon_apply` / `epsilonR_*` / `oddUnit` 系（`Conf M` 上の `ε = σ^x_1⋯σ^x_M`） | `NecSuf.permMat_*`（任意の有限型 `n` と任意の対合 `π`） | (1) の成分計算（`σ^x` のクロネッカー積）以外は**すべて系** |
| `abs_vector_moves_to_even_sector` | `Ising2D.epsilonR_mulVec_absVec` / `vecNormSq_absVec_eq` / `quad_le_quad_absVec_epsilonR` | `NecSuf.permMat_mulVec_absVec` / `vecNormSq_absVec` / `quad_le_quad_absVec` | **すべて系** |
| `c_minus_le_c_plus` | `Ising2D.c_minus_le_c_plus`（`ε = epsilonR M`） | `NecSuf.sectorRayleighSup_neg_le_pos` | **系** |
| `c_equals_c_plus` | `Ising2D.c_equals_c_plus` | `NecSuf.rayleighSup_eq_sectorRayleighSup_pos` | **系** |

### 必要十分版で判明した本質（本文には持ち込まない）

- **章 019 の議論に効いているのは次の 3 つだけである。**
  1. **`ε` が「ある対合 `π : n → n` の置換行列」であること。** 効くのは
     `(εx)_k = x_{π(k)}` という成分表示ただ 1 つで、`ε = σ^x_1 ⋯ σ^x_M` であることも、
     添字型が `Conf M = Fin M → Fin 2` であることも、`π` がスピン配置の符号反転であることも、
     `M` の値も効いていない。
  2. **`W` の成分が非負であること。** 人手証明は `W_has_positive_entries`（**狭義の正**）を引くが、
     三角不等式に必要なのは `0 ≤ W_{kl}` だけである。`W` が転送行列であることも、
     指数関数で書けることも、Ising 模型のパラメータ `K_1, K_2` も効いていない。
  3. **`W` が実対称半正定値であること。** これは `c_±(M)` が上に有界であること
     （章 011 の `sectorSet_bddAbove`）を出すためだけに使う。

- **人手証明 (2) の「`π` は不動点をもたない」は `c_-(M) ≤ c_+(M)` には効いていない。**
  必要十分版 `NecSuf.sectorRayleighSup_neg_le_pos` は不動点について何も仮定していない。
  不動点をもたないことが効くのは「`𝓡_-` が空でない」（人手証明 (4)、`c_-(M)` が上限として
  意味をもつこと）の部分だけである。`𝓡_-` が空なら `sSup ∅ = 0 ≤ c_+(M)` で不等式は自動的に成り立つ。

- **`𝓡_+ ≠ ∅` にも不動点の有無は効いていない。** `e_i + e_{π(i)}` は `π(i) = i` でも
  （`2e_i` として）非零で `ε` 不変だからである（`NecSuf.sectorSet_pos_nonempty`）。

- **Perron–Frobenius の定理は要らない。** 本章の内容は「成分が非負の対称行列に対して、
  最大化ベクトルの符号をそろえてよい」という Perron–Frobenius の初等的な断片であり、
  固有値の存在も既約性も原始性も使わずに、上限（`sSup`）の言葉だけで閉じる。

## 3. 形式化できなかった主張とその理由

| 人手証明 | 状況 | 理由 |
| --- | --- | --- |
| `c_equals_c_plus` Step 2（`c(M) = Λ^{(1/2)}_M`） | **仮定つきで形式化** | 引用先 `c_plus_equals_Lambda_half_integer` は**章 018**の定理で、Lean 側に未形式化（`grep -rn "cPlus\|c_plus\|Lambda_half" --include=*.lean Ising2D/` が章 019 のコメント以外にヒットしない） |
| `c_equals_c_plus` Step 3（上限が達成されること） | **仮定つきで形式化** | 同上（`x_0` の構成が `c_plus_equals_Lambda_half_integer` の証明の中にある） |
| `ε W = W ε` | **仮定** | 複素の `V_1, V_2`（章 004/010）と章 011 の実行列 `W` を結ぶ橋渡しが未形式化。章 011 も同じ扱い |
| `sector_000_remark_overview` / `sector_005_remark_sandwich_becomes_equality` | 形式化対象外 | いずれも `remark`（本章の位置づけの説明）であり、数学的主張は他ブロックに含まれる |

詳細と一次情報は `docs/tasks/2026-07_lean-ch009-013/013_ch019-formalization-findings.md` に記録した。

## 4. 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ lake build            # 成功（エラー 0）
$ ./scripts/check-no-sorry.sh   # exit 0（ソース中の sorry/admit 無し、sorryAx 依存無し）
```

`scripts/check-no-sorry.sh` の `targets` 配列の末尾に本章の 37 定理を追加してある。
