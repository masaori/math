/-
# 命題 T の段 3 の舞台を混標数で与える — cycle 46 step 3

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の証明の段 3
（$\mathbb{Q}(\zeta_L)$ の 2 の上での完備化の上で、$r^2-Ar+1=0$ の根を $\zeta^j$ の近くに取る段）。

## 掲げた焦点と、その答え（技術判断）

cycle 45 step 3 は「完備化の整数環が $\mathfrak m$ 進完備であること（`IsAdicComplete`）の宣言が
mathlib に無い」と実測し、**自分で書くかどうかを本サイクルの判断事項として残した。**

**測り直した。判断は「自分では書かない」である。書く必要が無いからである。そう書く**（2026-08-05 実測）。

**mathlib は $\mathfrak m$ 進完備性を持っている。無かったのは 1 つの綴りについてだけだった。**

| 綴り | `IsAdicComplete` | 場所 |
|---|---|---|
| Noether 局所環の $\mathfrak m$ 進完備化 | **在る**（インスタンス） | `RingTheory/AdicCompletion/LocalRing.lean` 127 行 |
| 完全体上の Witt ベクトル環 | **在る**（インスタンス） | `RingTheory/WittVector/Complete.lean` 116 行 |
| 非アルキメデス局所体の整数環 | **在る**（インスタンス） | `NumberTheory/LocalField/Basic.lean` 176 行 |
| 付値による完備化の整数環（`adicCompletionIntegers`） | **無い** | cycle 45 step 3 が測ったのはこれ |

**cycle 45 の実測そのものは正しい。誤っていたのは「だから素材が無い」という側である**——
要るのは「$\mathfrak m$ 進完備な混標数の離散付値環」であって、
それを付値による完備化の綴りで書く必要は無い。**綴りを変えれば在るものに当たる。**

## 何を書いたか（舞台を退化していない形で与える）

cycle 45 step 3 が与えた舞台（4 元体 $\mathbb{F}_4$）は**退化していた**——
極大イデアルが $0$ なので、段 3 の合同 $r\equiv\zeta^{j}$ は等号になる。
**本文が当てているのは混標数の舞台であって、これではない。**

本 file は**混標数の舞台を与える**。$\mathbb{F}_4$ 上の Witt ベクトル環 $W(\mathbb{F}_4)$ は
標数 $0$ の離散付値環で、剰余体が $\mathbb{F}_4$（標数 2）、極大イデアルは $(2)\neq0$ である。
**これは $\mathbb{Q}_2$ の不分岐 2 次拡大の整数環であり、$L=3$ のとき本文が当てている舞台そのものである**
（$\mathbb{Q}(\zeta_3)$ の 2 の上での完備化は $\mathbb{Q}_2(\zeta_3)=\mathbb{Q}_2$ の不分岐 2 次拡大）。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。Witt ベクトル環は有限体の列として構成され、
$\mathfrak m$ 進完備性も $2$ 冪の合同で書かれている。アルキメデス的な絶対値は現れない。

## 書いたこと（4 段）

1. **完備なら局所 Hensel 環である**（`henselianLocalRing_of_isAdicComplete`）。
   mathlib は `HenselianRing R I`（イデアルについての Hensel 性）までは持っているが、
   **局所環のクラス `HenselianLocalRing` へ渡す宣言が無い**（2026-08-05 実測。
   `HenselianLocalRing` は `RingTheory/Henselian.lean` の外に 1 度も現れない）。
   **書く量は 2 行である**——単元であることを剰余へ移すだけである。
2. **$W(k)$ の極大イデアルは $(p)$ である**（`maximalIdeal_wittVector`）。
   商が体（$\cong k$）なので $(p)$ は極大であり、局所環では極大イデアルは 1 つである。
3. **$W(k)$ は局所 Hensel 環である**（`henselianLocalRing_wittVector`）。段 1 と段 2 を繋ぐ。
4. **混標数の舞台**（`exists_root_on_wittVector` / `maximalIdeal_ne_bot`）。
   $\zeta$ は Teichmüller 持ち上げで取る（$W(\mathbb{F}_4)$ の中の 1 の原始 3 乗根）。
   **極大イデアルが $0$ でないことも書いた**——これが cycle 45 の舞台との違いである。

## 形式化しなかったもの

* **$\mathbb{Q}(\zeta_L)$ の完備化がこの舞台であることの同定**。本 file が与えるのは
  「本文の仮定を満たす混標数の舞台が実在する」ことであって、
  **本文の completion がその舞台と同型であることは書いていない。そう書く。**
  同型を書くには $\mathbb{Z}[\zeta_L]$ の 2 の上の素点での局所化と、
  その $\mathfrak m$ 進完備化が Witt ベクトル環に一致すること（不分岐性）が要る。
-/
import Mathlib
import IntegrableLattice.PropTResidueRoot
import IntegrableLattice.PropTStageWitness

namespace IntegrableLattice
namespace PropTMixedWitness

open IsLocalRing Polynomial

/-! ## 1. 完備なら局所 Hensel 環である -/

/-- **$\mathfrak m$ 進完備な局所環は局所 Hensel 環である。**

