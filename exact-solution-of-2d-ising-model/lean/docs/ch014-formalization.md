# 章 014「偶セクターでの `T` の作用」の Lean 形式化

対象: `structured-latex/content/014_even_sector_T_action.ts`（定義・主張 19 本）

新規ファイル:

- 具体版: `lean/Ising2D/Part014/`
- 必要十分版: `lean/Ising2D/NecSuf/TVActionSandwich.lean`（新規は 1 本だけ。理由は 2 節）

`lean/README.md` への統合は呼び出し元が行う（本ファイルは章 014 の作業記録）。

---

## 1. 形式化した定理の一覧

### 具体版（人手証明と 1 対 1）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.H1 M (-1)` / `V1half M K1 (-1)` | `H_1^{(+)}` と `(V_1^{(+)})^{1/2}` | `def_H1_plus` / `def_V1_plus_square_root` |
| `Ising2D.VPlus` / `VPlusUnits` | `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` とその単元版 | `def_V_plus` |
| `Ising2D.isUnit_V1halfPlus` | `(V_1^{(+)})^{1/2}` の可逆性 | `V1_plus_half_invertible` |
| `Ising2D.isUnit_VPlus` | `V^{(+)}` の可逆性 | `V_plus_factors_invertible` |
| `Ising2D.V1halfPlus_sq` | `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}` | `V1_plus_square_root_property` |
| `Ising2D.TVPlus` | `T_{(V^{(+)})}` を ℂ-代数自己同型として | `def_T_V_plus` |
| `Ising2D.TVPlus_eq_TConj` / `TVPlus_apply_eq_conj` | `T_{(V^{(+)})} = T_{V^{(+)}}` | `T_V_plus_is_conjugation` |
| `Ising2D.checkPhase_mul_neg` | `e^{-iθ~_μ} e^{iθ~_μ} = 1`（帰納段階で使う唯一の位相の性質） | `nesting_of_commutator_of_H_and_check_Z` の proof |
| `Ising2D.ad_K1H1Plus_checkZ` / `ad_K1H1Plus_checkY` | `ad(K_1H_1^{(+)})` が `span{Ž_μ, Y̌_μ}` を保つこと | 同上（(A)(B) の `K_1` 倍） |
| `Ising2D.ad_K2H2_checkZ` / `ad_K2H2_checkY` | `ad(K_2^*H_2)` が同じ空間を保つこと | 同上（(C)(D) の `K_2^*` 倍） |
| `Ising2D.nesting_H1Plus_checkZ_even` / `..._odd` | (h1.z) の偶数側・奇数側 | `nesting_of_commutator_of_H_and_check_Z` (h1.z) |
| `Ising2D.nesting_H1Plus_checkY_even` / `..._odd` | (h1.y) の偶数側・奇数側 | 同上 (h1.y) |
| `Ising2D.nesting_H2_checkZ_even` / `..._odd` | (h2.z) の偶数側・奇数側 | 同上 (h2.z) |
| `Ising2D.nesting_H2_checkY_even` / `..._odd` | (h2.y) の偶数側・奇数側 | 同上 (h2.y) |
| `Ising2D.ad_V1halfPlus_checkZ` / `ad_V1halfPlus_checkY` | `ad((i/2)K_1H_1^{(+)})` の 2 次元不変性（`α = iK_1e^{-iθ~}` 等） | `cosh_sinh_coefficient_conversion_for_check` |
| `Ising2D.ad_V2_checkZ` / `ad_V2_checkY` | `ad(iK_2^*H_2)` の 2 次元不変性（`α = -2iK_2^*` 等） | 同上 |
| `Ising2D.sK1_sq` / `sK2_sq` | `αβ = K_1^2`, `αβ = (2K_2^*)^2`（原文の `s` の正体） | 同上 |
| `Ising2D.conversion_H1Plus_checkZ_even` / `..._odd` ほか 8 本 | (h1.z)(h1.y)(h2.z)(h2.y) のスカラー付け替え後の形 | `cosh_sinh_coefficient_conversion_for_check` |
| `Ising2D.extract_taylor_H1Plus_checkZ` / `..._checkY` | (h1.z)(h1.y) の級数和 `cosh K_1 Ž + i e^{-iθ~} sinh K_1 Y̌` ほか | `extract_taylor_coefficient_of_check_Z_Y` |
| `Ising2D.extract_taylor_H2_checkZ` / `..._checkY` | (h2.z)(h2.y) の級数和 | 同上 |
| `Ising2D.checkPhase_one_eq_exp` / `checkPhase_neg_one_eq_exp` | `e^{∓iθ~_μ}` の指数表示との橋渡し | `T_actions_on_check_Z_Y` |
| `Ising2D.TConj_V1halfPlus_checkZ` / `..._checkY` | 原文 第 1・第 2 式 | `T_actions_on_check_Z_Y` |
| `Ising2D.TConj_V2_checkZ` / `..._checkY` | 原文 第 3・第 4 式（前因子 `(2s_2)^{M/2}` の相殺つき） | 同上 |
| `Ising2D.linearity_of_T_on_check` | `T_g` の ℂ 線型性 | `linearity_of_T` |
| `Ising2D.linearity_of_T_V1halfPlus` | `T_g` の ℂ 線型性の半指数行列への特殊化 | `linearity_of_T_on_check_Z_Y` |
| `Ising2D.linearity_of_T_V2` | `T_g` の ℂ 線型性の `V_2` への特殊化 | `linearity_of_T_V2` |
| `Ising2D.B1mat_zero_zero` ほか 8 本 | `B_1(θ), B_2` の 4 成分が原文の行列と一致すること | `def_B1_theta_B2` |
| `Ising2D.actsBy_TConj_V1halfPlus` | `(T Ž, T Y̌) = (Ž, Y̌) B_1(θ~_μ)` | `calc_of_TxT_check_Z_Y` 第 1 式 |
| `Ising2D.actsBy_TConj_V2_check` | `(T Ž, T Y̌) = (Ž, Y̌) B_2` | 同 第 2 式 |
| `Ising2D.factorization_of_A_theta_general` | `B_1(θ) B_2 B_1(θ) = A(θ)`（`θ ∈ ℝ` 一般） | `factorization_of_A_theta_general` |
| `Ising2D.factorization_of_A_thetaTilde` | 上の `θ = θ~_μ` への特殊化 | 同上（「とくに」） |
| **`Ising2D.TVPlus_checkZ_checkY`** | **章の結論** `(T_{(V^{(+)})}(Ž_μ), T_{(V^{(+)})}(Y̌_μ)) = (Ž_μ, Y̌_μ) A(θ~_μ)` | **`T_V_plus_check_Z_Y`** |
| `Ising2D.TVPlus_checkZ_checkY_components` | 上を 2 本の等式（成分の形）で書いた版 | 同上 |
| `Ising2D.TV_hatZ_hatY_via_sandwich` | **整数運動量版（008 章）を同じ必要十分版から導いた別証明** | `<T_V_hatZ_hatY>`（008 章） |

