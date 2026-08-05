/-
# 命題 T の残り 1 段: 剰余体が原始 $L$ 乗根を持つこと — cycle 44 step 2

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の証明の段 3
（「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐、$w^2-A_jw+1$ が $\bmod\,P$ で相異なる 2 根に
分解し、Hensel で $r_j\equiv\zeta^j$ が取れる」）のうち、**舞台の根の側**。

## この step が何を埋めるか

* cycle 42 step 2（`PropTHenselLift.lean`）は持ち上げそのものを書いたが、
  「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つ」ことを仮定として受け取った。
* cycle 43 step 3（`HenselianStage.lean`）は **Hensel 性の側**を構成した。
* **残っていたのは根の側である**——$\zeta_L$ の剰余体での像が、なお位数 $L$ を保つこと。

## 中身は 1 行の恒等式である

本文は「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐」と書いている。
不分岐性の中身は、**$\zeta_L$ の像が剰余体でも位数 $L$ を保つこと**である。
それは次の恒等式ひとつから出る。

$$\prod_{k=1}^{L-1}\bigl(1-\zeta^{k}\bigr)=L .$$

$L$ が剰余体で $0$ でなければ（＝$L$ が $O$ の単元なら）左辺の各因子も単元であり、
したがって $1-\zeta^{k}$ は極大イデアルに入らない。すなわち剰余体で $\zeta^{k}\neq1$ が
$0<k<L$ の全てで成り立ち、像は位数 $L$ をもつ。

**恒等式そのものは mathlib に在る**（`IsPrimitiveRoot.prod_one_sub_pow_eq_order`。
`Mathlib/RingTheory/RootsOfUnity/Lemmas.lean` 33 行。2026-08-05 実測、mathlib `520045ab14`）。
**無いのは、そこから剰余体の側へ渡す段である**——剰余環へ落として原始性が保たれることを
述べた宣言は、代数体の整数環についてのもの（`IsPrimitiveRoot.idealQuotient_mk`、
`Mathlib/NumberTheory/NumberField/Ideal/Basic.lean` 90 行）しかなく、
**イデアルの絶対ノルムと $n$ が互いに素であることを要求する**ので、
局所環の極大イデアルへはそのまま当たらない。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは可換環の演算・剰余体への還元・単元性の判定だけである。
$L$ と $k$ は $\mathbb{N}$、判定はすべて有限の積と整除である。
（舞台となる局所環 $O$ 自身は非可算でありうるが、`PropTHenselLift.lean` と同じく
**$O$ の濃度は主張に入らない。**）

## 書いたこと（4 段）

1. **恒等式の各因子は単元である**（`isUnit_one_sub_pow`）。
   $L$ が単元なら、積が単元なので因子も単元である。
2. **剰余体での像は原始 $L$ 乗根である**（`isPrimitiveRoot_residue`）。
   段 1 から $0<k<L$ で $\zeta^{k}\neq1$ が剰余体で成り立ち、`IsPrimitiveRoot.mk_of_lt` が当たる。
3. **剰余体の標数が 2 なら、奇数は単元である**（`isUnit_natCast_of_odd`）。
   **これが本文の「$L$ 奇なら 2 は不分岐」の、単元性としての言い換えである。**
4. **仕上げ**（`isPrimitiveRoot_residue_of_odd` / `exists_root_congr_pow_of_odd_of_charTwo`）。
   `PropTHenselLift.exists_root_congr_pow_of_odd` が仮定として受け取っていた
   「剰余体が原始 $L$ 乗根を持つこと」が落ちる。

## 落とせなかった仮定（整域であること）

段 1 の恒等式は $X^{L}-1=\prod_k(X-\zeta^{k})$ から出るので整域が要る。
本文の舞台（局所体の整数環）は整域なので仮定は満たされるが、**落とせてはいない。そう書く。**

## 形式化しなかったもの

* **本文の $\mathbb{Q}(\zeta_L)$ の 2 の上での完備化が、この舞台の形をしていること。**
  本ファイルが受け取るのは「局所整域で、剰余体の標数が 2 で、$\zeta$ が原始 $L$ 乗根である」までで、
  円分体を 2 の上で完備化した結果がこの形であることは書いていない。
  **数論の側の同定であり、代数の側の段ではない。そう書く。**
  **着手前の残り項目は「舞台の剰余体が原始 $L$ 乗根を持つこと」だった。
  代数の側はここで入ったので、残っているのは舞台の同定だけになった。**
-/
import Mathlib
import IntegrableLattice.PropTHenselLift

namespace IntegrableLattice
namespace PropTResidueRoot

open Finset IsLocalRing

/-! ## 段 1: 恒等式の各因子は単元である -/

section Factors

variable {O : Type*} [CommRing O] [IsDomain O]

/-- **$0<k<L$ なら $1-\zeta^{k}$ は単元である**（$L$ が単元であるとき）。

