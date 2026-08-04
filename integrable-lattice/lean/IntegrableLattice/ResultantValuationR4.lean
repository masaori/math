/-
# 命題 R の (R4)（終結式による付値）と (R5)（予言アルゴリズムの無仮定化）— cycle 34 step 1

対応する人手証明:

* 本文ブロック `paper_101_theorem_digit_branch`（命題 R）の (R4)(R5)
  （`structured-latex/content/009_theta_recursion.ts`）
* 同じ命題の (R1)(R2)(R3) は `DigitBranchRecursion.lean` と `Cycle27ProofSteps.lean` にある。

## 人手証明との対応

(R4) の人手証明は次の 3 行である。

> $\ell$ は $K=\mathbb{Q}(\zeta_{\ell^{M}})$ で完全分岐し、剰余次数は $1$ である。
> $\Psi_M$ はモニックでその根が $\pi$ の共役全体だから、$F\in\mathbb{Z}[x]$ に対し
> $\mathrm{Res}_x(\Psi_M,F)=\prod_\sigma F(\sigma\pi)=N_{K/\mathbb{Q}}(F(\pi))$。
> 一般に $v_\ell(N_{K/\mathbb{Q}}(\alpha))=f\cdot v_{\mathfrak l}(\alpha)$（$f=1$）なので
> $v_\ell(N(\alpha))=\varphi\,v_\ell(\alpha)$ である。

| 人手証明の行 | この file の定理 |
|---|---|
| $\mathrm{Res}$ が根での値の積であること（モニック） | `resultant_monic_eq_prod_eval` |
| 共役どうしは $\pi$ 進の位数が等しいこと | `associated_pow_of_algEquiv` / `associated_eval_of_hom` |
| $\pi$ の共役の積が $\ell$ になること（完全分岐・$f=1$） | `associated_prod_pow_ell` |
| $\Psi_M$ の根がちょうど $\xi-1$ であること | `roots_psi` / `card_roots_psi` / `associated_root_psi` |
| (R4) 本体 | `associated_resultant_pow_of_conj` / `associated_resultant_psi` |
| 整数の $\ell$ 進付値への翻訳 | `padicValInt_eq_of_associated_pow` |
| (R5) の組み立て | `ordEll_kappa_of_level_decomposition` |

## 付値を「$\pi$ の冪との同伴」で書いた理由

`CyclotomicValuationQ4a.lean`（cycle 33 step 1）と同じ書き方を採る。
$v_{\mathfrak l}(\pi)=1$ なので「$v_{\mathfrak l}(x)=t$」と「$x$ が $\pi^t$ と同伴」は同値であり、
主張の内容は変わらない。同伴で書くと、以下の証明が使う性質が
**$\pi$ が素元であることと整域であることだけ**であることが型に出る。
人手証明が言う「$\ell$ が完全分岐し剰余次数が $1$」は、ここでは
$(\zeta-1)^{\varphi(\ell^M)}\sim\ell$（`associated_sub_one_pow_totient`）という 1 本の同伴に化ける。
Dedekind 環の理論も分岐指数・慣性次数の一般論も使わない。

**形式化して分かったこと**: 人手証明は $\mathrm{Res}=N_{K/\mathbb{Q}}(F(\pi))$ を経由するが、
**ノルムは要らない。** 効くのは「$\mathrm{Res}$ が根での値の積である」ことと
「共役どうしが同伴である」ことだけで、ノルムはその積に付けた名前にすぎない。
ノルムを経由しないので、$K/\mathbb{Q}$ が Galois であることも（$\sigma$ を数え上げる形では）使わない。

## 形式化しなかったもの

* **各根 $\alpha$ へ $\pi$ を送る環準同型があること**（`associated_resultant_psi` の `hconj`）。
  これが本 file に残る唯一の外部入力で、$K/\mathbb{Q}$ が Galois であることの側から来る。
  mathlib には円分拡大の Galois 群の記述（`IsCyclotomicExtension.autEquivPow`）が在るので
  **素材の欠落ではなく配線**だが、整数環へ制限する段を含めて本 file は書いていない。
