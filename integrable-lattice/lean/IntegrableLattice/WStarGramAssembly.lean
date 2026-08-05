/-
# 命題 W\* の残り 2 件のうち「$w^*$ の等式を組み立てる段」— cycle 46 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明の第 2 段落
  「$\operatorname{Tr}T^N=\operatorname{Tr}_{A_\mathbb{Q}/\mathbb{Q}}(\mu\,\theta^N)$ なので、
  $G$ は双線型形式 $\langle x,y\rangle=\operatorname{Tr}(\mu xy)$ の Gram 行列である」
* $G$ の定義そのものは 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement

## この file が埋めるもの

本文の $G$ は整数行列 $(\operatorname{Tr}T^{i+j})$ であり、
cycle 41 step 1 以降 Lean 側で扱ってきた行列は代数のトレースで書いた
$(\operatorname{Tr}_{A_\mathbb{Q}}(\mu\theta^{j+k}))$ である。
**2 つが同じ行列であることが、この項目である。**

## 道の選び方（cycle 42–45 の実測が決めた）

* cycle 42 step 3: 橋の半分（代数のトレースを行列のトレースへ移す段）を書いた。
* cycle 43 step 5・44 step 3・45 step 4: 残る半分のうち
  「同じ特性多項式をもつ 2 つの行列はトレース冪がすべて一致する」を書き切った
  （`NewtonInitialValues.trace_pow_eq_of_charpoly_eq`）。
* **したがって残っていたのは、$\chi$ を特性多項式にもつ具体的な行列を代数の側で作り、
  そのトレース冪を重複度つきの成分の和へ分けることだけである。**

分けるのに要る中国剰余の配線は 命題 C′ の側で cycle 43 step 1・cycle 45 の
`PropCCrtWiring` / `PropCMuComponent` に入っている。**そこを使い回す。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは体 $K$（本文では $\mathbb{Q}$。可算）上の
多項式・有限次元代数・行列だけで、根も分解体も現れない。
$\overline{\mathbb{Q}}$ へも出ない——**本文が「Newton の公式より」と引いている段を
根で書かずに済ませたのが cycle 43–45 の 3 サイクルの内容である。**

## 書いたこと（5 段）

1. **一様なブロック対角の特性多項式**（`charpoly_blockDiagonal`）。
   mathlib は行列式（`Matrix.det_blockDiagonal`）とトレース（`Matrix.trace_blockDiagonal`）を
   持っているが、特性多項式については持っていない（2026-08-05 実測。
   `charpoly` と `blockDiagonal` を結ぶ宣言は 0 件）。
   **書く量は 2 行である**——特性行列がブロック対角と交換することを成分で見るだけ。
   **ブロックの大きさが揃っている形だけを書く。** 揃っていない形（`blockDiagonal'`）は
   行列式そのものが mathlib に無い（cycle 43 step 1 の実測）が、
   **この証明では要らない**——揃っていない並べ方は代数の側（中国剰余）が引き受ける。
2. **同じ行列を $a$ 個並べたときの特性多項式とトレース冪**
   （`charpoly_replicate` / `trace_pow_replicate`）。
3. **重複度つきの成分のトレース**（`trace_pow_adjoinRoot_pow`）。
   $\operatorname{Tr}_{K[x]/(f^a)}(\theta^N)=a\operatorname{Tr}_{K[x]/(f)}(\theta^N)$。
   **芯は段 2 と `trace_pow_eq_of_charpoly_eq` だけで、フィルトレーションも根も要らない。**
4. **直積代数のトレースの分解**（`trace_pi_fin`）。
   mathlib は二成分だけを持つ（`Algebra.trace_prod_apply`）ので、
   cycle 43 step 1 がノルムについて書いた帰納法（`ProductAlgebraNorm.norm_pi_fin`）と
   同じ形でトレースについて書く。
