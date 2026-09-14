# 章 018 の仮定を章 014–017 の形式化で埋めた記録

対象: `lean/Ising2D/Part018/`（章 018 以外の `.lean` は読むだけで編集していない）
`structured-latex/` は一切編集していない。

## 0. やったこと

章 018（Onsager の厳密解）は、着手時点で章 014–017 が Lean 未形式化だったため、
それらの結果を構造 `Ising2D.CheckFermi` / `Ising2D.VPlusData` / `Ising2D.EvenSectorBridge`
の**仮定**として受け取っていた。その後 014・015・016・017 がすべて main に入ったので、
**実際に構成できるものを構成し、`onsager_exact_solution` から章 014–017 由来の仮定を全部落とした。**

追加ファイル（3 本）:

- `lean/Ising2D/Part018/Claim011_CheckFermiFromPart016.lean`
- `lean/Ising2D/Part018/Claim012_VPlusDataFromPart017.lean`
- `lean/Ising2D/Part018/Theorem013_OnsagerUnconditional.lean`

結論の定理: `Ising2D.onsager_exact_solution_unconditional`（既存の
`Ising2D.onsager_exact_solution` は消さずに残してある）。

## 1. 消せた仮定（一次情報つき）

| 章 018 の仮定 | 対応する既存定理 | 埋めた場所 |
| --- | --- | --- |
| `CheckFermi.hcre` / `hann`（`ψ̌^†, ψ̌` は `Ž, Y̌` の 1 次結合） | `Ising2D.checkPsiDag` / `checkPsi` の定義（`Part016/Definition001_CheckFermi.lean:145,149`） | `Ising2D.checkFermiOf` |
| `CheckFermi.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann` | `Ising2D.checkPsi_car'`（`Part016/Claim010_UnconditionalViaPart015.lean:116`） | 同上 |
| `CheckFermi.hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`） | **既存定理は無かった。新規に証明した** → `Ising2D.checkPsiDag_conjTranspose` | `Claim011_...` |
| `VPlusData.hV`（`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`） | `Ising2D.VPlus_eq_smul_checkVprime_of_dual`（016）＋ `Ising2D.constant_c_value_even_sector`（017） | `Ising2D.vPlusDataOf` |
| `VPlusData.C` / `hC`（`C = (2 sinh 2K_2)^{M/2} > 0`） | `Ising2D.constant_c_value_even_sector`（`Part017/Claim009_ConstantCEvenSector.lean:73`） | 同上 |
| `VPlusData.gam` / `hgam`（`γ(θ̃_μ) > 0`） | `Ising2D.gammaFn_thetaTilde_pos`（`Part017/Theorem011_MaxEigenvalueSimple.lean:77`。無条件） | 同上 |
| `rayleighSup_eq_LambdaM` の `hC`（`D.C = (2 sinh 2K_2)^{M/2}`） | 構成で確定するので `rfl` | `Theorem013_...` |
| `rayleighSup_eq_LambdaM` の `hgam`（章 012 の代表点の和との一致） | `Ising2D.tagPoint_half_eq_thetaTilde`（017）＋ `Ising2D.sum_Icc_one_eq_sum_range`（012） | `Ising2D.sum_checkGam` |

## 2. 「名前が違うだけ」でも「未形式化」でもなく、**噛み合っていなかった**箇所

指示のとおり、噛み合わせのための橋渡し補題を書いて解消した。

### 2-1. 添字型のずれ（`CheckIdx M` と `Fin M`）

章 017 の `Ising2D.CheckFermiSetup` は `CheckIdx M = {μ : ℤ // 1 ≤ μ ≤ M}` で、
章 018 の `Ising2D.CheckFermi` は `Fin M` で添字づけている。同じ数学的対象だが型が違うので、
章 017 の定理をそのままでは適用できない。

対処:

- `Ising2D.finCheckIdxEquiv : Fin M ≃ CheckIdx M`（`j ↦ j+1`）を置いた。全単射性は
  `Ising2D.checkIdx_injective`（016）と `Ising2D.CheckIdx.card`（017）から出る。
- `Ising2D.checkFermiSetupOf_Xop` / `checkFermiSetupOf_Vprime` で、章 017 の `X̌`・`V̌'` が
  章 016 の `Ising2D.checkX` / `checkVprime` と**同じ行列**であることを示した
  （`Fintype.sum_bijective` 1 行）。これで章 017 の `constant_c_value_even_sector` を
  章 016 の `V^{(+)} = c V̌'` に適用できる。