* $\Psi_M$ がモニックであることと分解することも仮定として受け取っている
  （`hΨ`・`hsplit`。どちらも円分多項式の標準的な性質で、配線である）。
* (R5) の入力である 命題 J の (J3) のレベル分解と 命題 W の積の公式は、
  それぞれ仮定として受け取る（本論文がそこで証明しているものであり、
  (R5) 自身の内容は「合わせるだけ」である）。
-/
import Mathlib
import IntegrableLattice.CyclotomicValuationQ4a

namespace IntegrableLattice
namespace PropRResultantValuation

open Finset Polynomial PropQCyclotomicValuation

/-! ## 段 1: $\pi^t$ と同伴な元を $\varphi(\ell^M)$ 個掛けると $\ell^t$ と同伴になる

これが人手証明の「$\ell$ が完全分岐し剰余次数が $1$ だから
$v_\ell(N(\alpha))=\varphi\cdot v_\ell(\alpha)$」にあたる。 -/

/-- $\pi^t$ と同伴な元の積は $\pi^{t\cdot|\iota|}$ と同伴。 -/
theorem associated_prod_pow {R : Type*} [CommRing R] {ι : Type*} (s : Finset ι) {π : R} {t : ℕ}
    (f : ι → R) (hf : ∀ i ∈ s, Associated (f i) (π ^ t)) :
    Associated (∏ i ∈ s, f i) (π ^ (t * s.card)) := by
  have h := Associated.prod s f (fun _ => π ^ t) hf
  calc Associated (∏ i ∈ s, f i) (∏ _i ∈ s, π ^ t) := h
    _ = π ^ (t * s.card) := by rw [Finset.prod_const, ← pow_mul]

/-- **完全分岐の中身**。$\zeta$ を原始 $\ell^{M+1}$ 乗根、$\pi=\zeta-1$ とすると、
$\pi^t$ と同伴な元を $\varphi(\ell^{M+1})$ 個掛けたものは $\ell^t$ と同伴である。

人手証明の $v_\ell(N(\alpha))=\varphi\,v_\ell(\alpha)$（$f=1$）と同じ内容だが、
使うのは $(\zeta-1)^{\varphi(\ell^{M+1})}\sim\ell$ の 1 本だけである。 -/
theorem associated_prod_pow_ell {R : Type*} [CommRing R] [IsDomain R] {ℓ M : ℕ} [Fact ℓ.Prime]
    {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1))) {ι : Type*} (s : Finset ι) {t : ℕ}
    (f : ι → R) (hf : ∀ i ∈ s, Associated (f i) ((ζ - 1) ^ t))
    (hcard : s.card = Nat.totient (ℓ ^ (M + 1))) :
    Associated (∏ i ∈ s, f i) ((ℓ : R) ^ t) := by
  have h1 : Associated (∏ i ∈ s, f i) ((ζ - 1) ^ (t * Nat.totient (ℓ ^ (M + 1)))) := by
    rw [← hcard]; exact associated_prod_pow s f hf
  have h2 : Associated (((ζ - 1) ^ Nat.totient (ℓ ^ (M + 1))) ^ t) ((ℓ : R) ^ t) :=
    (associated_sub_one_pow_totient hζ).pow_pow (n := t)
  refine h1.trans ?_
  rw [mul_comm, pow_mul]
  exact h2

/-! ## 段 2: 共役どうしは $\pi$ 進の位数が等しい

$\sigma$ が環準同型なら同伴を保つ。したがって $\alpha\sim\pi^t$ なら
$\sigma\alpha\sim(\sigma\pi)^t$ であり、$\sigma\pi$ が $\pi$ と同伴なら $\sigma\alpha\sim\pi^t$。 -/

/-- 環準同型は同伴を保つ。共役が同じ $\pi$ 進位数をもつことの中身である。 -/
theorem associated_map_pow {R S : Type*} [CommRing R] [CommRing S] (σ : R →+* S) {α π : R} {t : ℕ}
    (h : Associated α (π ^ t)) : Associated (σ α) ((σ π) ^ t) := by
  simpa using h.map (σ : R →* S)