5. **本文の等式**（`trace_pow_eq_trace_mu` / `trace_mu_eq_card` / `trace_pow_eq_trace_mu_all`）。
   $\operatorname{Tr}T^N=\operatorname{Tr}_{A_K}(\mu\,\theta^N)$。
   $T$ については特性多項式が $\chi=\prod_i f_i^{a_i}$ であることしか使わない。
   **$N\ge1$ と $N=0$ で道が違う。そう書く**——$N\ge1$ はトレース冪の一致で出るが、
   $N=0$ ではその道が使えない（$T^0$ は単位行列で、特性多項式の情報を持たない）。
   $N=0$ は次元の勘定である——$\operatorname{Tr}T^0=r$、
   $\operatorname{Tr}_{A_K}(\mu)=\sum_i a_i\deg f_i=\deg\chi=r$。
   **本文の $G$ の $(0,0)$ 成分がこれで、$G$ の全成分が塞がる。**

## 形式化しなかったもの

* **$T$ が本文の転送行列であること**は使っていない（仮定は特性多項式だけである）。
  本文の $T$ の構成そのものは 命題 C′ の側の事柄である。
-/
import Mathlib
import IntegrableLattice.NewtonInitialValues
import IntegrableLattice.ProductAlgebraNorm
import IntegrableLattice.PropCCrtWiring
import IntegrableLattice.PropCMuComponent
import IntegrableLattice.WStarMuGram

namespace IntegrableLattice
namespace WStarGramAssembly

open Polynomial Matrix Finset

/-! ## 1. 一様なブロック対角の特性多項式 -/

section BlockDiagonal

variable {n o R : Type*} [DecidableEq n] [Fintype n] [DecidableEq o] [Fintype o] [CommRing R]

/-- **特性行列はブロック対角と交換する。** -/
theorem charmatrix_blockDiagonal (M : o → Matrix n n R) :
    charmatrix (blockDiagonal M) = blockDiagonal fun k => charmatrix (M k) := by
  ext ⟨i, k⟩ ⟨j, l⟩
  by_cases hkl : k = l
  · subst hkl
    by_cases hij : i = j
    · subst hij; simp [blockDiagonal_apply]
    · simp [blockDiagonal_apply, hij, Prod.ext_iff]
  · simp [blockDiagonal_apply, hkl, Prod.ext_iff]

/-- **一様なブロック対角の特性多項式は、ブロックの特性多項式の積である。**

mathlib は行列式とトレースについてこの形を持っているが、特性多項式については持っていない。 -/
theorem charpoly_blockDiagonal (M : o → Matrix n n R) :
    (blockDiagonal M).charpoly = ∏ k, (M k).charpoly := by
  rw [charpoly, charmatrix_blockDiagonal, det_blockDiagonal]
  rfl

/-- 添字の付け替えでトレースは変わらない（mathlib に宣言が無いので書く。2026-08-05 実測）。 -/
theorem trace_reindex {m : Type*} [Fintype m] (e : n ≃ m) (M : Matrix n n R) :
    trace (reindex e e M) = trace M := by
  rw [Matrix.trace, Matrix.trace]
  exact Fintype.sum_equiv e.symm _ _ fun i => by simp [Matrix.diag]

/-- **特性多項式が等しければ、添字の型が違ってもトレース冪は一致する。**

`NewtonInitialValues.trace_pow_eq_of_charpoly_eq` は同じ添字型の 2 つの行列についての形である。
本 file が比べる 2 つの行列は添字型が違う（代数の冪基底とブロック対角）ので、
**次数が等しいことから添字の間に全単射を取り、付け替えてから当てる。** -/
theorem trace_pow_eq_of_charpoly_eq_of_equiv [Nontrivial R] {m : Type*} [DecidableEq m] [Fintype m]
    {M : Matrix n n R} {N : Matrix m m R} (h : M.charpoly = N.charpoly) (k : ℕ) :
    trace (M ^ (k + 1)) = trace (N ^ (k + 1)) := by
  have hcard : Fintype.card m = Fintype.card n := by
    have := congrArg Polynomial.natDegree h
    rwa [charpoly_natDegree_eq_dim, charpoly_natDegree_eq_dim, eq_comm] at this
  obtain ⟨e⟩ := Fintype.truncEquivOfCardEq hcard |>.nonempty
  have hre : (reindex e e N).charpoly = N.charpoly := charpoly_reindex e N
  have hpow : reindex e e (N ^ (k + 1)) = (reindex e e N) ^ (k + 1) := by
    have := map_pow (reindexAlgEquiv R R e) N (k + 1)
    simpa [coe_reindexAlgEquiv] using this
  calc trace (M ^ (k + 1)) = trace ((reindex e e N) ^ (k + 1)) :=
        NewtonInitialValues.trace_pow_eq_of_charpoly_eq (by rw [h, hre]) k
    _ = trace (reindex e e (N ^ (k + 1))) := by rw [hpow]
    _ = trace (N ^ (k + 1)) := trace_reindex e _

