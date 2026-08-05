/-
# 補題 W2 の (iv) ⇒ (iii)（バケツが全部消えるなら二項式で割れる）— cycle 48 step 3

対応する人手証明: 本文ブロック `paper_prop_K`（命題 K）の (K2)＝補題 W2 の同値のうち、
$\bar\psi_u(\bar{\tilde E})=0\Rightarrow(\chi^{u^\perp}-1)\mid\bar{\tilde E}$ の向き。

cycle 20 step 2（`SInfinityDecision.lean`）は逆向き（(iii) ⇒ (iv)）だけを書き、
この向きを「Laurent 多項式環の商が $\mathbb{F}_\ell[y^{\pm1}]$ になる座標変換が要る」として残していた。
cycle 47 step 3 は中身を 2 つに切り分けた——「$u$ が原始的なら $\bar\psi_u$ の核の指数が
$\mathbb{Z}u^\perp$ であること」と「$w=1$ での消滅が $(w-1)$ で割れることと同値であること」である。
**本 file はその 2 つを書き、繋ぐ。**

## まず測ったこと

**群環の準同型の核を拡大イデアルで書いた宣言は mathlib に無い**
（2026-08-05 実測、mathlib `520045ab14` の 8264 ファイル。cycle 47 step 3 の 3 段の走査で 0 件。
増加イデアル（augmentation ideal）は語幹で 1 件だけ当たるが、群環の増加イデアルが
$\{g-1\}$ で生成されることを述べた宣言ではない）。

**使えた素材は 2 つだけである**——`AddMonoidAlgebra.domCongr`（群の同型から係数環上の代数同型）と
`AddMonoidAlgebra.mapDomainRingHom`（加法準同型から環準同型）である。どちらも cycle 20 の時点で
「配線である」と書かれていたとおりに当たった。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\overline{\mathbb{Q}}$ へも出ない。
扱うのは $\mathbb{F}_\ell$ 係数の Laurent 多項式（指数が $\mathbb{Z}\times\mathbb{Z}$ の群環）と
整数の一次式だけで、すべて可算側である。

## 道筋（人手証明と 1 対 1）

1. **$u=(u_1,u_2)$ が原始的なら、指数の格子 $\mathbb{Z}^2$ の自己同型 $\varphi$ で
   $\varphi(u^\perp)=(0,1)$ かつ $\mathrm{fst}\circ\varphi=\langle\cdot,u\rangle$ となるものが取れる。**
   $u_1s+u_2t=1$ を満たす $s,t$ を取り、$\varphi(p,q)=(pu_1+qu_2,\ pt-qs)$ と置く。
   行列式が $-1$ なので自己同型である（逆写像を直接書く）。
2. **$\chi^{v}-1$ は $\chi^{qv}-1$ を割る**（$q\in\mathbb{Z}$）。$q$ についての整数の帰納法で、
   $\chi^{a+b}=\chi^{a}\chi^{b}$ しか使わない。
3. **第 2 変数を $1$ に潰す写像の核**は $(\chi^{(0,1)}-1)$ の生成するイデアルである。
   芯は $E-\iota(\mathrm{fst}_*E)=\sum_{(p,q)}c_{pq}\chi^{(p,0)}(\chi^{(0,q)}-1)$ という
   1 行の書き換えで、右辺の各項が段 2 で割れる。
4. **段 1 で座標を取り替えて、本文の向きを得る。**

## 書いたこと（4 段）

1. `latticeAut` / `latticeAut_apply_perp` / `fst_latticeAut` — 段 1。
2. `chi_sub_one_dvd_chi_zsmul_sub_one` — 段 2。
3. `dvd_of_mapDomain_fst_eq_zero` — 段 3。
4. `dvd_of_psi_eq_zero` — 段 4（本文の (iv) ⇒ (iii)）。および
   `psi_eq_zero_iff_dvd` — 補題 W2 の同値そのもの（cycle 20 の逆向きと合わせる）。