/-- **共役の位数が等しいこと**。$\sigma\pi$ が $\pi$ と同伴なら、$\alpha\sim\pi^t$ から
$\sigma\alpha\sim\pi^t$ が出る。 -/
theorem associated_pow_of_algEquiv {R : Type*} [CommRing R] (σ : R →+* R) {α π : R} {t : ℕ}
    (hσπ : Associated (σ π) π) (h : Associated α (π ^ t)) : Associated (σ α) (π ^ t) :=
  (associated_map_pow σ h).trans (hσπ.pow_pow (n := t))

/-! ## 段 3: 終結式が根での値の積であること（モニックの場合）

mathlib の `resultant_eq_prod_eval` は先頭係数の冪が付くが、モニックなら消える。 -/

/-- $\Psi$ がモニックで分解するなら $\mathrm{Res}(\Psi,F)=\prod_{\Psi(\alpha)=0}F(\alpha)$。 -/
theorem resultant_monic_eq_prod_eval {R : Type*} [CommRing R] [IsDomain R]
    (Ψ F : R[X]) (n : ℕ) (hF : F.natDegree ≤ n) (hΨ : Ψ.Monic) (hsplit : Ψ.Splits) :
    Ψ.resultant F Ψ.natDegree n = (Ψ.roots.map F.eval).prod := by
  rw [resultant_eq_prod_eval Ψ F n hF hsplit, hΨ.leadingCoeff, one_pow, one_mul]

/-! ## 段 4: (R4) 本体

$\Psi_M$ の根での $F$ の値がすべて $\pi^t$ と同伴なら、終結式は $\ell^t$ と同伴である。
根の個数が $\varphi(\ell^{M+1})$ であることが完全分岐の効くところである。 -/

/-- **(R4)**。$\mathrm{Res}(\Psi_M,F)\sim\ell^{t}$。

`hroot` は「$\Psi_M$ の各根 $\alpha$ で $F(\alpha)$ が $\pi^t$ と同伴」、
`hcard` は「根の個数が $\varphi(\ell^{M+1})$」である。前者は段 2（共役の位数が等しいこと）が、
後者は $\Psi_M$ が $\Phi_{\ell^{M+1}}(1+x)$ であることが供給する。 -/
theorem associated_resultant_pow_of_conj {R : Type*} [CommRing R] [IsDomain R]
    {ℓ M : ℕ} [Fact ℓ.Prime] {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1)))
    (Ψ F : R[X]) (n : ℕ) (hF : F.natDegree ≤ n) (hΨ : Ψ.Monic) (hsplit : Ψ.Splits) {t : ℕ}
    (hroot : ∀ α ∈ Ψ.roots, Associated (F.eval α) ((ζ - 1) ^ t))
    (hcard : Multiset.card Ψ.roots = Nat.totient (ℓ ^ (M + 1))) :
    Associated (Ψ.resultant F Ψ.natDegree n) ((ℓ : R) ^ t) := by
  rw [resultant_monic_eq_prod_eval Ψ F n hF hΨ hsplit]
  -- 根の重複度込みの積を、`Multiset` の積として評価する。
  have h1 : Associated (Ψ.roots.map F.eval).prod ((ζ - 1) ^ (t * Multiset.card Ψ.roots)) := by
    have hmap : ∀ x ∈ Ψ.roots.map F.eval, Associated x ((ζ - 1) ^ t) := by
      intro x hx
      obtain ⟨α, hα, rfl⟩ := Multiset.mem_map.mp hx
      exact hroot α hα
    -- `Associates` へ送ると同伴が等号になるので、全要素が同じ像をもつことに帰着する。
    rw [← Associates.mk_eq_mk_iff_associated, ← Associates.prod_mk, Associates.mk_pow]
    have hrep : (Ψ.roots.map F.eval).map Associates.mk
        = Multiset.replicate (Multiset.card Ψ.roots) (Associates.mk ((ζ - 1) ^ t)) := by
      refine Multiset.eq_replicate.mpr ⟨by simp, ?_⟩
      intro b hb
      obtain ⟨x, hx, rfl⟩ := Multiset.mem_map.mp hb
      exact Associates.mk_eq_mk_iff_associated.mpr (hmap x hx)
    rw [hrep, Multiset.prod_replicate, ← Associates.mk_pow, ← pow_mul, Associates.mk_pow]
  have h2 : Associated (((ζ - 1) ^ Nat.totient (ℓ ^ (M + 1))) ^ t) ((ℓ : R) ^ t) :=
    (associated_sub_one_pow_totient hζ).pow_pow (n := t)
  refine h1.trans ?_
  rw [hcard, mul_comm, pow_mul]
  exact h2