### 必要十分版

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.NecSuf.actsBy_sandwich` | `T_1` が `B_1`、`T_2` が `B_2` で作用するなら `T_1∘T_2∘T_1` は `B_1B_2B_1` で作用する（ℂ 上の任意の加群・任意の ℂ 線型写像） | `T_V_plus_check_Z_Y` / `calc_of_TxT_check_Z_Y` / `linearity_of_T_on_check_Z_Y` / `linearity_of_T_V2` |
| `Ising2D.NecSuf.actsBy_TV_sandwich` | 上を `T_{(V)} = T_{g_1}∘T_{g_2}∘T_{g_1}` の形で述べた版（任意の ℂ-代数の単元） | 同上 |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

### 新規の必要十分版が 1 本で済んだ理由

**本章の主要主張はすべて既存の必要十分版の特殊化で閉じた。** 新しく足したのは、
原文が `T_actions → linearity → calc_of_TxT → linearity → calc_of_TxT` と
4 段で往復している部分を 1 本にまとめた `NecSuf.actsBy_sandwich` だけである。

| 人手証明のラベル（章 014） | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_H1_plus` / `def_V1_plus_square_root` / `V1_plus_square_root_property` / `def_V_plus` / `V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation` | `Ising2D.H1` / `V1half` / `V1halfPlus_sq` / `VPlus` / `TVPlus` / `TVPlus_eq_TConj` | 既存の `Ising2D.TConj` / `TV` / `TV_eq_TConj`（任意の環 + ℂ-代数。`Part008/Definition016_TV.lean`） |
| `nesting_of_commutator_of_H_and_check_Z` | `Ising2D.nesting_H1Plus_checkZ_even` ほか 8 本 | 既存の `NecSuf.adCLM_pow_even` / `adCLM_pow_odd_z` / `adCLM_pow_odd_y` |
| `cosh_sinh_coefficient_conversion_for_check` | `Ising2D.conversion_H1Plus_checkZ_even` ほか 8 本 | 同上（`(α, β, s)` を付け替えただけ） |
| `extract_taylor_coefficient_of_check_Z_Y` | `Ising2D.extract_taylor_H1Plus_checkZ` ほか 4 本 | 既存の `NecSuf.exp_conj_two_dim_z` / `exp_conj_two_dim_y` |
| `T_actions_on_check_Z_Y` / `calc_of_TxT_check_Z_Y` | `Ising2D.actsBy_TConj_V1halfPlus` / `actsBy_TConj_V2_check` ほか | 既存の `NecSuf.twoDimConjMat` / `exp_conj_two_dim_actsBy` / `conj_smul_eq` |
| `linearity_of_T` | `Ising2D.linearity_of_T_on_check` | 既存の `Ising2D.TConj_linear`（任意の環 + ℂ-代数） |
| `linearity_of_T_on_check_Z_Y` | `Ising2D.linearity_of_T_V1halfPlus` | 既存の `Ising2D.TConj_linear` の半指数行列への特殊化 |
| `linearity_of_T_V2` | `Ising2D.linearity_of_T_V2` | 既存の `Ising2D.TConj_linear` の `V_2` への特殊化 |
| `def_B1_theta_B2` | 既存の `Ising2D.B1mat` / `B2mat`（最初から `θ : ℂ` 一般） | 既存の `NecSuf.twoDimConjMat` |
| `factorization_of_A_theta_general` | 既存の `Ising2D.B1_mul_B2_mul_B1_eq_AMat`（最初から `θ : ℝ` 一般） | （2×2 行列の計算そのもので、取り払える構造が無い） |
| **`T_V_plus_check_Z_Y`** | **`Ising2D.TVPlus_checkZ_checkY`** | **`NecSuf.actsBy_sandwich` / `actsBy_TV_sandwich`（新規）** |