end BlockDiagonal

/-! ## 2. 同じ行列を $a$ 個並べる -/

section Replicate

variable {n R : Type*} [DecidableEq n] [Fintype n] [CommRing R]

/-- 同じ行列を $a$ 個並べたブロック対角の特性多項式は $\chi_M^{\,a}$ である。 -/
theorem charpoly_replicate (M : Matrix n n R) (a : ℕ) :
    (blockDiagonal fun _ : Fin a => M).charpoly = M.charpoly ^ a := by
  rw [charpoly_blockDiagonal]
  simp

/-- 同じ行列を $a$ 個並べたブロック対角のトレース冪は $a\operatorname{Tr}(M^N)$ である。 -/
theorem trace_pow_replicate (M : Matrix n n R) (a N : ℕ) :
    trace ((blockDiagonal fun _ : Fin a => M) ^ N) = a • trace (M ^ N) := by
  rw [← blockDiagonal_pow, trace_blockDiagonal]
  simp

end Replicate

/-! ## 3. 重複度つきの成分のトレース

$\operatorname{Tr}_{K[x]/(f^a)}(\theta^N)=a\operatorname{Tr}_{K[x]/(f)}(\theta^N)$。 -/

section Multiplicity

variable {K : Type*} [Field K]

/-- $K[x]/(g)$ における $\theta$ 倍写像の行列（冪基底に関する）。 -/
noncomputable def mulMatrix {g : K[X]} (hg : g ≠ 0) :=
  Algebra.leftMulMatrix (AdjoinRoot.powerBasis hg).basis (AdjoinRoot.root g)

/-- **その特性多項式はモニックなら $g$ そのものである。** -/
theorem charpoly_mulMatrix {g : K[X]} (hmonic : g.Monic) (hg : g ≠ 0) :
    (mulMatrix hg).charpoly = g := by
  have hgen : (AdjoinRoot.powerBasis hg).gen = AdjoinRoot.root g := rfl
  rw [mulMatrix, ← hgen, _root_.charpoly_leftMulMatrix, hgen, AdjoinRoot.minpoly_root hg,
    hmonic.leadingCoeff]
  simp

/-- **代数のトレース冪は行列のトレース冪である。** -/
theorem trace_pow_eq_trace_mulMatrix {g : K[X]} (hg : g ≠ 0) (N : ℕ) :
    Algebra.trace K (AdjoinRoot g) (AdjoinRoot.root g ^ N)
      = trace ((mulMatrix hg) ^ N) := by
  rw [Algebra.trace_eq_matrix_trace (AdjoinRoot.powerBasis hg).basis, map_pow, mulMatrix]

/-- **重複度つきの成分のトレース。**

$$\operatorname{Tr}_{K[x]/(f^a)}(\theta^N)=a\,\operatorname{Tr}_{K[x]/(f)}(\theta^N)\qquad(N\ge1).$$