mathlib は `HenselianRing R I` までを持ち（`IsAdicComplete.henselianRing`）、
局所環のクラス `HenselianLocalRing` へ渡す宣言を持っていない（2026-08-05 実測）。
中身は「単元であることを剰余へ移す」だけである。 -/
theorem henselianLocalRing_of_isAdicComplete (R : Type*) [CommRing R] [IsLocalRing R]
    [IsAdicComplete (maximalIdeal R) R] : HenselianLocalRing R where
  is_henselian f hf a₀ h₁ h₂ :=
    HenselianRing.is_henselian (I := maximalIdeal R) f hf a₀ h₁
      (h₂.map (Ideal.Quotient.mk (maximalIdeal R)))

/-! ## 2–3. Witt ベクトル環 -/

section Witt

variable (p : ℕ) [hp : Fact p.Prime] (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- **$W(k)$ の極大イデアルは $(p)$ である。** 商が体なので $(p)$ は極大である。 -/
theorem maximalIdeal_wittVector :
    maximalIdeal (WittVector p k) = Ideal.span {(p : WittVector p k)} := by
  have hfield : IsField (WittVector p k ⧸ Ideal.span {(p : WittVector p k)}) :=
    MulEquiv.isField (Field.toIsField k)
      (WittVector.quotientPEquiv (p := p) (k := k)).toMulEquiv
  have hmax : (Ideal.span {(p : WittVector p k)}).IsMaximal :=
    Ideal.Quotient.maximal_of_isField _ hfield
  exact (eq_maximalIdeal hmax).symm

/-- **$W(k)$ は $\mathfrak m$ 進完備である**（極大イデアルの綴りで）。 -/
instance isAdicComplete_maximalIdeal_wittVector :
    IsAdicComplete (maximalIdeal (WittVector p k)) (WittVector p k) := by
  rw [maximalIdeal_wittVector p k]
  infer_instance

/-- **$W(k)$ は局所 Hensel 環である。** -/
theorem henselianLocalRing_wittVector : HenselianLocalRing (WittVector p k) :=
  henselianLocalRing_of_isAdicComplete _

end Witt

/-! ## 4. 混標数の舞台 -/

section Mixed

/-- $W(\mathbb{F}_4)$。$\mathbb{Q}_2$ の不分岐 2 次拡大の整数環である。 -/
abbrev O2 : Type := WittVector 2 (GaloisField 2 2)

instance : HenselianLocalRing O2 := henselianLocalRing_wittVector 2 (GaloisField 2 2)

/-- **剰余体は $\mathbb{F}_4$ で、標数は 2 である。** -/
instance : CharP (ResidueField O2) 2 := by
  have hiso : ResidueField O2 ≃+* GaloisField 2 2 :=
    RingEquiv.trans (Ideal.quotEquivOfEq (maximalIdeal_wittVector 2 (GaloisField 2 2)))
      (WittVector.quotientPEquiv (p := 2) (k := GaloisField 2 2))
  have : CharP (GaloisField 2 2) 2 := inferInstance
  exact charP_of_injective_ringHom (f := hiso.symm.toRingHom) hiso.symm.injective 2

/-- **極大イデアルは $0$ ではない**（cycle 45 step 3 の舞台との違いはここである）。

離散付値環は体ではないので（`IsDiscreteValuationRing.not_isField`）、極大イデアルは $0$ でない。 -/
theorem maximalIdeal_ne_bot : maximalIdeal O2 ≠ ⊥ := fun h =>
  IsDiscreteValuationRing.not_isField O2 (IsLocalRing.isField_iff_maximalIdeal_eq.mpr h)

/-- **$W(\mathbb{F}_4)$ の中の 1 の原始 3 乗根**（Teichmüller 持ち上げ）。

$\mathbb{F}_4$ の原始 3 乗根 $\omega$ を Teichmüller 写像で持ち上げる。
Teichmüller 写像は乗法的で単射（定数係数が元に戻る）なので、位数はそのまま移る。 -/
theorem exists_isPrimitiveRoot_three_O2 : ∃ ζ : O2, IsPrimitiveRoot ζ 3 := by
  obtain ⟨ω, hω⟩ := PropTStageWitness.exists_isPrimitiveRoot_three_galoisField
  refine ⟨WittVector.teichmuller 2 ((ω : GaloisField 2 2)), ?_⟩
  refine hω.map_of_injective (f := WittVector.teichmuller 2) ?_
  intro x y hxy
  have := congrArg (fun z : O2 => z.coeff 0) hxy
  simpa [WittVector.teichmuller_coeff_zero] using this

/-- **混標数の舞台の上で、段 3 の結論が実際に使える。**

cycle 45 step 3 の舞台（$\mathbb{F}_4$）は極大イデアルが $0$ の退化した舞台だった。
**こちらは $\mathbb{Q}_2$ の不分岐 2 次拡大の整数環で、極大イデアルは $(2)\neq0$ である。** -/
theorem exists_root_on_wittVector (ζ : O2ˣ) (hζ : IsPrimitiveRoot ((ζ : O2)) 3)
    {j : ℕ} (hj : ¬ (3 : ℕ) ∣ j) (A : O2)
    (hA : A - (((ζ ^ j : O2ˣ) : O2) + (((ζ ^ j)⁻¹ : O2ˣ) : O2)) ∈ maximalIdeal O2) :
    ∃ r : O2, r ^ 2 - A * r + 1 = 0 ∧ r - ((ζ ^ j : O2ˣ) : O2) ∈ maximalIdeal O2 :=
  PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo ζ ⟨1, by norm_num⟩ hζ hj A hA

end Mixed

end PropTMixedWitness
end IntegrableLattice