/-! ## 段 4b: `hroot` を供給する（共役へ送る環準同型があればよい）

段 4 の `hroot` は「$\Psi_M$ の各根で $F$ の値が $\pi^t$ と同伴」という仮定だった。
これを供給するのに要るのは、**各根 $\alpha$ へ $\pi$ を送る環準同型が存在すること**だけである。
$F$ の係数が整数なら、環準同型は $F$ の評価と可換なので $F(\alpha)=\sigma(F(\pi))$ となり、
あとは段 2 が効く。 -/

/-- 整数係数の多項式の評価は、任意の環準同型と可換である。 -/
theorem eval_map_comm {R : Type*} [CommRing R] (σ : R →+* R) (F : ℤ[X]) (x : R) :
    (F.map (Int.castRingHom R)).eval (σ x) = σ ((F.map (Int.castRingHom R)).eval x) := by
  rw [eval_map, eval_map, hom_eval₂]
  congr 1
  ext n
  simp

/-- **`hroot` の供給**。各根 $\alpha$ について $\pi\mapsto\alpha$ の環準同型があり、
かつ $\alpha$ が $\pi$ と同伴なら、$F(\pi)\sim\pi^t$ から $F(\alpha)\sim\pi^t$ が出る。

$\Psi_M=\Phi_{\ell^{M+1}}(1+x)$ の根は $\xi-1$（$\xi$ は原始 $\ell^{M+1}$ 乗根）なので、
「$\alpha$ が $\pi$ と同伴」は `associated_sub_one_of_isPrimitiveRoot` が与える。
残る「$\pi\mapsto\alpha$ の環準同型がある」が Galois の側の入力であり、そこだけを仮定に出してある。 -/
theorem associated_eval_of_hom {R : Type*} [CommRing R] {π α : R} {t : ℕ} (F : ℤ[X])
    (σ : R →+* R) (hσ : σ π = α) (hαπ : Associated α π)
    (h : Associated ((F.map (Int.castRingHom R)).eval π) (π ^ t)) :
    Associated ((F.map (Int.castRingHom R)).eval α) (π ^ t) := by
  rw [← hσ, eval_map_comm σ F π]
  refine (associated_map_pow σ h).trans ?_
  rw [hσ]
  exact hαπ.pow_pow (n := t)

/-! ## 段 4c: $\Psi_M=\Phi_{\ell^{M+1}}(1+x)$ の根

本文が置く $\Psi_M(x)=\Phi_{\ell^{M}}(1+x)$ について、根がちょうど $\xi-1$（$\xi$ は原始根）で
あり、個数が $\varphi(\ell^{M})$ であることを書く。これで段 4 の `hcard` は仮定でなくなる。 -/

/-- $\Psi_M(x)=\Phi_{\ell^{M+1}}(1+x)$ は $\prod_{\xi}(x-(\xi-1))$ に等しい
（$\xi$ は原始 $\ell^{M+1}$ 乗根を走る）。根を `Multiset` として取り出したいので、
右辺は原始根の `Multiset` の像の積として書く。 -/
theorem psi_eq_prod {R : Type*} [CommRing R] [IsDomain R] {ℓ M : ℕ} [Fact ℓ.Prime]
    {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1))) :
    (cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)
      = (((primitiveRoots (ℓ ^ (M + 1)) R).val.map (fun ξ => ξ - 1)).map
          (fun a => X - C a)).prod := by
  classical
  rw [cyclotomic_eq_prod_X_sub_primitiveRoots hζ, Polynomial.prod_comp]
  rw [Multiset.map_map]
  rw [Finset.prod_eq_multiset_prod]
  refine congrArg Multiset.prod (Multiset.map_congr rfl fun ξ _ => ?_)
  simp [sub_comp, X_comp, C_comp]
  ring