本文が $\chi=\prod_i f_i^{a_i}$ の根を重複度こみで数えている段そのものである。
**根を 1 つも取り出さない**——使うのは特性多項式が等しい 2 つの行列の
トレース冪が一致すること（`NewtonInitialValues.trace_pow_eq_of_charpoly_eq`）だけである。 -/
theorem trace_pow_adjoinRoot_pow {f : K[X]} (hmonic : f.Monic) (hf : f ≠ 0) (a : ℕ) (N : ℕ) :
    Algebra.trace K (AdjoinRoot (f ^ a)) (AdjoinRoot.root (f ^ a) ^ (N + 1))
      = a • Algebra.trace K (AdjoinRoot f) (AdjoinRoot.root f ^ (N + 1)) := by
  have hfa : f ^ a ≠ 0 := pow_ne_zero _ hf
  have hcharpoly : (mulMatrix hfa).charpoly
      = (blockDiagonal fun _ : Fin a => mulMatrix hf).charpoly := by
    rw [charpoly_mulMatrix (hmonic.pow a) hfa, charpoly_replicate, charpoly_mulMatrix hmonic hf]
  rw [trace_pow_eq_trace_mulMatrix hfa,
    trace_pow_eq_of_charpoly_eq_of_equiv hcharpoly N,
    trace_pow_replicate, trace_pow_eq_trace_mulMatrix hf]

end Multiplicity

/-! ## 4. 直積代数のトレースの分解

mathlib は二成分だけを持つ（`Algebra.trace_prod_apply`）。
cycle 43 step 1 がノルムについて書いた帰納法と同じ形で書く。 -/

section Pi

variable {R : Type*} [CommRing R]

/-- **有限個の成分の直積のトレースは、成分のトレースの和である。** -/
theorem trace_pi_fin (n : ℕ) (A : Fin n → Type*)
    [∀ i, CommRing (A i)] [∀ i, Algebra R (A i)]
    [∀ i, Module.Free R (A i)] [∀ i, Module.Finite R (A i)] (x : ∀ i, A i) :
    Algebra.trace R (∀ i, A i) x = ∑ i, Algebra.trace R (A i) (x i) := by
  induction n with
  | zero =>
    have : Subsingleton (∀ i : Fin 0, A i) := ⟨fun _ _ => funext fun i => i.elim0⟩
    have hx : x = 0 := Subsingleton.elim _ _
    rw [hx, map_zero]
    simp
  | succ n ih =>
    have h1 : ((ProductAlgebraNorm.piFinSuccAlgEquiv (R := R) n A) x).1 = x 0 := rfl
    have h2 : ((ProductAlgebraNorm.piFinSuccAlgEquiv (R := R) n A) x).2
        = fun i : Fin n => x i.succ := rfl
    rw [← Algebra.trace_eq_of_algEquiv (ProductAlgebraNorm.piFinSuccAlgEquiv (R := R) n A) x,
      Algebra.trace_prod_apply, h1, h2, ih (fun i => A i.succ) (fun i => x i.succ),
      Fin.sum_univ_succ]

end Pi

/-! ## 5. 本文の等式

$\operatorname{Tr}T^N=\operatorname{Tr}_{A_K}(\mu\,\theta^N)$（$N\ge1$）。 -/

section Capstone

open WStarRadical

variable {K : Type*} [Field K] [PerfectField K] {n : ℕ} {f g : Fin n → K[X]}

/-- 中国剰余の同型を `AdjoinRoot` の綴りで受け取る。

`PropCCrtWiring.quotientProdAlgEquiv` は商の綴りで書かれており、`AdjoinRoot` は
その型シノニムである。**同じ写像だが、書き換えは綴りが一致しないと当たらない**ので、
以降で使う綴りへ寄せる。 -/
noncomputable def crtEquiv (hco : Pairwise (Function.onFun IsCoprime g)) :
    AdjoinRoot (∏ i, g i) ≃ₐ[K] ∀ i, AdjoinRoot (g i) :=
  PropCCrtWiring.quotientProdAlgEquiv hco

/-- 第 $i$ 成分は成分への射影（`AdjoinRoot.algHomOfDvd`）である。 -/
theorem crtEquiv_apply (hco : Pairwise (Function.onFun IsCoprime g)) (i : Fin n)
    (x : AdjoinRoot (∏ j, g j)) :
    crtEquiv hco x i
      = AdjoinRoot.algHomOfDvd K (∏ j, g j) (g i) (Finset.dvd_prod_of_mem g (mem_univ i)) x :=
  PropCMuComponent.quotientProdAlgEquiv_apply_eq_algHomOfDvd hco i x

