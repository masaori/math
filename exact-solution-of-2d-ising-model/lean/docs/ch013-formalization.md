# 章 013「偶セクターの半整数運動量モード」の Lean 形式化

対象: `structured-latex/content/013_even_sector_modes.ts`（8 ブロック）

新規ファイル:

- 具体版: `lean/Ising2D/Part013/`
- 抽象版: `lean/Ising2D/Abstract/AntiperiodicFourier.lean`

`lean/README.md` への統合は呼び出し元が行う（本ファイルは章 013 の作業記録）。

---

## 1. 形式化した定理の一覧

### 具体版（人手証明と 1 対 1）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.lie_H2_hatZMinus_eq` | `[H_2, hat(Z)^{(-)}_μ] = -2 hat(Y)_μ`（`Part008` の再掲） | `why_008_applies_only_to_minus_sector` |
| `Ising2D.lie_H2_hatZPlus_eq` | `[H_2, hat(Z)^{(+)}_μ] = -2 hat(Y)_μ + 4 e^{-iθ_μ} Y_1`（同上） | 同上 |
| `Ising2D.lie_H2_hatZPlus_ne_lie_H2_hatZMinus` | `[H_2, hat(Z)^{(+)}_μ] ≠ -2 hat(Y)_μ`（**本章で新規**） | 同上 |
| `Ising2D.lie_H2_hatZPlus_ne_hatZMinus` | 2 つの交換子が一致しないこと | 同上 |
| `Ising2D.thetaTilde` | `θ~_μ := 2π(μ-1/2)/M ∈ ℝ` | `antiperiodic_exp_sum` |
| `Ising2D.checkPhase` | `e^{-i k θ~_μ} = expPhase (2M) (k(2μ-1))` | 同上 |
| `Ising2D.checkPhase_eq_exp` | `checkPhase` が原文の `e^{-ikθ~_μ}` そのものであること | 同上 |
| `Ising2D.expPhase_two_mul` | `expPhase (2M) (2n) = expPhase M n`（偶数周波数は `M` 乗根） | 同上 |
| `Ising2D.expPhase_two_mul_half` | `expPhase (2M) M = -1`（**反周期性の正体**） | 同上 |
| `Ising2D.expPhase_sum_zero_based` | `∑_{μ=0}^{M-1} e^{-2π√-1 μk/M} = M δ^M_{k,0}` | 同上（補助） |
| `Ising2D.antiperiodic_exp_sum` | `∑_{μ=1}^{M} e^{ikθ~_μ} = e^{-iπk/M} M δ^M_{k,0}` | `antiperiodic_exp_sum` |
| `Ising2D.antiperiodic_exp_sum_dvd` | `k = lM` のとき和は `M(-1)^l` | 同上 |
| `Ising2D.antiperiodic_exp_sum_not_dvd` | `M ∤ k` のとき和は `0` | 同上 |
| `Ising2D.sum_checkPhase` | 上を周波数そのままで書いた形（以降の計算で使う） | 同上 |
| `Ising2D.checkZ` / `Ising2D.checkY` | `check(Z)_μ`, `check(Y)_μ` | `def_half_integer_modes` |
| `Ising2D.checkPhase_antiperiodic` | (1) `e^{-iMθ~_μ} = -1` | 同上 (1) |
| `Ising2D.checkZ_period` / `checkY_period` | (2) `check(Z)_{μ+M} = check(Z)_μ` ほか | 同上 (2) |
| `Ising2D.checkPhase_congr` / `checkZ_congr` / `checkY_congr` | (2) の合同形（`M ∣ μ-ν` 版） | 同上 (2) |
| `Ising2D.thetaTilde_one_sub` | (3) `θ~_{1-μ} = -θ~_μ` | 同上 (3) |
| `Ising2D.checkPhase_one_sub` | (3) の位相因子版 | 同上 (3) |
| `Ising2D.CheckIndex` | `μ ∈ 𝓜̌ = {1,…,M}` | `def_check_index_set` |
| `Ising2D.thetaTilde_ne` | (1) `μ ≠ ν ⟹ θ~_μ ≠ θ~_ν` | 同上 (1) |
| `Ising2D.thetaTilde_pos` / `thetaTilde_lt_two_pi` | (1) `0 < θ~_μ < 2π` | 同上 (1) |
| `Ising2D.checkIndex_conj` | (2) `μ ∈ 𝓜̌ ⟹ M+1-μ ∈ 𝓜̌` | 同上 (2) |
| `Ising2D.conj_index_sub` | (3) `(M+1-μ)-(1-μ) = M` | 同上 (3) |
| `Ising2D.conj_index_self_iff` / `thetaTilde_of_self_conj` | (4) 自己共役点と `θ~_μ = π` | 同上 (4) |
| `Ising2D.dvd_add_sub_one_iff` | (5) `μ+ν ≡ 1 (mod M) ⟺ ν = M+1-μ` | 同上 (5) |
| `Ising2D.deltaMod_add_one_eq` | (5) のデルタ版 | 同上 (5) |
| `Ising2D.thetaTilde_conj` | (1) `θ~_{M+1-μ} = 2π - θ~_μ` | `conjugate_index_of_check_Z_Y` |
| `Ising2D.checkPhase_conj` / `checkPhase_conj'` | (2) `e^{-ijθ~_{M+1-μ}} = e^{ijθ~_μ}` | 同上 (2) |
| `Ising2D.checkZ_conj` / `checkY_conj` | (3) `check(Z)_{M+1-μ} = check(Z)_{1-μ}` | 同上 (3) |
| `Ising2D.checkZ_conj_eq` / `checkY_conj_eq` | (3) の展開形（`H_1, H_2` の証明で使う） | 同上 |
| `Ising2D.acomm_checkZ_checkZ` | `[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{μ+ν,1} I` | `anticommutator_of_check_Z_Y` |
| `Ising2D.acomm_checkZ_checkY` | `[check(Z)_μ, check(Y)_ν]₊ = 0` | 同上 |
| `Ising2D.acomm_checkY_checkY` | `[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{μ+ν,1} I` | 同上 |
| `Ising2D.acomm_checkZ_checkZ_of_mem` / `acomm_checkY_checkY_of_mem` | 上を `μ,ν ∈ 𝓜̌` で `δ_{ν,M+1-μ}` の形にしたもの（原文の主張そのもの） | 同上 |
| `Ising2D.expPhase_nextSite` | 境界の符号 `-1` が反周期性から出ること | `H1_H2_via_check_Z_Y` |
| `Ising2D.H2_eq_check_sum` | `H_2 = (1/M) ∑_μ check(Z)_{M+1-μ} check(Y)_μ` | 同上 |
| `Ising2D.H1Plus_eq_check_sum` | `H_1^{(+)} = (1/M) ∑_μ check(Y)_μ check(Z)_{M+1-μ} e^{-iθ~_μ}` | 同上 |
| `Ising2D.checkCliffordTriple` | `check(Z), check(Y)` を抽象版の Clifford 3 族として与えるもの | `commutator_of_H_and_check_Z_Y` |
| `Ising2D.lie_H1Plus_checkZ` | (A) `[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ` | 同上 |
| `Ising2D.lie_H1Plus_checkY` | (B) `[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ` | 同上 |
| `Ising2D.lie_H2_checkZ` | (C) `[H_2, check(Z)_μ] = -2 check(Y)_μ` | 同上 |
| `Ising2D.lie_H2_checkY` | (D) `[H_2, check(Y)_μ] = 2 check(Z)_μ` | 同上 |
| `Ising2D.inverse_dft_check` | 反周期的離散フーリエ逆変換（任意の族に対する形） | `recover_Z_Y_from_check_Z_Y` |
| `Ising2D.recover_checkZ` / `recover_checkY` | `∑_μ check(Z)_μ e^{ijθ~_μ} = M Z_j` ほか | 同上 |
| `Ising2D.Z_eq_inverse_dft_check` / `Y_eq_inverse_dft_check` | `Z_j = (1/M) ∑_μ …` ほか | 同上 |
| `Ising2D.checkZYSet` / `checkZ_checkY_generate_algebra` | `check(Z), check(Y)` が `Mat(2^M,ℂ)` を生成する | 同上（「とくに」） |