### 必要十分版で判明した本質（README 4 節が求めている答え）

**整数運動量版（008 章）と半整数運動量版（本章）は、同じ必要十分版の別の特殊化である。**
違いは `ad X` が `span{z, y}` に及ぼす係数 `(α, β)` の位相因子だけである。

| | `z` | `y` | `α` | `β` | `s` | 作用行列 |
| --- | --- | --- | --- | --- | --- | --- |
| 008 章 `T_{(V_1^{(-)})^{1/2}}` | `Ẑ_μ^{(-)}` | `Ŷ_μ` | `iK_1 e^{-iθ_μ}` | `-iK_1 e^{iθ_μ}` | `K_1` | `B_1(θ_μ)` |
| 本章 `T_{(V_1^{(+)})^{1/2}}` | `Ž_μ` | `Y̌_μ` | `iK_1 e^{-iθ~_μ}` | `-iK_1 e^{iθ~_μ}` | `K_1` | `B_1(θ~_μ)` |
| 両章の `T_{V_2}` | 上に同じ | 上に同じ | `-2iK_2^*` | `2iK_2^*` | `2K_2^*` | `B_2` |

`αβ = s^2` の検証に使うのは **`e^{-iθ}e^{iθ} = 1` と `i^2 = -1` の 2 つだけ**であり、
`θ` が `2πμ/M` か `2π(μ-1/2)/M` かは一切効いていない。これが原文
`evensectorT_000_remark_overview` の「008 章の各証明は `θ_μ` に固有の性質
（`e^{-iMθ_μ} = +1`、添字集合 `𝓜` の形、`M` 周期性）を使っていない」という観察の、
Lean での機械的裏づけである。

具体的な確認として、`Ising2D.TV_hatZ_hatY_via_sandwich`（`Part014/Claim010_TVPlusAction.lean`）で
**008 章の結論を本章の必要十分版から導き直した**。本章の結論
`Ising2D.TVPlus_checkZ_checkY` とこの定理は、`NecSuf.actsBy_TV_sandwich` に渡す
`ActsBy` が `(Ẑ^{(-)}, Ŷ, B_1(θ_μ))` か `(Ž, Y̌, B_1(θ~_μ))` かだけが違う。

さらに、必要十分版から次の 3 点が分かった。