## 形式化しなかったもの

* **(iv) の判定と $S_\infty$ の点との対応**。本 file が与えるのは代数の同値までで、
  判定を通る $u$ が本文の $S_\infty$ の点であることは `SInfinityDecision.lean` の側の事柄である。
* **$j^*$（重複度）**。同値は「割れるか」までで、何回割れるかは (K4) の側である。
-/
import Mathlib
import IntegrableLattice.SInfinityDecision

namespace IntegrableLattice
namespace PropKW2Converse

open Finset AddMonoidAlgebra IntegrableLattice.SInfinity

variable {ℓ : ℕ}

/-! ## 段 1: 原始的な $u$ に対する格子の自己同型

$u_1s+u_2t=1$ から、$u^\perp$ を $(0,1)$ へ移す $\mathbb{Z}^2$ の自己同型を作る。 -/

section Lattice

variable {u : ℤ × ℤ} {s t : ℤ}

/-- $\varphi(p,q)=(pu_1+qu_2,\ pt-qs)$。$u_1s+u_2t=1$ のとき自己同型である。 -/
def latticeAut (u : ℤ × ℤ) (s t : ℤ) (h : u.1 * s + u.2 * t = 1) : (ℤ × ℤ) ≃+ (ℤ × ℤ) where
  toFun pq := (pq.1 * u.1 + pq.2 * u.2, pq.1 * t - pq.2 * s)
  invFun xy := (xy.1 * s + xy.2 * u.2, xy.1 * t - xy.2 * u.1)
  left_inv pq := by
    obtain ⟨p, q⟩ := pq
    show Prod.mk ((p * u.1 + q * u.2) * s + (p * t - q * s) * u.2)
        ((p * u.1 + q * u.2) * t - (p * t - q * s) * u.1) = (p, q)
    have h1 : (p * u.1 + q * u.2) * s + (p * t - q * s) * u.2 = p * (u.1 * s + u.2 * t) := by ring
    have h2 : (p * u.1 + q * u.2) * t - (p * t - q * s) * u.1 = q * (u.1 * s + u.2 * t) := by ring
    rw [h1, h2, h, mul_one, mul_one]
  right_inv xy := by
    obtain ⟨x, y⟩ := xy
    show Prod.mk ((x * s + y * u.2) * u.1 + (x * t - y * u.1) * u.2)
        ((x * s + y * u.2) * t - (x * t - y * u.1) * s) = (x, y)
    have h1 : (x * s + y * u.2) * u.1 + (x * t - y * u.1) * u.2 = x * (u.1 * s + u.2 * t) := by ring
    have h2 : (x * s + y * u.2) * t - (x * t - y * u.1) * s = y * (u.1 * s + u.2 * t) := by ring
    rw [h1, h2, h, mul_one, mul_one]
  map_add' a b := by
    simp only [Prod.fst_add, Prod.snd_add, Prod.mk_add_mk, Prod.mk.injEq]
    constructor <;> ring

/-- $\varphi(u^\perp)=(0,1)$。 -/
theorem latticeAut_apply_perp (h : u.1 * s + u.2 * t = 1) :
    latticeAut u s t h (u.2, -u.1) = (0, 1) := by
  show ((u.2 * u.1 + -u.1 * u.2 : ℤ), (u.2 * t - -u.1 * s : ℤ)) = (0, 1)
  have h1 : u.2 * u.1 + -u.1 * u.2 = (0 : ℤ) := by ring
  have h2 : u.2 * t - -u.1 * s = u.1 * s + u.2 * t := by ring
  rw [h1, h2, h]

/-- $\mathrm{fst}\circ\varphi=\langle\cdot,u\rangle$（本 file の `pair`）。 -/
theorem fst_latticeAut (h : u.1 * s + u.2 * t = 1) (pq : ℤ × ℤ) :
    (latticeAut u s t h pq).1 = pair u pq := rfl