### 抽象版（`Ising2D/Abstract/AntiperiodicFourier.lean`、名前空間 `Ising2D.Abstract`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Abstract.pow_half_eq_neg_one` | `ξ` が 1 の原始 `2M` 乗根なら `ξ^M = -1` | `def_half_integer_modes` (1) |
| `Abstract.sq_isPrimitiveRoot` | `ξ` が原始 `2M` 乗根なら `ξ^2` は原始 `M` 乗根 | 同上（橋渡し） |
| `Abstract.zpow_mul_natCast` | `ξ^{lM} = (-1)^l` | `antiperiodic_exp_sum` |
| `Abstract.sum_zpow_primitiveRoot_zero_based` | 既存の直交性の `0` 始まり版 | 同上（補助） |
| `Abstract.sum_zpow_antiperiodic` | `∑_{μ=1}^{M} ξ^{(2μ-1)k} = ξ^k M δ^M_{k,0}` | `antiperiodic_exp_sum` |
| `Abstract.acomm_antiperiodic_fourier_clifford` | 奇数周波数フーリエ和どうしの反交換子 | `anticommutator_of_check_Z_Y` |
| `Abstract.inverse_dft_antiperiodic` | 反周期的離散フーリエ逆変換（任意の体・任意の加群） | `recover_Z_Y_from_check_Z_Y` |