/-- $\Psi_M$ の根はちょうど $\xi-1$（$\xi$ は原始 $\ell^{M+1}$ 乗根）である。 -/
theorem roots_psi {R : Type*} [CommRing R] [IsDomain R] {ℓ M : ℕ} [Fact ℓ.Prime]
    {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1))) :
    ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).roots
      = (primitiveRoots (ℓ ^ (M + 1)) R).val.map (fun ξ => ξ - 1) := by
  rw [psi_eq_prod hζ, roots_multiset_prod_X_sub_C]

/-- $\Psi_M$ の根の個数は $\varphi(\ell^{M+1})$ である（段 4 の `hcard` の供給）。 -/
theorem card_roots_psi {R : Type*} [CommRing R] [IsDomain R] {ℓ M : ℕ} [Fact ℓ.Prime]
    {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1))) :
    Multiset.card ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).roots
      = Nat.totient (ℓ ^ (M + 1)) := by
  rw [roots_psi hζ, Multiset.card_map, ← hζ.card_primitiveRoots]
  rfl

/-- $\Psi_M$ の各根は $\xi-1$ の形をしており、$\pi=\zeta-1$ と同伴である
（段 4b の `hαπ` の供給）。 -/
theorem associated_root_psi {R : Type*} [CommRing R] [IsDomain R] {ℓ M : ℕ} [Fact ℓ.Prime]
    {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1))) {α : R}
    (hα : α ∈ ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).roots) :
    Associated α (ζ - 1) := by
  have hne : (ℓ : ℕ) ^ (M + 1) ≠ 0 := pow_ne_zero _ (Fact.out (p := ℓ.Prime)).pos.ne'
  haveI : NeZero ((ℓ : ℕ) ^ (M + 1)) := ⟨hne⟩
  rw [roots_psi hζ] at hα
  obtain ⟨ξ, hξ, rfl⟩ := Multiset.mem_map.mp hα
  exact associated_sub_one_of_isPrimitiveRoot
    (isPrimitiveRoot_of_mem_primitiveRoots hξ) hζ

/-! ## 段 4d: (R4) を $\Psi_M$ について組み上げる

段 4・4b・4c を繋ぐ。残る入力は「各根へ $\pi$ を送る環準同型が存在すること」だけで、
それは $K/\mathbb{Q}$ が Galois であることの側から来る（本 file はそこを書いていない）。 -/

/-- **(R4)（$\Psi_M$ について組み上げた形）**。
$F\in\mathbb{Z}[x]$ について $F(\pi)\sim\pi^{t}$ なら
$\mathrm{Res}(\Psi_M,F)\sim\ell^{t}$ である。