end Lattice

/-! ## 段 2: $\chi^{v}-1$ は $\chi^{qv}-1$ を割る

整数の帰納法で、$\chi^{a+b}=\chi^{a}\chi^{b}$ しか使わない。 -/

theorem chi_mul_chi (a b : ℤ × ℤ) :
    (chi (ℓ := ℓ) a) * (chi b) = chi (a + b) := by
  simp [chi, AddMonoidAlgebra.single_mul_single]

theorem chi_zero : (chi (ℓ := ℓ) 0) = 1 := by
  simp [chi, AddMonoidAlgebra.one_def]

/-- **段 2**。$\chi^{v}-1\mid\chi^{qv}-1$。 -/
theorem chi_sub_one_dvd_chi_zsmul_sub_one (v : ℤ × ℤ) (q : ℤ) :
    (chi (ℓ := ℓ) v - 1) ∣ (chi (q • v) - 1) := by
  induction q using Int.induction_on with
  | zero => simp [chi_zero]
  | succ n ih =>
    have hsucc : ((n : ℤ) + 1) • v = (n : ℤ) • v + v := by
      rw [add_smul, one_smul]
    rw [hsucc, ← chi_mul_chi]
    have : (chi (ℓ := ℓ) ((n : ℤ) • v)) * (chi v) - 1
        = (chi ((n : ℤ) • v)) * (chi v - 1) + (chi ((n : ℤ) • v) - 1) := by ring
    rw [this]
    exact dvd_add (Dvd.dvd.mul_left ⟨1, by ring⟩ _) ih
  | pred n ih =>
    have hpred : (-(n : ℤ) - 1) • v + v = (-(n : ℤ)) • v := by
      rw [sub_smul, one_smul]
      ring
    have hchi : (chi (ℓ := ℓ) ((-(n : ℤ) - 1) • v)) * (chi v) = chi ((-(n : ℤ)) • v) := by
      rw [chi_mul_chi, hpred]
    have : (chi (ℓ := ℓ) ((-(n : ℤ) - 1) • v)) - 1
        = (chi ((-(n : ℤ) - 1) • v)) * (1 - chi v) + (chi ((-(n : ℤ)) • v) - 1) := by
      rw [← hchi]; ring
    rw [this]
    refine dvd_add (Dvd.dvd.mul_left ⟨-1, by ring⟩ _) ih

/-! ## 段 3: 第 2 変数を潰す写像の核

芯は $E-\iota(\mathrm{fst}_*E)=\sum_{(p,q)}c_{pq}\chi^{(p,0)}(\chi^{(0,q)}-1)$ の 1 行である。 -/

section Fst

/-- 第 1 座標を取る写像。 -/
def fstFun : (ℤ × ℤ) → (ℤ × ℤ) := fun a => (a.1, 0)

/-- `mapDomain` を台の上の和として書く（`Finsupp.mapDomain` の定義そのもの）。 -/
theorem mapDomain_eq_sum (g : ℤ × ℤ → ℤ × ℤ) (F : LaurentF ℓ) :
    AddMonoidAlgebra.mapDomain g F
      = ∑ a ∈ F.coeff.support, AddMonoidAlgebra.single (g a) (F.coeff a) := by
  classical
  ext n
  simp [AddMonoidAlgebra.mapDomain, Finsupp.mapDomain, Finsupp.sum,
    AddMonoidAlgebra.coeff_single, Finsupp.single_apply]