### 抽象版 → 具体版の導出

| 導出した定理 | 元の抽象版 | ファイル |
| --- | --- | --- |
| `Ising2D.antiperiodic_exp_sum_of_abstract` | `Abstract.sum_zpow_antiperiodic` | `Part013/Claim002_AntiperiodicExpSumAbstract.lean` |
| `Ising2D.checkPhase_M_of_abstract` | `Abstract.pow_half_eq_neg_one` | 同上 |
| `Ising2D.checkZ_period_of_abstract` / `checkY_period_of_abstract` | **既存の** `Abstract.transform_periodic` | 同上 |
| `Ising2D.acomm_checkZ_checkZ_of_abstract` / `acomm_checkY_checkY_of_abstract` | `Abstract.acomm_antiperiodic_fourier_clifford`（それ自体が既存の `Abstract.acomm_fourier_clifford_weights` の特殊化） | `Part013/Claim005_AnticommutatorCheckZYAbstract.lean` |
| `Ising2D.inverse_dft_check_of_abstract` / `recover_checkZ_of_abstract` / `recover_checkY_of_abstract` | `Abstract.inverse_dft_antiperiodic` | `Part013/Claim006_RecoverZYAbstract.lean` |
| (A)〜(D)（`lie_H1Plus_checkZ` ほか 4 本） | **既存の** `Abstract.CliffordTriple.lie_sum_*` | `Part013/Claim004_CommutatorHCheckZY.lean`（本体がそのまま導出） |

橋渡し補題は `Ising2D.isPrimitiveRoot_expPhase_one`（`e^{-2π√-1/N}` は 1 の原始 `N` 乗根）と
`Ising2D.isPrimitiveRoot_expPhase_neg_one`（`e^{+2π√-1/N}` も同様）。

---

## 2. 抽象版で判明した本質

**整数運動量と半整数運動量は、同じ抽象版の別の特殊化である。**
これは本章のゴール（README 4 節の「何が本質的か」）に対する答えそのものなので、
判明したことを列挙する。

1. **`e^{-iθ~}` は 1 の原始 `2M` 乗根であり、半整数運動量とはその「奇数周波数」のことである。**
   `e^{-ijθ~_μ} = ξ^{j(2μ-1)}`（`ξ = e^{-iπ/M}`）。整数運動量は `ζ = ξ^2`（原始 `M` 乗根）の
   周波数 `jμ`、すなわち偶数周波数 `ξ^{2jμ}` である。
   本文が「働く仕組みは 1 つの等式 `e^{-iMθ~_μ} = -1` に集約される」と述べている等式は、
   抽象版では **`ξ^M = -1`**（`Abstract.pow_half_eq_neg_one`）であり、
   その証明は「`(ξ^M)^2 = 1` かつ原始性から `ξ^M ≠ 1`、体だから `ξ^M = -1`」の 3 行しかない。
   指数関数も円周率も複素数であることも効いていない。

2. **指数和は同じ直交性の特殊化である。**
   `∑_{μ=1}^{M} ξ^{(2μ-1)k} = ξ^k ∑_{μ=0}^{M-1} (ξ^2)^{μk} = ξ^k · M δ^M_{k,0}`。
   定数位相 `ξ^k` を括り出すだけで、既存の `Abstract.sum_zpow_primitiveRoot`
   （整数運動量の `exp_sum` の抽象版）に帰着する。
   本文が場合分けして出している `(-1)^l` は、この定数位相を `k = lM` で評価した
   `ξ^{lM} = (ξ^M)^l = (-1)^l` にすぎない。
   つまり**整数運動量の `exp_sum` と半整数運動量の `antiperiodic_exp_sum` は、
   同じ 1 つの直交性補題の 2 通りの特殊化**である。

3. **反交換関係の抽象版は既存のもので足りる。**
   `Abstract.acomm_fourier_clifford_weights`（位相 `ζ^{(j+1)ν}`、重み任意）に
   `ζ := ξ`（`2M` 乗根）・`ν := 2μ-1` を入れるだけでよい。
   **対になる添字が `μ+ν ≡ 0` から `μ+ν ≡ 1` へずれる理由は、
   奇数 + 奇数 = `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` のただ 1 点**である。
   Clifford 関係と根の直交性以外は何も効いていない（行列であることも複素数であることも不要）。

4. **添字の周期性は文字どおり同じ定理である。**
   既存の `Abstract.transform_periodic`（重み `w_j`・周波数 `a_j` が任意、仮定は `ζ^M = 1` だけ）に
   `w_j = ξ^{-j}`, `a_j = j`, `ζ = ξ^2` を入れると `check(Z)_{μ+M} = check(Z)_μ` になる。
   整数運動量版 `hatZ_hatY_M_periodicity` は同じ定理に `w_j = ±1` を入れたものである。