1. **原文が「入れ子交換子の偶奇の場合分け」（`nesting_of_commutator_of_H_and_check_Z`）と
   「テイラー係数の抽出」（`extract_taylor_coefficient_of_check_Z_Y`）と
   「補題 1・補題 2 によるスカラーの付け替え」（`cosh_sinh_coefficient_conversion_for_check`）の
   3 段でやっていることは、「`ad X` が `span{Ž_μ, Y̌_μ}` を保つ」という 1 つの事実に集約できる。**
   とくに原文の補題 1（`ad_{αX}^n = α^n ad_X^n`）と補題 2（`i^n` の偶奇）は、
   必要十分版では `(α, β, s)` の付け替えに完全に吸収される。原文で
   `(-1)^{n/2}(2K_1)^n` が `K_1^n` へ変わるのは、`s` が純虚数 `2iK_1` から実の `K_1` へ
   変わることに他ならない（`Ising2D.sK1_sq`）。
2. **原文が 4 段の往復（`T_actions` → 線型性 → `calc_of_TxT` → 線型性 → `calc_of_TxT`）で
   行っている合成の計算に効いているのは、「`T` が ℂ 線型であること」と
   「行ベクトル記法のもとで合成が行列の積になること」の 2 つだけである。**
   指数関数も、共役であることも、行列であることも、`Ž, Y̌` が何であるかも効いていない
   （`NecSuf.actsBy_sandwich` は ℂ 上の任意の加群と任意の ℂ 線型写像で成り立つ）。
3. `V_2` の前因子 `(2s_2)^{M/2}` が共役で打ち消えることに効いているのは、
   任意の ℂ-代数で成り立つ `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`（既存の `NecSuf.conj_smul_eq`）
   だけである（008 章と同じ）。ノルムも完備性も指数関数も要らない。

---

## 3. 形式化できなかった主張とその理由

無し。章 014 の 11 主張はすべて形式化した（`sorry` / `admit` はゼロ）。

ただし次の 2 点は**仮定として残している**。いずれも 008 章と同じもので、
未形式化に由来する穴ではなく**数学的に必要な前提**である。

1. `hdual : s_2^* c_2 = c_2^*`（双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` の帰結）。
   `B_1(θ)B_2B_1(θ)` の非対角成分に現れるのは `c_2^*` だが、`def_A_theta` の `A(θ)` には
   `c_2` が現れるため、一致にこの等式が要る。
   **本章の原文はこれを `duality_c2_star_eq_s2_star_c2` として proof 中で明示的に引用しており、
   008 章で欠けていた前提がここでは補われている**（008 章の問題点は
   `lean/README.md`「形式化の過程で見つかった原文の問題」を参照）。
2. `IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であること
   （`hc1 : c_1 = cosh 2K_1` など）。原文が記号 `c_1, s_1, c_2, c_2^*, s_2^*` の定義として
   `def_transfer_matrix_symbols` に置いているものであり、Lean の `IsingConst` は
   5 個の実数を保持するだけなので仮定として渡す。

### 添字の量化について

原文は本章の主張をすべて `μ ∈ 𝓜̌ = {1,…,M}` について述べているが、
Lean 側の定理はすべて `μ : ℤ` 全体で成り立つ形にした。`𝓜̌` に絞る必要があるのは
反交換関係を `δ_{ν,M+1-μ}` の形で述べるとき（章 013）だけで、本章の主張には
`𝓜̌` に固有の性質が使われていない。これは原文より強い主張であり、原文の主張は
`μ ∈ 𝓜̌` を代入すれば直ちに従う。

### `n` 重交換子の偶奇の書き方

原文は `n ∈ ℤ_{≥0}` について右辺を `n` の偶奇で場合分けして書いているが、
Lean では `n = 2k` / `n = 2k+1` と書き分けた 2 本ずつの定理にした
（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
主張の内容は同値である。

---

## 4. 人手証明に見つかった誤り・穴

**無し。** 章 014 の 11 主張はすべて、係数まで含めて原文どおりに形式化できた。
とくに次の 2 点は原文が 008 章より改善している。

- 008 章が `B_1B_2B_1 = A(θ)` に必要な双対関係 `c_2^* = s_2^* c_2` を明示していなかったのに対し、
  本章の `factorization_of_A_theta_general` の proof は Step 4 でこれを明示的に引用している。
- 008 章が `(V_1^{(±)})^{1/2}` を「`exp(iK_1H_1^{(±)})` の `1/2` 乗」と書いて proof 中で
  `exp((i/2)K_1H_1^{(±)})` に読み替えていたのに対し、本章は最初から
  `exp((i/2)K_1H_1^{(+)})` を定義とし、それが平方根であることを (2) で示している。