/-- `mapDomain` の合成。 -/
theorem mapDomain_compFun (g₁ : ℤ × ℤ → ℤ × ℤ) (g₂ : ℤ × ℤ → ℤ × ℤ) (F : LaurentF ℓ) :
    AddMonoidAlgebra.mapDomain g₂ (AddMonoidAlgebra.mapDomain g₁ F)
      = AddMonoidAlgebra.mapDomain (g₂ ∘ g₁) F := by
  classical
  show AddMonoidAlgebra.ofCoeff (Finsupp.mapDomain g₂ (Finsupp.mapDomain g₁ F.coeff))
    = AddMonoidAlgebra.ofCoeff (Finsupp.mapDomain (g₂ ∘ g₁) F.coeff)
  rw [← Finsupp.mapDomain_comp]

/-- **段 3**。第 2 変数を $1$ に潰す写像（$\bar\psi_{(1,0)}$）の核は
$(\chi^{(0,1)}-1)$ の生成するイデアルに含まれる。 -/
theorem dvd_of_mapDomain_fst_eq_zero (E : LaurentF ℓ)
    (h : AddMonoidAlgebra.mapDomain fstFun E = 0) :
    (chi (ℓ := ℓ) (0, 1) - 1) ∣ E := by
  classical
  -- 台の上で 1 項ずつ分ける。
  have hterm : ∀ a : ℤ × ℤ, ∀ c : ZMod ℓ,
      (AddMonoidAlgebra.single a c : LaurentF ℓ)
        = (AddMonoidAlgebra.single (fstFun a) c) * (chi (ℓ := ℓ) (0, a.2) - 1)
          + AddMonoidAlgebra.single (fstFun a) c := by
    intro a c
    have hmul : (AddMonoidAlgebra.single (fstFun a) c : LaurentF ℓ) * (chi (0, a.2))
        = AddMonoidAlgebra.single a c := by
      show (AddMonoidAlgebra.single (a.1, (0 : ℤ)) c) * (AddMonoidAlgebra.single (0, a.2) (1 : ZMod ℓ))
        = AddMonoidAlgebra.single a c
      rw [AddMonoidAlgebra.single_mul_single]
      simp
    rw [mul_sub, hmul, mul_one]
    ring
  have hE : E = ∑ a ∈ E.coeff.support, (AddMonoidAlgebra.single a (E.coeff a) : LaurentF ℓ) := by
    conv_lhs => rw [← AddMonoidAlgebra.sum_coeff_single E]
    rfl
  have hsplit : E = (∑ a ∈ E.coeff.support,
        (AddMonoidAlgebra.single (fstFun a) (E.coeff a) : LaurentF ℓ)
          * (chi (ℓ := ℓ) (0, a.2) - 1))
      + AddMonoidAlgebra.mapDomain fstFun E := by
    rw [mapDomain_eq_sum, ← Finset.sum_add_distrib]
    conv_lhs => rw [hE]
    exact Finset.sum_congr rfl fun a _ => hterm a (E.coeff a)
  rw [hsplit, h, add_zero]
  refine Finset.dvd_sum fun a _ => Dvd.dvd.mul_left ?_ _
  have hsm : ((0 : ℤ), a.2) = a.2 • ((0 : ℤ), (1 : ℤ)) := by
    simp
  rw [hsm]
  exact chi_sub_one_dvd_chi_zsmul_sub_one _ _

end Fst

/-! ## 段 4: 座標を取り替えて本文の向きを得る -/

section Main

variable {u : ℤ × ℤ} {s t : ℤ}