$\prod_{k=1}^{L-1}(1-\zeta^{k})=L$ の因子だからである。 -/
theorem isUnit_one_sub_pow {ζ : O} {L : ℕ} (hζ : IsPrimitiveRoot ζ L)
    (hL : IsUnit (L : O)) {k : ℕ} (hk0 : 0 < k) (hkL : k < L) :
    IsUnit (1 - ζ ^ k) := by
  obtain ⟨m, rfl⟩ : ∃ m, L = m + 1 := ⟨L - 1, by omega⟩
  have hprod := hζ.prod_one_sub_pow_eq_order
  -- $k=j+1$ と書いて、その因子を積から取り出す
  obtain ⟨j, rfl⟩ : ∃ j, k = j + 1 := ⟨k - 1, by omega⟩
  have hjm : j ∈ range m := mem_range.mpr (by omega)
  have hsplit : (1 - ζ ^ (j + 1)) * ∏ i ∈ (range m).erase j, (1 - ζ ^ (i + 1))
      = ∏ i ∈ range m, (1 - ζ ^ (i + 1)) := Finset.mul_prod_erase (f := fun i => 1 - ζ ^ (i + 1)) _ hjm
  refine isUnit_of_mul_isUnit_left (y := ∏ i ∈ (range m).erase j, (1 - ζ ^ (i + 1))) ?_
  rw [hsplit, hprod]
  exact_mod_cast hL

end Factors

/-! ## 段 2: 剰余体での像は原始 $L$ 乗根である -/

section Residue

variable {O : Type*} [CommRing O] [IsDomain O] [IsLocalRing O]

/-- **$L$ が単元なら、$\zeta$ の剰余体での像は原始 $L$ 乗根のままである。**

段 1 から $0<k<L$ で $1-\zeta^{k}$ が単元、すなわち極大イデアルに入らないので、
剰余体で $\zeta^{k}\neq1$ である。 -/
theorem isPrimitiveRoot_residue {ζ : O} {L : ℕ} (hζ : IsPrimitiveRoot ζ L)
    (hL : IsUnit (L : O)) : IsPrimitiveRoot (residue O ζ) L := by
  have hL0 : 0 < L := by
    rcases Nat.eq_zero_or_pos L with h | h
    · exact absurd (h ▸ hL) (by simp)
    · exact h
  refine IsPrimitiveRoot.mk_of_lt _ hL0 ?_ ?_
  · rw [← map_pow, hζ.pow_eq_one, map_one]
  · intro k hk0 hkL hone
    have hu := isUnit_one_sub_pow hζ hL hk0 hkL
    have : residue O (1 - ζ ^ k) = 0 := by rw [map_sub, map_one, map_pow, hone, sub_self]
    exact (hu.map (residue O)).ne_zero this

end Residue

/-! ## 段 3: 剰余体の標数が 2 なら、奇数は単元である

**これが本文の「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐」の、単元性としての言い換えである。** -/

section CharTwo

variable {O : Type*} [CommRing O] [IsLocalRing O]

/-- **剰余体の標数が 2 の局所環では、奇数は単元である。** -/
theorem isUnit_natCast_of_odd [CharP (ResidueField O) 2] {L : ℕ} (hL : Odd L) :
    IsUnit (L : O) := by
  rw [← notMem_maximalIdeal, ← residue_eq_zero_iff]
  rw [map_natCast]
  exact (CharP.cast_eq_zero_iff (ResidueField O) 2 L).not.mpr
    (by simpa [Nat.odd_iff, Nat.two_dvd_ne_zero] using hL)

end CharTwo

/-! ## 段 4: 仕上げ（`PropTHenselLift` の舞台の仮定を落とす）

cycle 42 step 2 の結論は「剰余体が原始 $L$ 乗根を持つこと」を仮定として受け取っていた。
段 2・段 3 でそれが $L$ 奇・剰余体の標数 2 から出るので、**仮定が落ちる。** -/

section Capstone

variable {O : Type*} [CommRing O] [IsDomain O] [IsLocalRing O] [CharP (ResidueField O) 2]

/-- **$L$ 奇なら、原始 $L$ 乗根の剰余体での像は原始 $L$ 乗根のままである。**

**これが本文の「$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐」の中身である。** -/
theorem isPrimitiveRoot_residue_of_odd {ζ : O} {L : ℕ} (hL : Odd L)
    (hζ : IsPrimitiveRoot ζ L) : IsPrimitiveRoot (residue O ζ) L :=
  isPrimitiveRoot_residue hζ (isUnit_natCast_of_odd hL)

/-- **本文の段 3 の結論を、舞台の根の仮定なしで述べる。**

受け取るのは「$\zeta$ が $O$ の中で原始 $L$ 乗根であること」だけで、
剰余体での原始性は段 2・段 3 が与える。 -/
theorem exists_root_congr_pow_of_odd_of_charTwo [HenselianLocalRing O]
    (ζ : Oˣ) {L j : ℕ} (hL : Odd L) (hζ : IsPrimitiveRoot ((ζ : O)) L) (hj : ¬ L ∣ j) (A : O)
    (hA : A - (((ζ ^ j : Oˣ) : O) + (((ζ ^ j)⁻¹ : Oˣ) : O)) ∈ maximalIdeal O) :
    ∃ r : O, r ^ 2 - A * r + 1 = 0 ∧ r - ((ζ ^ j : Oˣ) : O) ∈ maximalIdeal O :=
  PropTHenselLift.exists_root_congr_pow_of_odd ζ hL (isPrimitiveRoot_residue_of_odd hL hζ) hj A hA

end Capstone

end PropTResidueRoot
end IntegrableLattice