`hconj` が唯一の外部入力で、「$\Psi_M$ の各根 $\alpha$ へ $\pi$ を送る環準同型がある」。
根の個数（段 4c）と根が $\pi$ と同伴であること（段 4c）は本 file が供給する。 -/
theorem associated_resultant_psi {R : Type*} [CommRing R] [IsDomain R]
    {ℓ M : ℕ} [Fact ℓ.Prime] {ζ : R} (hζ : IsPrimitiveRoot ζ (ℓ ^ (M + 1)))
    (F : ℤ[X]) (n : ℕ) {t : ℕ}
    (hF : (F.map (Int.castRingHom R)).natDegree ≤ n)
    (hΨ : ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).Monic)
    (hsplit : ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).Splits)
    (hval : Associated ((F.map (Int.castRingHom R)).eval (ζ - 1)) ((ζ - 1) ^ t))
    (hconj : ∀ α ∈ ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).roots,
      ∃ σ : R →+* R, σ (ζ - 1) = α) :
    Associated
      (((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).resultant (F.map (Int.castRingHom R))
        ((cyclotomic (ℓ ^ (M + 1)) R).comp (X + 1)).natDegree n)
      ((ℓ : R) ^ t) := by
  refine associated_resultant_pow_of_conj hζ _ _ n hF hΨ hsplit ?_ (card_roots_psi hζ)
  intro α hα
  obtain ⟨σ, hσ⟩ := hconj α hα
  exact associated_eval_of_hom F σ hσ (associated_root_psi hζ hα) hval

/-! ## 段 5: 整数の $\ell$ 進付値への翻訳

(R4) の結論は $\mathcal{O}_K$ の中の同伴だが、終結式は整数である。
整数として見たときの $\ell$ 進付値が $t$ であることを、同伴から取り出す。 -/

/-- $m\in\mathbb{Z}$ が $\mathcal{O}_K$ の中で $\ell^t$ と同伴なら、$\mathbb{Z}$ の中でも同伴である。

`hinj` は「$\mathbb{Z}\to\mathcal{O}_K$ が単射で、$\mathbb{Z}$ の元どうしの割り切りを反映する」という
仮定である（数体の整数環では成り立つ）。ここを仮定として受け取るのは、
本 file が Dedekind 環の理論を使わない方針だからである。 -/
theorem associated_int_of_associated_map {R : Type*} [CommRing R] (φ : ℤ →+* R)
    {m : ℤ} {ℓ : ℤ} {t : ℕ} (hrefl : ∀ a b : ℤ, φ a ∣ φ b → a ∣ b)
    (h : Associated (φ m) (φ (ℓ ^ t))) : Associated m (ℓ ^ t) := by
  refine associated_of_dvd_dvd (hrefl _ _ ?_) (hrefl _ _ ?_)
  · exact h.dvd
  · exact h.symm.dvd

/-- $m$ が $\mathbb{Z}$ の中で $\ell^t$ と同伴なら、その $\ell$ 進付値は $t$ である。
これが (R4) の結論「右辺は整数ひとつの $\ell$ 進付値である」を数で読む形にした主張。 -/
theorem padicValInt_eq_of_associated_pow {ℓ : ℕ} [hℓ : Fact ℓ.Prime] {m : ℤ} {t : ℕ}
    (h : Associated m ((ℓ : ℤ) ^ t)) : padicValInt ℓ m = t := by
  obtain ⟨u, hu⟩ := h
  have hune : (u : ℤ) = 1 ∨ (u : ℤ) = -1 := Int.isUnit_iff.mp u.isUnit
  have hm : m = (ℓ : ℤ) ^ t ∨ m = -((ℓ : ℤ) ^ t) := by
    rcases hune with h1 | h1
    · left; rw [← hu, h1, mul_one]
    · right; rw [← hu, h1]; ring
  -- どちらの符号でも絶対値は `ℓ ^ t` なので、`padicValInt` の定義から `t` になる。
  rcases hm with rfl | rfl <;>
    simp [padicValInt, Int.natAbs_pow]

/-! ## 段 6: (R5) の組み立て

(R5) は本文が「(J3) のレベル分解と (R4) を合わせるだけ」と書いているとおりの主張である。
入力（レベル分解と 命題 W の積の公式）は本論文の他所で証明されるものなので、
ここでは仮定として受け取り、**合わせる操作そのものが正しいこと**を型に出す。 -/

/-- **(R5)**。レベル分解と積の公式と (R4) を合わせると、
$\mathrm{ord}_\ell(\kappa_n)$ が $D$ の係数からの整数計算だけで書ける。

`hlevel` が 命題 J の (J3)（レベル分解、仮定なしに成立）、
`hprod` が 命題 W の証明にある積の公式、`hR4` が各レベル・各点での (R4) である。 -/
theorem ordEll_kappa_of_level_decomposition {n : ℕ} {ordKappa vKappa mu : ℤ}
    {Sigma : ℤ} {Theta : ℕ → ℤ} {pts : ℕ → Finset ℕ} {res : ℕ → ℕ → ℤ}
    (hlevel : Sigma = ∑ M ∈ Finset.Icc 1 n, Theta M)
    (hR4 : ∀ M ∈ Finset.Icc 1 n, Theta M = ∑ P ∈ pts M, res M P)
    (hprod : ordKappa = vKappa - 2 * n + mu + Sigma) :
    ordKappa = vKappa - 2 * n + mu + ∑ M ∈ Finset.Icc 1 n, ∑ P ∈ pts M, res M P := by
  rw [hprod, hlevel, Finset.sum_congr rfl hR4]

end PropRResultantValuation
end IntegrableLattice