/-- **補題 W2 の (iv) ⇒ (iii)**。$u$ が原始的（$u_1s+u_2t=1$）で $\bar\psi_u(E)=0$ ならば
$(\chi^{u^\perp}-1)\mid E$ である。 -/
theorem dvd_of_psi_eq_zero (h : u.1 * s + u.2 * t = 1) (E : LaurentF ℓ)
    (hE : psiHom u E = 0) : (chi (ℓ := ℓ) (u.2, -u.1) - 1) ∣ E := by
  classical
  set φ := latticeAut u s t h with hφ
  set Φ := AddMonoidAlgebra.domCongr (ZMod ℓ) (ZMod ℓ) φ with hΦ
  have hΦapp : ∀ x : LaurentF ℓ,
      (Φ x : LaurentF ℓ) = AddMonoidAlgebra.mapDomain (φ : (ℤ × ℤ) → (ℤ × ℤ)) x := fun _ => rfl
  -- $\bar\psi_u$ は「$\varphi$ で座標を取り替えてから第 1 変数だけ残す」ことである。
  have hkey : AddMonoidAlgebra.mapDomain fstFun (Φ E) = 0 := by
    have hfun : (fstFun ∘ (φ : (ℤ × ℤ) → (ℤ × ℤ))) = fun a => ((pair u a : ℤ), (0 : ℤ)) := by
      funext a
      rfl
    rw [hΦapp, mapDomain_compFun, hfun]
    -- $\bar\psi_u(E)=0$ を第 1 座標へ埋め込む。
    have hpsi : AddMonoidAlgebra.mapDomain (fun a => ((pair u a : ℤ), (0 : ℤ))) E
        = AddMonoidAlgebra.mapDomain (fun p : ℤ => (p, (0 : ℤ)))
            (AddMonoidAlgebra.mapDomain (pair u) E) := by
      show _ = AddMonoidAlgebra.ofCoeff
        (Finsupp.mapDomain (fun p : ℤ => (p, (0 : ℤ))) (Finsupp.mapDomain (pair u) E.coeff))
      rw [← Finsupp.mapDomain_comp]
      rfl
    rw [hpsi]
    have : AddMonoidAlgebra.mapDomain (pair u) E = psiHom (ℓ := ℓ) u E := rfl
    rw [this, hE]
    show AddMonoidAlgebra.ofCoeff (Finsupp.mapDomain (fun p : ℤ => (p, (0 : ℤ))) (0 : ℤ →₀ ZMod ℓ))
      = 0
    rw [Finsupp.mapDomain_zero]
    rfl
  obtain ⟨H, hH⟩ := dvd_of_mapDomain_fst_eq_zero (Φ E) hkey
  refine ⟨Φ.symm H, ?_⟩
  have hchi : Φ.symm (chi (ℓ := ℓ) (0, 1)) = chi (ℓ := ℓ) (u.2, -u.1) := by
    have hfwd : Φ (chi (ℓ := ℓ) (u.2, -u.1)) = chi (ℓ := ℓ) (0, 1) := by
      rw [hΦapp]
      show AddMonoidAlgebra.mapDomain (φ : (ℤ × ℤ) → (ℤ × ℤ))
        (AddMonoidAlgebra.single (u.2, -u.1) (1 : ZMod ℓ)) = _
      rw [AddMonoidAlgebra.mapDomain_single, hφ, latticeAut_apply_perp h]
      rfl
    rw [← hfwd, AlgEquiv.symm_apply_apply]
  calc E = Φ.symm (Φ E) := (AlgEquiv.symm_apply_apply Φ E).symm
    _ = Φ.symm ((chi (ℓ := ℓ) (0, 1) - 1) * H) := by rw [hH]
    _ = (Φ.symm (chi (ℓ := ℓ) (0, 1)) - 1) * Φ.symm H := by
        rw [map_mul, map_sub, map_one]
    _ = (chi (ℓ := ℓ) (u.2, -u.1) - 1) * Φ.symm H := by rw [hchi]

/-- **補題 W2 の同値そのもの**（cycle 20 の (iii) ⇒ (iv) と本 file の逆向きを合わせる）。 -/
theorem psi_eq_zero_iff_dvd (h : u.1 * s + u.2 * t = 1) (E : LaurentF ℓ) :
    psiHom u E = 0 ↔ (chi (ℓ := ℓ) (u.2, -u.1) - 1) ∣ E :=
  ⟨dvd_of_psi_eq_zero h E, SInfinity.psi_eq_zero_of_dvd u E⟩

end Main

end PropKW2Converse
end IntegrableLattice