5. **交換関係 (A)〜(D) も既存の抽象版の特殊化である。**
   `Abstract.CliffordTriple`（3 族 `z, z', y` と反交換子の値 `Dz, Dz', Dy`）に
   `z = z' = check(Z)`, `y = check(Y)`, `Dz = Dz' = Dy = 2M δ^M_{μ+ν,1}` を渡すだけで
   (A)〜(D) が出る。整数運動量版（`Part008/Claim001_CommutatorHZY.lean` の 6 本）は
   同じ構造に `z = hat(Z)^{(±)}`, `z' = hat(Z)^{(∓)}`, `Dz ≠ Dz'` を渡したものである。

6. **「`(+)` セクターで 008 章が壊れる」ことの正体は `Dz ≠ Dz'` の 1 点である。**
   `why_008_applies_only_to_minus_sector` の余分な項 `4 e^{-iθ_μ} Y_1` は、
   抽象版では `Dz'(μ,ν) = 2M δ^M_{μ+ν,0} - 4 e^{-i2π(μ+ν)/M}` の第 2 項が
   そのまま流れてきたものである。
   `check(Z)` では族が 1 つしかない（`z = z'`）ので、この差が構造的に存在しない。
   本文が「係数に例外項が無い」と書いているのはこのことである。

7. **逆変換だけは新しい抽象版が要る。** 既存の `Abstract.inverse_dft_abstract` は
   「原始 `M` 乗根 `ζ` の周波数 `(j+1)(μ+1)`」の形に固定されており、奇数周波数は
   `ζ = ξ^2` へ揃わないので特殊化にならない。そこで
   `Abstract.inverse_dft_antiperiodic` を新設した。ただし**証明の骨格は同一**
   （位相をまとめる → 二重和の順序交換 → 直交性）であり、
   違いは使う直交性が `sum_zpow_primitiveRoot` か `sum_zpow_antiperiodic` かだけである。
   効いているのは「`ξ` が 1 の原始 `2M` 乗根」と「対象が係数体上の加群」だけで、
   行列であること・積があること・Clifford 関係は使っていない。

---

## 3. 形式化しなかった／できなかったもの

| 対象 | 理由 |
| --- | --- |
| `evensector_000_remark_overview`（この章の目的） | `kind: "remark"` で数学的主張を含まない（章の方針の説明） |
| `heading_even_sector_modes` | 見出し |
| `H1_H2_via_check_Z_Y` の抽象版 | 整数運動量版 `H1_H2_via_hatZ_hatY` と同じ理由で、この等式は `check(Z), check(Y)` の具体形（半整数運動量の離散フーリエ変換）に本質的に依存しており、取り払える構造が無い。既存の `lean/README.md` も整数運動量版について同じ判断を記録している |
| `def_check_index_set` / `conjugate_index_of_check_Z_Y` の抽象版 | 整数の不等式と `θ~_μ` の実数値だけを扱っており、環・体・加群のいずれも登場しない。抽象化しても得られる知見が「`𝓜̌` に絞ると合同式が等式に落ちる」という主張そのものにしかならない |
| 原文が `μ ∈ 𝓜̌` に絞っている主張のうち (A)〜(D) と反交換関係の合同式版 | Lean では `μ ∈ ℤ` 全体で証明した（絞る必要が無いことが分かった）。`𝓜̌` に絞った形も併記してある（`*_of_mem`） |
| `periodicity_of_check_fermi`（`def_check_index_set` から参照） | 014 章以降のブロックであり、本章（013）の担当範囲外 |

実数解析（極限・積分・連続性）は本章では不要だった。使った実数の事実は
`Real.pi_pos` / `Real.pi_ne_zero`（`thetaTilde` の範囲）と
`Complex.exp_pi_mul_I`（`expPhase (2M) M = -1`）だけで、いずれも mathlib にある。

---

## 4. 人手証明との突き合わせ

数値検証は `sagemath/check/046_claim_even_sector_modes/`（`M = 2,3,4,5` で全 PASS）。
Lean で形式化した主張はいずれもこれと整合し、**本文の誤りは見つからなかった**。

1 点だけ本文の記述が Lean と食い違う可能性を検討したので記録する。

- `why_008_applies_only_to_minus_sector` の第 2 式
  `[H_2, hat(Z)^{(+)}_μ] = -2 hat(Y)_μ + 4 e^{-i2πμ/M} Y_1` は、
  **008 章の原文 (5) の訂正版**である（008 章の原文は符号と係数を誤っており、
  `Part008/Claim001_CommutatorHZY.lean` の冒頭コメントに記録がある）。
  013 章の本文は訂正後の値を採用しており、Lean（`Ising2D.lie_H2_hatZPlus`）と一致する。
  したがって 013 章側に誤りは無い。