- 一方 `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` そのものは、章 017 の `Q̌_ε` を移送せず、
  章 018 側の `Ising2D.CheckFermi.nOp_mul_Qproj`（`Part018/Setup.lean:130`）から
  直接導いた（`Ising2D.checkX_mul_Qproj` / `checkVprime_mul_Qproj`）。射影は
  `Finset.noncommProd` で定義されているので、添字型ごと移送するより計算をやり直すほうが短い。

### 2-2. `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` が章 016 に無かった

章 016 は CAR と `V^{(+)} = c V̌'` までを扱い、`ψ̌` の共役転置には触れていない
（`grep -rn "conjTranspose" lean/Ising2D/Part016/` が空）。

対処: 係数側の等式 `conj(p_μ) = -p_{M+1-μ}`（`Ising2D.star_checkP`）と
`conj(q) = q`（`Ising2D.star_checkQ`）を証明し、章 018 で既に無条件に証明済みの
`Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose`（`Part018/Claim008_CheckQHermitian.lean`）
と組み合わせて `Ising2D.checkPsiDag_conjTranspose` を得た。
使った一次情報は章 008 の `Ising2D.gamma2_neg_eq_neg_conj`
（`Part008/Definition019_ThetaGamma.lean:119`）と章 016 の `Ising2D.checkR_conj` /
`gamma2_neg_thetaTilde_conj` だけである。

## 3. 消せなかった仮定と、その理由（一次情報）

`Ising2D.EvenSectorClosureInput`（`Theorem013_OnsagerUnconditional.lean`）に束ねた。
**どれも章 014–017 由来ではない。**

| 場 | 内容 | 理由 |
| --- | --- | --- |
| `hM` | `M ≠ 0` | 章 016・017 の主張自体が要求する（`CheckFermiSetup.hM`、`checkPsi_car'` の `hM`）。数学的に必要 |
| `hdual` | `c_2 s_2^* = c_2^*` | **原文が置いている前提**であって形式化の穴ではない。`lean/docs/ch016-formalization.md` 3 章「残る仮定は双対関係 `c_2 s_2^* = c_2^*` の 1 つだけ…これは 008 章以来 `det A(θ) = 1` に数学的に必要な前提であり、形式化の穴ではなく原文が置いている関係である（消えない）」 |
| `bridge`（`EvenSectorBridge`） | `W P^{(+)} = V^{(+)} P^{(+)}`、および `V^{(+)}` が実行列であること | **未形式化**。`V₁` の固有空間制限と下流のセクター置換は形式化済み。残る入力は、章 011 の実行列 `W` と複素 `TensorPow` 上の物理的転送行列の同一視、およびそれを既存の `Vsym` と `epsProj` へ接続する最終定理である。**実行列性**のほうは「実行列の `matExp` が実行列になる」ことを要し、本リポジトリの Lean 側にその補題が無い（`grep -rn "map (fun r : ℝ => (r : ℂ))" lean/Ising2D/` は章 018 の橋渡しにしかヒットしない） |
| `htr` | `tr(εV^{(+)}) > 0` | **未形式化**。章 018 自身の `closing_004_claim_H1_plus_in_sigma_z_form` / `closing_005_definition_open_chain_spin_energy` / `closing_005_claim_open_chain_partition_sum` / `closing_005_claim_open_chain_endpoint_product_sum` / `closing_005_claim_open_chain_spin_sums_positive` / `closing_006_theorem_trace_of_epsilon_V_plus` の枝で、配置基底での 1 次元開鎖のスピン和を要する（`015_ch018-formalization-findings.md` の「直接計算ルート」）。章 018 の主鎖とは独立で、循環参照は無い |
| `hWpos`, `hWcomm` | `W` の成分が正・`ε` と可換 | 章 010 の `V2_component_equals_pauli` / `epsilon_commutes_with_transfer_matrices` に依存。章 011 も同じ形で仮定として受け取っている（`lean/docs/ch011-formalization.md` 3 章の表） |

`hZ1` / `hZ2`（`c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`）は章 011 の
`Ising2D.partition_function_sandwich` の内容であり、章 018 の仮定ではないので手を付けていない。

## 4. 人手証明に見つけた誤り

**なし。** 章 014–017 と章 018 の主張は、上記 2 の型の違いを除いて過不足なく噛み合った。

## 5. 検証

```
$ cd exact-solution-of-2d-ising-model/lean
$ export PATH="$HOME/.elan/bin:$PATH" && lake build
Build completed successfully (2983 jobs).
$ ./scripts/check-no-sorry.sh
OK: ソース中に sorry / admit は無い
OK: 主要定理はいずれも sorryAx に依存していない
（exit 0）
```

`scripts/check-no-sorry.sh` の `targets` 配列末尾へ、新規の 28 個
（`Ising2D.star_checkQ` … `Ising2D.onsager_exact_solution_unconditional`）を追加した。