/-- **中国剰余の同型は $\theta$ を成分の $\theta_i$ へ送る。** -/
theorem crtEquiv_root (hco : Pairwise (Function.onFun IsCoprime g)) (i : Fin n) :
    crtEquiv hco (AdjoinRoot.root (∏ j, g j)) i = AdjoinRoot.root (g i) := by
  rw [crtEquiv_apply]
  have := PropCMuComponent.algHomOfDvd_aeval_root (K := K)
    (Finset.dvd_prod_of_mem g (mem_univ i)) Polynomial.X
  simpa using this

/-- 相異なるモニック既約因子の冪も対ごとに互いに素である。 -/
theorem pairwise_isCoprime_pow (a : Fin n → ℕ)
    (hco : Pairwise (Function.onFun IsCoprime f)) :
    Pairwise (Function.onFun IsCoprime fun i => (f i) ^ (a i)) :=
  fun _ _ hij => ((hco hij).pow)

/-- **$\mu$ の側を成分へ分ける。**

$$\operatorname{Tr}_{A_K}(\mu\,\theta^{M})=\sum_i a_i\operatorname{Tr}_{K_i}(\theta_i^{M}).$$

指数 $M$ は任意（$M=0$ も含む）。使うのは中国剰余の同型と、
$\mu$ の成分が $a_i$ であること（cycle 45 の `algHomOfDvd_mu_eq_multiplicity`）だけである。 -/
theorem trace_mu_pow_eq_sum (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f)
    (M : ℕ) :
    Algebra.trace K (AdjoinRoot (rad f))
        (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a))
          * AdjoinRoot.root (rad f) ^ M)
      = ∑ i, (a i : K) * Algebra.trace K (AdjoinRoot (f i))
          (AdjoinRoot.root (f i) ^ M) := by
  classical
  show Algebra.trace K (AdjoinRoot (∏ i, f i))
      (WStarMuGram.mu (∏ i, f i) (aeval (AdjoinRoot.root (∏ i, f i)) (multWeight f a))
        * AdjoinRoot.root (∏ i, f i) ^ M) = _
  have hco := PropCCrtWiring.pairwise_isCoprime_of_irreducible hirr hmonic hinj
  haveI hfree : ∀ i, Module.Free K (AdjoinRoot (f i)) := fun i =>
    Module.Free.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  haveI hfin : ∀ i, Module.Finite K (AdjoinRoot (f i)) := fun i =>
    Module.Finite.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  have hsq : Squarefree (∏ i, f i) := by
    refine WStarRadical.squarefree_rad (fun i => (hirr i).prime) ?_
    intro i j hij hdvd
    exact hij (hinj (Polynomial.eq_of_monic_of_associated (hmonic i) (hmonic j)
      ((((hirr j).dvd_iff.mp hdvd).resolve_left (hirr i).not_isUnit)).symm))
  have hmove : Algebra.trace K (∀ i, AdjoinRoot (f i))
      (crtEquiv hco (WStarMuGram.mu (∏ j, f j)
          (aeval (AdjoinRoot.root (∏ j, f j)) (multWeight f a))
        * AdjoinRoot.root (∏ j, f j) ^ M))
      = Algebra.trace K (AdjoinRoot (∏ i, f i))
        (WStarMuGram.mu (∏ i, f i) (aeval (AdjoinRoot.root (∏ i, f i)) (multWeight f a))
          * AdjoinRoot.root (∏ i, f i) ^ M) :=
    Algebra.trace_eq_of_algEquiv _ _
  rw [← hmove, trace_pi_fin]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hmu : crtEquiv hco
      (WStarMuGram.mu (∏ j, f j) (aeval (AdjoinRoot.root (∏ j, f j)) (multWeight f a))) i
      = algebraMap K (AdjoinRoot (f i)) ((a i : K)) := by
    rw [crtEquiv_apply]
    exact PropCMuComponent.algHomOfDvd_mu_eq_multiplicity f a hsq i
  have hθ : crtEquiv hco (AdjoinRoot.root (∏ j, f j)) i = AdjoinRoot.root (f i) :=
    crtEquiv_root hco i
  have hcomp : (crtEquiv hco (WStarMuGram.mu (∏ j, f j)
        (aeval (AdjoinRoot.root (∏ j, f j)) (multWeight f a))
      * AdjoinRoot.root (∏ j, f j) ^ M)) i
      = algebraMap K (AdjoinRoot (f i)) ((a i : K)) * AdjoinRoot.root (f i) ^ M := by
    rw [map_mul (crtEquiv hco), Pi.mul_apply, map_pow (crtEquiv hco), Pi.pow_apply, hmu, hθ]
  rw [hcomp, ← Algebra.smul_def, map_smul, smul_eq_mul]

/-- **本文の $\operatorname{Tr}T^N=\operatorname{Tr}_{A_K/K}(\mu\,\theta^N)$（$N\ge1$）。**

$T$ については特性多項式が $\chi=\prod_i f_i^{a_i}$ であることしか使わない。
右辺の $\mu$ は本文の構成（$\eta/\rho'(\theta)$）そのもので、仮定として受け取らない。

**これが 命題 W\* の残り項目「$w^*$ の等式を組み立てる段」である**——
本文の整数行列 $G=(\operatorname{Tr}T^{i+j})$ と、
Lean 側で扱ってきた代数の Gram 行列 $(\operatorname{Tr}_{A_K}(\mu\theta^{j+k}))$ が
同じ行列であることが、この等式に他ならない。 -/
theorem trace_pow_eq_trace_mu (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f)
    {r : ℕ} {T : Matrix (Fin r) (Fin r) K} (hT : T.charpoly = chi f a) (N : ℕ) :
    trace (T ^ (N + 1))
      = Algebra.trace K (AdjoinRoot (rad f))
          (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a))
            * AdjoinRoot.root (rad f) ^ (N + 1)) := by
  classical
  -- `rad`・`chi` は定義であって、綴りが違うと書き換えが当たらない。積の形へ寄せる。
  show trace (T ^ (N + 1))
      = Algebra.trace K (AdjoinRoot (∏ i, f i))
          (WStarMuGram.mu (∏ i, f i)
              (aeval (AdjoinRoot.root (∏ i, f i)) (multWeight f a))
            * AdjoinRoot.root (∏ i, f i) ^ (N + 1))
  have hT' : T.charpoly = ∏ i, (f i) ^ (a i) := hT
  have hco := PropCCrtWiring.pairwise_isCoprime_of_irreducible hirr hmonic hinj
  have hcoP := pairwise_isCoprime_pow a hco
  have hf0 : ∀ i, f i ≠ 0 := fun i => (hmonic i).ne_zero
  have hchiMonic : (∏ i, (f i) ^ (a i)).Monic :=
    monic_prod_of_monic _ _ fun i _ => (hmonic i).pow _
  have hchi0 : (∏ i, (f i) ^ (a i)) ≠ 0 := hchiMonic.ne_zero
  haveI hfree : ∀ i, Module.Free K (AdjoinRoot (f i)) := fun i =>
    Module.Free.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  haveI hfin : ∀ i, Module.Finite K (AdjoinRoot (f i)) := fun i =>
    Module.Finite.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  haveI hfreeP : ∀ i, Module.Free K (AdjoinRoot ((f i) ^ (a i))) := fun i =>
    Module.Free.of_basis (AdjoinRoot.powerBasis' ((hmonic i).pow _)).basis
  haveI hfinP : ∀ i, Module.Finite K (AdjoinRoot ((f i) ^ (a i))) := fun i =>
    Module.Finite.of_basis (AdjoinRoot.powerBasis' ((hmonic i).pow _)).basis
  have hsq : Squarefree (∏ i, f i) := by
    refine WStarRadical.squarefree_rad (fun i => (hirr i).prime) ?_
    intro i j hij hdvd
    exact hij (hinj (Polynomial.eq_of_monic_of_associated (hmonic i) (hmonic j)
      ((((hirr j).dvd_iff.mp hdvd).resolve_left (hirr i).not_isUnit)).symm))
  -- (1) 行列の側を代数へ移す（特性多項式が同じ 2 つの行列のトレース冪は一致する）
  have h1 : trace (T ^ (N + 1))
      = Algebra.trace K (AdjoinRoot (∏ i, (f i) ^ (a i)))
        (AdjoinRoot.root (∏ i, (f i) ^ (a i)) ^ (N + 1)) := by
    rw [trace_pow_eq_trace_mulMatrix hchi0]
    exact trace_pow_eq_of_charpoly_eq_of_equiv
      (by rw [hT', charpoly_mulMatrix hchiMonic hchi0]) N
  -- (2) $\chi$ の側を成分へ分ける
  have h2 : Algebra.trace K (AdjoinRoot (∏ i, (f i) ^ (a i)))
        (AdjoinRoot.root (∏ i, (f i) ^ (a i)) ^ (N + 1))
      = ∑ i, Algebra.trace K (AdjoinRoot ((f i) ^ (a i)))
          (AdjoinRoot.root ((f i) ^ (a i)) ^ (N + 1)) := by
    have hmove : Algebra.trace K (∀ i, AdjoinRoot ((f i) ^ (a i)))
        (crtEquiv hcoP (AdjoinRoot.root (∏ i, (f i) ^ (a i)) ^ (N + 1)))
        = Algebra.trace K (AdjoinRoot (∏ i, (f i) ^ (a i)))
          (AdjoinRoot.root (∏ i, (f i) ^ (a i)) ^ (N + 1)) :=
      Algebra.trace_eq_of_algEquiv _ _
    rw [← hmove, trace_pi_fin]
    refine Finset.sum_congr rfl fun i _ => ?_
    have hcomp : (crtEquiv hcoP (AdjoinRoot.root (∏ j, (f j) ^ (a j)) ^ (N + 1))) i
        = AdjoinRoot.root ((f i) ^ (a i)) ^ (N + 1) := by
      rw [map_pow (crtEquiv hcoP), Pi.pow_apply, crtEquiv_root hcoP i]
    rw [hcomp]
  -- (3) 成分ごとに重複度を落とす
  have h3 : ∀ i, Algebra.trace K (AdjoinRoot ((f i) ^ (a i)))
        (AdjoinRoot.root ((f i) ^ (a i)) ^ (N + 1))
      = (a i : K) * Algebra.trace K (AdjoinRoot (f i)) (AdjoinRoot.root (f i) ^ (N + 1)) := by
    intro i
    have hstep := trace_pow_adjoinRoot_pow (hmonic i) (hf0 i) (a i) N
    rw [nsmul_eq_mul] at hstep
    exact hstep
  -- (4) $\mu$ の側を成分へ分ける
  have h4 : Algebra.trace K (AdjoinRoot (∏ i, f i))
        (WStarMuGram.mu (∏ i, f i) (aeval (AdjoinRoot.root (∏ i, f i)) (multWeight f a))
          * AdjoinRoot.root (∏ i, f i) ^ (N + 1))
      = ∑ i, (a i : K) * Algebra.trace K (AdjoinRoot (f i))
          (AdjoinRoot.root (f i) ^ (N + 1)) :=
    trace_mu_pow_eq_sum a hirr hmonic hinj (N + 1)
  rw [h1, h2, h4]
  exact Finset.sum_congr rfl fun i _ => h3 i

/-- **$N=0$ の成分**（本文の $G$ の $(0,0)$ 成分）。

$\operatorname{Tr}T^0=r$ であり、$\operatorname{Tr}_{A_K}(\mu)=\sum_i a_i\deg f_i=\deg\chi=r$ である。
$N\ge1$ の道（トレース冪の一致）はここでは使えないので、次元の勘定で書く。 -/
theorem trace_mu_eq_card (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f)
    {r : ℕ} {T : Matrix (Fin r) (Fin r) K} (hT : T.charpoly = chi f a) :
    trace (T ^ 0)
      = Algebra.trace K (AdjoinRoot (rad f))
          (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a))
            * AdjoinRoot.root (rad f) ^ 0) := by
  classical
  have hT' : T.charpoly = ∏ i, (f i) ^ (a i) := hT
  haveI hfree : ∀ i, Module.Free K (AdjoinRoot (f i)) := fun i =>
    Module.Free.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  haveI hfin : ∀ i, Module.Finite K (AdjoinRoot (f i)) := fun i =>
    Module.Finite.of_basis (AdjoinRoot.powerBasis' (hmonic i)).basis
  -- 右辺: 成分へ分けて次元を数える
  have hright : Algebra.trace K (AdjoinRoot (rad f))
      (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a))
        * AdjoinRoot.root (rad f) ^ 0)
      = ∑ i, (a i : K) * ((f i).natDegree : K) := by
    rw [trace_mu_pow_eq_sum a hirr hmonic hinj 0]
    refine Finset.sum_congr rfl fun i _ => ?_
    have hone : Algebra.trace K (AdjoinRoot (f i)) 1
        = (Module.finrank K (AdjoinRoot (f i)) : K) := by
      have := Algebra.trace_algebraMap (R := K) (S := AdjoinRoot (f i)) 1
      simpa using this
    rw [pow_zero, hone, (AdjoinRoot.powerBasis' (hmonic i)).finrank,
      AdjoinRoot.powerBasis'_dim]
  -- 左辺: 単位行列のトレースは次数である
  have hleft : trace (T ^ 0) = (r : K) := by
    rw [pow_zero, Matrix.trace_one]
    simp
  -- 次数の勘定: $\deg\chi=\sum_i a_i\deg f_i$ で、それが $r$ である
  have hdeg : (∏ i, (f i) ^ (a i)).natDegree = ∑ i, (a i) * (f i).natDegree := by
    rw [Polynomial.natDegree_prod _ _ (fun i _ => pow_ne_zero _ (hmonic i).ne_zero)]
    exact Finset.sum_congr rfl fun i _ => Polynomial.natDegree_pow _ _
  have hr : r = ∑ i, (a i) * (f i).natDegree := by
    have hcard : (∏ i, (f i) ^ (a i)).natDegree = Fintype.card (Fin r) := by
      rw [← hT', charpoly_natDegree_eq_dim]
    rw [← hdeg, hcard, Fintype.card_fin]
  rw [hleft, hright, hr]
  push_cast
  rfl

/-- **本文の $G$ の全成分の同定**（$N$ に条件を付けない形）。

$$\operatorname{Tr}T^N=\operatorname{Tr}_{A_K/K}(\mu\,\theta^N)\qquad(N\ge0).$$

**本文の整数行列 $G=(\operatorname{Tr}T^{i+j})$ と代数の Gram 行列
$(\operatorname{Tr}_{A_K}(\mu\theta^{j+k}))$ が同じ行列であることは、この等式である。** -/
theorem trace_pow_eq_trace_mu_all (a : Fin n → ℕ)
    (hirr : ∀ i, Irreducible (f i)) (hmonic : ∀ i, (f i).Monic) (hinj : Function.Injective f)
    {r : ℕ} {T : Matrix (Fin r) (Fin r) K} (hT : T.charpoly = chi f a) (N : ℕ) :
    trace (T ^ N)
      = Algebra.trace K (AdjoinRoot (rad f))
          (WStarMuGram.mu (rad f) (aeval (AdjoinRoot.root (rad f)) (multWeight f a))
            * AdjoinRoot.root (rad f) ^ N) := by
  cases N with
  | zero => exact trace_mu_eq_card a hirr hmonic hinj hT
  | succ N => exact trace_pow_eq_trace_mu a hirr hmonic hinj hT N

end Capstone

end WStarGramAssembly
end IntegrableLattice
